if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_postexec --on-event fish_prompt
    if test $CMD_DURATION -gt 500
        set --export --global CMD_DURATION_STR (math --scale=1 $CMD_DURATION / 1000)s
    else
        set --erase CMD_DURATION_STR
    end
    # avoid the duration being shown more than once
    # (this can happen when pressing Enter without entering a command)
    set CMD_DURATION 0
end

set fish_function_path $fish_function_path /home/wildug/.local/lib/python3.8/site-packages/powerline/bindings/fish


powerline-setup


