#!/bin/bash

for file in .*
do
    if
        [ -f "$file" ] && git ls-files "$file" --error-unmatch >/dev/null 2>&1
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
                    cp -v "$file" ~
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
