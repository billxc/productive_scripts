function glog {
    git log --graph --all --oneline
}

function gmcd {
    $working = git branch |Select-String "\*"  | % {$_.Line.Trim("*", " ")}
    echo "working is $working"
    $dev = $args[0]
    echo "dev is $dev"
    $beta = $args[1]
    echo "beta is $beta"
    echo "git pull origin $working"
    echo "git push origin $working"

    echo "git checkout $dev"
    echo "git pull origin $dev"
    echo "git merge $working"
    echo "git push origin $dev"
    
    echo "git checkout $beta"
    echo "git pull origin $beta"
    echo "git merge $dev"
    echo "git push origin $beta"
    
    echo "git checkout $working"
}