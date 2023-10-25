# Defined in /usr/share/fish/functions/fish_is_root_user.fish @ line 4
function fish_is_root_user --description 'Check if the user is root'
    if string match --regex --quiet '^(CYGWIN|MSYS|MINGW64)_' (uname -s)
        if net session >/dev/null 2>&1
            return 0
        end
        return 1
    end

    if test (id -u) -eq 0
        return 0
    end

    return 1
end
