function fish_prompt --description 'Write out the prompt'
	set color_cwd $fish_color_param
    set suffix '>'
    if test -z $WINDOW
        echo (set_color $color_cwd)'['(date "+$c2%H$c0:$c2%M$c0:$c2%S")']'(set_color normal):(set_color $fish_color_cwd)(prompt_pwd)(set_color normal)" $suffix "
    else
        echo (set_color $color_cwd)'['(date "+$c2%H$c0:$c2%M$c0:$c2%S")']'(set_color normal)'('(echo $WINDOW)')'(set_color $fish_color_cwd)(prompt_pwd)(set_color normal)" $suffix "
    end
end
