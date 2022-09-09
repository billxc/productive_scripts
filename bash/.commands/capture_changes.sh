#!/bin/zsh
# this script works with add_changes.sh
# it captures the changes in the current git repo
# and save them to a file

# get git root
git_root=$(git rev-parse --show-toplevel)

# get changed files of current HEAD
files=$(git status --porcelain | awk -v gr="$git_root" '{print gr "/"  $2}')

# save list to .git folder
echo "$files" > $git_root/.git/captured_change_list.txt

echo "Captured change list to $git_root/.git/captured_change_list.txt"