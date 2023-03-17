#!/bin/bash
if ! command -v zenity &> /dev/null && ! command -v yad &> /dev/null
then
echo "Neither Zenity nor Yad GUI was found."
echo "Plase consider installing at least one so the script can continue with better GUI."
PS3='Choose what to install: '
guis=("Zenity" "Yad" "Quit")
select interface in "${guis[@]}"; do
    case $interface in
        "Zenity")
            echo "Zenity will be installed:"
    		sudo apt-get --ignore-missing install zenity
    		exit
            ;;
        "Yad")
            echo "Yad will be installed:"
    		sudo apt-get --ignore-missing install yad
    		exit
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done
fi
if command -v zenity &> /dev/null
then
dir=$(zenity --file-selection --title="Choose a directory" --directory)
elif command -v yad &> /dev/null
then
dir=$(yad --center --file-selection --title="Choose a directory" --directory)
fi
cd $dir
sudo find . -maxdepth 10 -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;