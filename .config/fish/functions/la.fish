# Defined in /usr/share/fish/functions/la.fish @ line 4
function la --wraps=ls --description 'List contents of directory, including hidden files in directory'
    ls -A $argv
end
