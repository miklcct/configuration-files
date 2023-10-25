# Defined in /usr/share/fish/functions/prompt_login.fish @ line 1
function prompt_login --description 'display user name for the prompt'
    set -l initial $argv[1]
    if functions -q fish_is_root_user; and fish_is_root_user
        set -f __is_root
    end
    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -e __is_root
        set color_host $fish_color_host_root
    end
    if set -q SSH_TTY; and set -q fish_color_host_remote
        set color_host $fish_color_host_remote
        if set -e __is_root
            if set -q fish_color_host_remote_root
                set color_host $fish_color_host_remote_root
            end
        end
    end

    echo -n -s (set_color $fish_color_user) "$USER" (set_color $initial) @ (set_color $color_host) (prompt_hostname) (set_color $initial)
end
