#!/bin/bash
set -e
read -p "Enter user name: " name
# check if the user name is exists in /etc/passwd file or not
if grep -q "^$name" /etc/passwd; then
        echo "Searching the user name '$name' in '/etc/passwd' file........"
        sleep 2s
        echo "user name '$name' found!"
        echo "now user '$name' has '$(grep "$name" /etc/passwd)' shell."
        echo " "
        read -p "Do you want to change the login shell? (yes=y/Y and no=n/N): " choice
        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
        if [[ "$choice" == "y" ]]; then
                read -p "Enter the shell name: " shell
                echo "Enter the sudo password for the changes"
                sudo usermod -s "$shell" "$name"
                echo "shell updated for '$name'."
                grep "$name" /etc/passwd
        elif [[ "$choice" == "n" ]]; then
                echo "no changes made!"
        fi
else
        echo "user not found."
fi
