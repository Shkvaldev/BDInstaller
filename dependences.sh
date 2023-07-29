if_util_exists() {
	if ! [ -x "$(command -v $1)" ]; then
	  echo 1;
	  return;
	fi
	echo 0;
}

if [ $(if_util_exists "apt-get") -eq 0 ]; then
	sudo apt-get update -y;
	sudo apt-get install fluidsynth libsdl2-dev unrar unzip aria2;
elif [ $(if_util_exists "pacman") -eq 0 ]; then
	sudo pacman -Sy fluidsynth sdl2 gtk3 unrar unzip aria2;
else
	dialog --title "[ Brutal DOOM Installer ]" --msgbox "It seems that you are running unsupported OS - check BDInstaller's repo!" 10 40;
	exit 1;
fi

dialog --title "[ Brutal DOOM Installer ]" --infobox "Alright, all dependences are installed :)" 10 40;
sleep 2;
clear;
exit 0;
