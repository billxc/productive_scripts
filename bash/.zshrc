# code will open the target directory/file in VS Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

push_head(){
  echo 'git push origin $(git rev-parse --abbrev-ref HEAD)'
  git push origin $(git rev-parse --abbrev-ref HEAD)
}

alias pullhead='git pull origin $(git rev-parse --abbrev-ref HEAD)'

# gitc will commit with a message, no need to type git commit -m, just gitc
# not quotes around the commit message
gitc() {
    msg="$1${2:+ $2}${3:+ $3}${4:+ $4}${5:+ $5}${6:+ $6}${7:+ $7}${8:+ $8}${9:+ $9}${10:+ $10}${11:+ $11}${12:+ $12}${13:+ $13}${14:+ $14}${15:+ $15}"
    echo "commit message:  $msg"
    git commit -m "$1${2:+ $2}${3:+ $3}${4:+ $4}${5:+ $5}${6:+ $6}${7:+ $7}${8:+ $8}${9:+ $9}${10:+ $10}${11:+ $11}${12:+ $12}${13:+ $13}${14:+ $14}${15:+ $15}"
}

# gnb will create a new branch and switch to it
gnb() {
    branch_name="branch_prefix/$1${2:+_$2}${3:+_$3}${4:+_$4}${5:+_$5}${6:+_$6}${7:+_$7}${8:+_$8}${9:+_$9}${10:+_$10}${11:+_$11}${12:+_$12}${13:+_$13}${14:+_$14}${15:+_$15}"
    echo "branch name:  $branch_name"
    git checkout -b "$branch_name"
}

# gnbm will create a new branch from origin/main, and switch to it
gnbm() {
    branch_name="branch_prefix/$1${2:+_$2}${3:+_$3}${4:+_$4}${5:+_$5}${6:+_$6}${7:+_$7}${8:+_$8}${9:+_$9}${10:+_$10}${11:+_$11}${12:+_$12}${13:+_$13}${14:+_$14}${15:+_$15}"
    echo "branch name:  $branch_name"
    git fetch origin/main
    git checkout origin/main -b "$branch_name"
}

# gs will pop up a list of branches, 
# and you can select one to switch to
# note: you need to install fzf first
gs(){
  git branch | fzf | read branch_name
  if [ -n $branch_name ]; then
    echo git switch $branch_name
    git switch $branch_name  
  else
    echo "First parameter not supplied."
  fi
}

# x it will show a list of commands in directory ~/.commands/,
# and you can select one with fzf search, and then execute it
# usaga: x <keyword>  or x (no argument needed)
# that contains the keyword
# note: you need to install fzf first
x(){
  if [ -z "$1" ]
    then
      ls ~/.commands/ | fzf | read cmd_file
  else
      ls ~/.commands/ | fzf -q $1 | read cmd_file
  fi
  echo $cmd_file > ~/.commands/.x_last_select
  source ~/.commands/$cmd_file
}

# xx will rerun the last command selected by x
xx(){
  cmd_file=$(<~/.commands/.x_last_select)
  echo $cmd_file
  source ~/.commands/$cmd_file
}