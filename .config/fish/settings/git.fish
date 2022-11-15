function gb -d "Git checkout branch"
  set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf)
  git checkout $branch
end

function gb -d "Git push branch to origin server"
  set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf)
  git push origin $branch
end

function gu -d "Git pull branch to origin server"
  set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf)
  git pull origin $branch
end

function ga -d "Git add files to stage"
  # ref: https://stackoverflow.com/questions/5237605/how-can-i-run-git-status-and-just-get-the-filenames
  set file_name (git status --porcelain | sed s/^...// | fzf --preview="cat {}" )
  git add $file_name
end
