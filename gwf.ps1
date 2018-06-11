function glog {
    git log --graph --all --oneline
}

# git merge current branch to dev, then push ,then merge to beta, then push
function gmdb {
    param(
        $dev,
        $beta
    )

    $working = git branch |Select-String "\*"  | % {$_.Line.Trim("*", " ")}
    write-green "git fetch origin"
    git fetch origin

    $match = git branch --all | Select-String "\s+remotes/origin/$working$" 
    # update working and push
    if ($match.count -eq 1 ){
        write-green "remote $working exist, git pull origin $working"
        git pull origin $working
    }
    write-green "git push origin $working"
    git push origin $working
    

    # checkout & update dev 
    # merge working to dev
    # push dev

    tryCheckout($dev)
    write-green "git merge $working"
    git merge $working
    write-green "git push origin $dev"
    git push origin $dev


    # checkout & update beta
    # merge dev to beta
    # push beta
    tryCheckout($beta)
    write-green "git merge $dev"
    git merge $dev
    write-green "git push origin $beta"
    git push origin $beta
    
    write-green "git checkout $working"
    git checkout $working
    
}

# git merge current branch to beta, then push
function gmb {
    param(
        $beta
    )
    $working = git branch |Select-String "\*"  | % {$_.Line.Trim("*", " ")}
    write-green "git fetch origin"
    git fetch origin

    $match = git branch --all | Select-String "\s+remotes/origin/$working$" 
    # update working and push
    if ($match.count -eq 1 ){
        write-green "remote $working exist, git pull origin $working"
        git pull origin $working
    }
    write-green "git push origin $working"
    git push origin $working

    # checkout & update beta
    # merge dev to beta
    # push beta
    tryCheckout($beta)
    write-green "git merge $working"
    git merge $working
    write-green "git push origin $beta"
    git push origin $beta
    
    write-green "git checkout $working"
    git checkout $working
    
}


function tryCheckout($branch) {
    $localMatch = git branch --all | Select-String "\s+$branch$"
    $remoteMatch = git branch --all | Select-String "\s+remotes/origin/$branch$"
    $local = $localMatch.count
    $remote = $remoteMatch.count
    # 本地有，远程有 ,checkout pull
    # 本地无，远程有 ,checkout remote
    # 本地无，远程无 ,checkout -b only
    # 本地有，远程无 ,checkout only
    if (($local -eq 1) -and ($remote -eq 1) ) {
        write-green "$branch 本地有，远程有, git checkout $branch, git pull origin $branch"
        git checkout $branch
        git pull origin $branch
    }
    elseif (($local -eq 0 ) -and ($remote -eq 1) ) {
        write-green "$branch 本地无，远程有, git checkout origin/$branch -b $branch"
        git checkout origin/$branch -b $branch
    }
    elseif (($local -eq 0) -and ($remote -eq 0) ) {
        write-green "$branch 本地无，远程无, git checkout master -b $branch"
        git checkout master -b $branch
    }
    elseif (($local -eq 1) -and ($remote -eq 0) ) {
        write-green "$branch 本地有，远程无, git checkout $branch"
        git checkout $branch
    }
    else {
        Write-Error "WTF the count doest not match, branch: $branch, local: $local, remote: $remote"
    }
}


function write-green(){
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = 'Green'
    if ($args) {
        Write-Output $args
    }
    else {
        $input | Write-Output
    }
    $host.UI.RawUI.ForegroundColor = $fc
}