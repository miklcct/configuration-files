set __fish_git_prompt_describe_style branch
set __fish_git_prompt_showcolorhints 1
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_showstashstate 1
set __fish_git_prompt_showupstream auto
set fish_prompt_pwd_dir_length 0
set -e fish_color_user
set -e fish_color_host
set fish_color_host_remote brpurple
set fish_color_prompt green
set fish_color_prompt_sudo yellow
set fish_color_prompt_root red
set fish_color_cwd brblue
set -e fish_color_cwd_sudo
set -e fish_color_cwd_root

abbr --add rm "rm -i"
abbr --add cp "cp -i"
abbr --add mv "mv -i"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
