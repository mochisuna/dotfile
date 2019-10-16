# `sshc (option: file_name)`
function sshc
    set conf "$HOME/.ssh/config"
    if test (count $argv) = 0
        echo 'default'
    else
        set conf $argv[1]
        echo $conf
    end
    set host (grep 'Host ' $conf | awk '{print $2}' | peco)
    if test $conf
        echo "ssh -F $conf $host"
        ssh -F $conf $host
    end
end
