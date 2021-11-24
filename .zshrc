code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

push_head(){
  echo 'git push origin $(git rev-parse --abbrev-ref HEAD)'
  git push origin $(git rev-parse --abbrev-ref HEAD)
}

alias pullhead='git pull origin $(git rev-parse --abbrev-ref HEAD)'

gitc() {
    msg="$1${2:+ $2}${3:+ $3}${4:+ $4}${5:+ $5}${6:+ $6}${7:+ $7}${8:+ $8}${9:+ $9}${10:+ $10}${11:+ $11}${12:+ $12}${13:+ $13}${14:+ $14}${15:+ $15}"
    echo "commit message:  $msg"
    git commit -m "$1${2:+ $2}${3:+ $3}${4:+ $4}${5:+ $5}${6:+ $6}${7:+ $7}${8:+ $8}${9:+ $9}${10:+ $10}${11:+ $11}${12:+ $12}${13:+ $13}${14:+ $14}${15:+ $15}"
}
gnb() {
    branch_name="user/xiaocw/$1${2:+_$2}${3:+_$3}${4:+_$4}${5:+_$5}${6:+_$6}${7:+_$7}${8:+_$8}${9:+_$9}${10:+_$10}${11:+_$11}${12:+_$12}${13:+_$13}${14:+_$14}${15:+_$15}"
    echo "branch name:  $branch_name"
    git checkout -b "$branch_name"
}

gnbm() {
    branch_name="user/xiaocw/$1${2:+_$2}${3:+_$3}${4:+_$4}${5:+_$5}${6:+_$6}${7:+_$7}${8:+_$8}${9:+_$9}${10:+_$10}${11:+_$11}${12:+_$12}${13:+_$13}${14:+_$14}${15:+_$15}"
    echo "branch name:  $branch_name"
    git fetch origin/main
    git checkout origin/main -b "$branch_name"
}