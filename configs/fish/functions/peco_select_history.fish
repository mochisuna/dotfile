# `peco_select_history (option: args)` or `ctrl+r`
function peco_select_history
  if test (count $argv) = 0
    set peco_flags --layout=bottom-up
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read cmd

  if [ $cmd ]
    commandline $cmd
  else
    commandline ''
  end
end
