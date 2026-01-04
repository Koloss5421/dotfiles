#!/bin/bash
# dotfiles backup script
# https://github.com/koloss5421/dotfiles

MAP_FILE=./map.txt

print_help() {
	echo "[+] Usage: dotfiles.sh <backup|restore>"
}

backup() {
	cat $MAP_FILE | while read line
	do
        if [[ "$line" == "#"* ]]; then
            continue
        fi
		dont_backup=$(echo $line | cut -d ':' -f 3)
		original_file=$(eval echo $(echo $line | cut -d ':' -f 1))
		backup_location=$(eval echo $(echo $line | cut -d ':' -f 2))
		if [[ -z $dont_backup ]]; then
			echo "[+] Backing up '$original_file' to '$backup_location'..."
            backup_folder=$(echo $backup_location | rev | cut -d '/' -f 2- | rev)
            if [[ ! -f "$backup_folder" ]]; then
                mkdir -p $backup_folder
            fi
			cp $original_file $backup_location
		fi
	done
}

restore() {
	cat $MAP_FILE | while read line
	do
        if [[ "$line" == "#"* ]]; then
            continue
        fi
		original_file=$(eval echo $(echo $line | cut -d ':' -f 1))
		backup_location=$(eval echo $(echo $line | cut -d ':' -f 2))

		echo "[+] Restoring '$original_file' from '$backup_location'..."
		cp $backup_location $original_file 2> /dev/null
		if [[ ! $? == 0 ]]; then
			echo "[!] File '$original_file' requires sudo..."
            restore_folder=$(echo $original_file | rev | cut -d '/' -f 2- | rev)
            if [[ ! -f "$restore_folder" ]]; then
                mkdir -p $restore_folder
                if [[ ! $? == 0 ]]; then
                    echo "[!] Sudo required to restore '$original_file'..."
                    sudo mkdir -p $restore_folder
                fi
            fi
			sudo cp $backup_location $original_file 2> /dev/null
		fi
	done
}

if [[ ! -f "$MAP_FILE" ]]; then
	echo "[!] Error: '$MAP_FILE' does not exist!"
	exit 1
fi

case "$1" in
	"backup")
		backup
		;;
	"restore")
		restore
		;;
	*)
		print_help
		;;
esac
