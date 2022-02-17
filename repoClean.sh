#!/bin/sh
cd /Users/Journey/Documents/GitHub/repo_branch_pruning
for branch in $(git branch -a | sed 's/^\s*//' | sed 's/^remotes\///' | grep -v 'master$'); do
  if ! ([[ -f "$branch" ]] || [[ -d "$branch" ]]) && [[ "$(git log $branch --since "1 minute ago" | wc -l)" -eq 0 ]]; then
    local_branch_name=$(echo "$branch")
    git branch -d "${local_branch_name}"
    git push origin --delete "${local_branch_name}"
  fi
done
