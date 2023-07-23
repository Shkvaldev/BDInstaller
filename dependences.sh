if_util_exists() {
	if ! [ -x "$(command -v $1)" ]; then
	  echo 1;
	  return;
	fi
	echo 0;
}

sudo pacman -Sy fluidsynth sdl2 gtk3 unrar unzip aria2

dialog --title "[ Brutal DOOM Installer ]" --infobox "Alright, all dependences are installed :)" 10 40;
sleep 2;
clear;
exit 0;