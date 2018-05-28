function glog {
    git log --graph --all --oneline
}

function gmcd {
    param(
        $dev,
        $beta
    )

    $working = git branch |Select-String "\*"  | % {$_.Line.Trim("*", " ")}
    git fetch origin

    $match = git branch --all | Select-String "\s+remotes/origin/$working$" 
    # update working and push
    if ($match.count -eq 1 ){
        Write-Output "remote $working exist, pull first"
        git pull origin $working
    }
    git push origin $working
    

    # checkout & update dev 
    # merge working to dev
    # push dev

    tryCheckout($dev)
    git merge $working
    git push origin $dev

    # checkout & update beta
    # merge dev to beta
    # push beta
    tryCheckout($beta)
    git merge $dev
    git push origin $beta
    
    git checkout $working
}

function gmb {
    param(
        $beta
    )
    $working = git branch |Select-String "\*"  | % {$_.Line.Trim("*", " ")}
    git fetch origin

    $match = git branch --all | Select-String "\s+remotes/origin/$working$" 
    # update working and push
    if ($match.count -eq 1 ){
        Write-Output "remote $working exist, pull first"
        git pull origin $working
    }
    git push origin $working

    # checkout & update beta
    # merge dev to beta
    # push beta
    tryCheckout($beta)
    git merge $working
    git push origin $beta
    
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
        Write-Output "$branch 本地有，远程有 ,checkout pull"
        git checkout $branch
        git pull origin $branch
    }
    elseif (($local -eq 0 ) -and ($remote -eq 1) ) {
        Write-Output "$branch 本地无，远程有 ,checkout remote"
        git checkout origin/$branch -b $branch
    }
    elseif (($local -eq 0) -and ($remote -eq 0) ) {
        Write-Output "$branch 本地无，远程无 ,checkout -b only"
        git checkout master -b $branch
    }
    elseif (($local -eq 1) -and ($remote -eq 0) ) {
        Write-Output "$branch 本地有，远程无 ,checkout only"
        git checkout $branch
    }
    else {
        Write-Error "WTF the count doest not match, branch: $branch, local: $local, remote: $remote"
    }
}