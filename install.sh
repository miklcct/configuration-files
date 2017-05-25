#!/bin/bash

for file in .*
do
    if
        [ -f "$file" ] && git ls-files "$file" --error-unmatch >/dev/null 2>&1
    then
        echo Please enter one of the following for $file
        echo copy : Copy the file to the home directory, overwriting it.
        echo skip : Do not copy this configuration file.
        echo diff : Launch vimdiff to interactively edit the file.
        processed=
        while
            [ -z "$processed" ]
        do
            read command
            case "$command" in
                copy)
                    cp -v "$file" ~
                    processed=true
                    ;;
                skip)
                    processed=true
                    ;;
                diff)
                    vimdiff ~/"$file" "$file"
                    processed=true
                    ;;
                *)
                    echo Invalid response. Please enter again.
                    ;;
            esac
        done
    fi
done
