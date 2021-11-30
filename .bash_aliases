# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l.='ls -d .*'
#alias l='ls -CF'

# aliases to prevent making mistakes
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# check if administrative privileges are available
is_administrator() {
    case "$(uname -s)" in
        CYGWIN_*|MSYS_*|MINGW64_*)
            net session >/dev/null 2>&1
            ;;
        *)
            [ "$EUID" = 0 ]
            ;;
    esac
}
