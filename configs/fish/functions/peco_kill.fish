# `peco_kill (option: args)` or `ctrl+k`
function peco_kill
  if test (count $argv) = 0
    set peco_flags
  else
    set peco_flags --query "$argv"
  end

  ps ax -o pid,time,command | peco $peco_flags | awk '{print $1}' | xargs kill
end
