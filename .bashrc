# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    fi
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if
    [ -r ~/.colours ]
then
    . ~/.colours
fi

GIT_PS1_SHOWDIRTYSTATE=1 # show unstaged and staged changes
GIT_PS1_SHOWSTASHSTATE=1 # show existence of stashes
GIT_PS1_SHOWUPSTREAM=auto # show upstream status
GIT_PS1_HIDE_IF_PWD_IGNORED=1 # hide git prompt in ignored folder

if
    is_administrator
then
    administrator=true
    # \$ does not work on Windows
    prompt='#'
else
    prompt='$'
fi

get_exit_status() {
    exit_status=("${PIPESTATUS[@]}")
    if [[ ${exit_status[-1]} != 0 ]]
    then
        IFS='|'
        echo " $1[${exit_status[*]}]"
    fi
}

if [ "$color_prompt" = yes ]; then
    wd_colour=$bldblu
    GIT_PS1_SHOWCOLORHINTS=1

    if
        [ ! -z "$administrator" ]
    then
        prompt_colour=$txtred
        command_colour=$bldpur
    elif
        # if the shell is started using sudo
        [ ! -z "$SUDO_UID" ] && [ "$EUID" != "$SUDO_UID" ]
    then
        prompt_colour=$txtylw
        command_colour=$bldwht
    else
        # if the shell is running as myself
        prompt_colour=$txtgrn
        command_colour=$bldylw
    fi

    if
        [ ! -z "$SSH_CONNECTION" ] || [ ! -z "$SSH_CLIENT" ] || [ ! -z "$SSH_TTY" ]
    then
        # highlight the host for remote shell
        if
            [ ! -z "$administrator" ]
        then
            host_colour=$bldcyn
        else
            host_colour=$bldpur
        fi
    else
        host_colour=$prompt_colour
    fi


    GIT_PS1_ARG1="\[$prompt_colour\][\u@\[$host_colour\]\h \[$wd_colour\]\w\[$txtrst\]"
    exit_status='$(get_exit_status $txtred)'
    GIT_PS1_ARG2="$exit_status\[$prompt_colour\]]$prompt \[$command_colour\]"

    # reset the colour after entering the prompt
    trap 'echo -ne "\e[0m"' DEBUG
else
    GIT_PS1_ARG1="[\u@\h \w"
    get_exit_status() {
        exit_status=$?
        if [[ $exit_status != 0 ]]
        then
            echo " [$exit_status]"
        fi
    }
    exit_status='$(get_exit_status)'
    GIT_PS1_ARG2="$exit_status]$prompt "
fi

if
    [ ! -z "$debian_chroot" ]
then
    # prepend the chroot if running inside
    GIT_PS1_ARG1="$txtylw(chroot:$debian_chroot)$txtrst $GIT_PS1_ARG1"
fi

if
    ! type __git_ps1 >/dev/null 2>&1
then
    # attempt to load __git_ps1 from ~/.git-prompt.sh
    if
        [ -f ~/.git-prompt.sh ] && [ -r ~/.git-prompt.sh ]
    then
        . ~/.git-prompt.sh
    fi
fi

if
    ! type __git_ps1 >/dev/null 2>&1
then
    # use a stub
    __git_ps1() {
        PS1="$1$2"
    }
fi

__show_prompt() {
    __git_ps1 "$@"

    # If this is an xterm set the title to [user@host dir]
    case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;${debian_chroot:+($debian_chroot)}[\u@\h \w]\a\]$PS1"
            ;;
        *)
            ;;
    esac
}

PROMPT_COMMAND="__show_prompt \"$GIT_PS1_ARG1\" \"$GIT_PS1_ARG2\""
unset color_prompt force_color_prompt wd_colour prompt_colour command_colour \
    host_colour GIT_PS1_ARG1 GIT_PS1_ARG2 administrator

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Have some fun
if
    type fortune > /dev/null 2>&1
then
    fortune -a
fi

if
    [ "$USER" != "root" ]
then
    export HOME=$(eval echo ~$USER)
fi
