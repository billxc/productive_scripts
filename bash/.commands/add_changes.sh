#!/bin/zsh
# this script works with capture_changes.sh
# it adds the changes in the current git repo,
# which is captured by capture_changes.sh

# get git root
git_root=$(git rev-parse --show-toplevel)

captured_file="$git_root/.git/captured_change_list.txt"

echo "file list:"
cat $captured_file 

# git add muliple files
cat $captured_file | xargs git add
echo "added."
