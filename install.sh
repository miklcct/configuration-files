#!/bin/bash

cd -- "$( dirname -- "${BASH_SOURCE[0]}" )"
. .bash_aliases

for file in $(git ls-files)
do
    if
        [[ "$file" == .* ]] || (is_windows && ([[ "$file" == *.cmd ]] || [[ "$file" == AppData/* ]]))
    then
        processed=
        while
            [ -z "$processed" ]
        do
            echo
            echo Please enter one of the following for $file
            echo copy : Copy the file to the home directory, overwriting it.
            echo skip : Do not copy this configuration file.
            echo diff : Launch vimdiff to interactively edit the file. You will \
                have a chance to enter the response again.
            read command
            case "$command" in
                copy)
                    mkdir -p $(dirname ~/"$file")
                    cp -v "$file" ~/"$file"
                    processed=true
                    ;;
                skip)
                    processed=true
                    ;;
                diff)
                    vimdiff ~/"$file" "$file"
                    ;;
                *)
                    echo Invalid response. Please enter again.
                    ;;
            esac
        done
    fi
done
