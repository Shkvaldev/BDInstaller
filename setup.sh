# Utilities
if_util_exists() {
	if ! [ -x "$(command -v $1)" ]; then
	  echo 1;
	  return;
	fi
	echo 0;
}

if_file_exists() {
	if ! [ -f "$1" ]; then
	    echo 1;
	    return;
	fi
	echo 0;
}

# UI
start_setup() {
	dialog --title "[ Brutal DOOM Installer ]" --yesno "Setting up Brutal DOOM v.21, start?" 10 40;
	result=$?;
	if [ $result -eq 1 ]; then
		clear;
		exit 0;
	fi
	clear;
	dialog --title "[ Brutal DOOM Installer ]" --infobox "Starting install" 10 40;
	sleep 1;
	clear;
	check_current_install;
}

check_current_install() {
	if [ -d "/usr/share/games/brutal-doom" ]; then
		dialog --title "[ Brutal DOOM Installer ]" --msgbox "It seems, that you have already installed Brutal DOOM\n(If something went wrong while last setup, just run: sudo ./uninstall.sh)" 10 60;
		clear;
		exit 0;
	fi
	check_dependencies;
}

check_dependencies() {
	dialog --title "[ Brutal DOOM Installer ]" --yesno "To begin with, let's install the dependences (Yes - to Perform, No - to Skip)" 10 40;
	result=$?;
	if [ $result -eq 0 ]; then
		clear;
		sudo ./dependences.sh
	fi
	clear;
	doom2_wad_download;
}

doom2_wad_download() {
	dialog --title "[ Brutal DOOM Installer ]" --yesno "To play Brutal DOOM you need original DOOM2.WAD, may i download it (illegal, at your own risk)?" 10 40;
	result=$?;

	if [ $result -eq 1 ]; then
		clear;
		exit 0;
	fi

	clear;
	dialog --title "[ Brutal DOOM Installer ]" --infobox "Downloading DOOM2.WAD ... stand by" 10 40;
	clear;
	aria2c https://doomguy.ru/download/doom2;
	unzip doom2 DOOM2.WAD;

	if [ $(if_file_exists "DOOM2.WAD") -eq 1 ]; then
		dialog --title "[ Brutal DOOM Installer ]" --msgbox "Error! Can not download DOOM2.WAD file :(" 10 40;
		clear;
		exit 1;
	fi
	rm doom2; 
	dialog --title "[ Brutal DOOM Installer ]" --infobox "DOOM2.WAD has been downloaded :)" 10 40;
	sleep 1;
	clear;
	gzdoom_download;
}

gzdoom_download() {
	dialog --infobox "Downloading GZDoom Portable ... stand by" 10 60;
	sleep 3;
	clear;
	aria2c https://zdoom.org/files/gzdoom/bin/GZDoom.v4.10.0.LinuxPortable.tar.xz;

	if [ $(if_file_exists "GZDoom.v4.10.0.LinuxPortable.tar.xz") -eq 1 ]; then
		dialog --title "[ Brutal DOOM Installer ]" --msgbox "Error! Can not find GZDoom archive :(" 10 60;
		clear;
		exit 1;
	fi
	tar xf GZDoom.v4.10.0.LinuxPortable.tar.xz
	mv GZDoom.v4.10.0.LinuxPortable gzdoom
	dialog --title "[ Brutal DOOM Installer ]" --infobox "GZDoom Portable has been downloaded :)" 10 60;
	sleep 2;
	clear;
	placing_game;
}

music_download

placing_game() {
	dialog --title "[ Brutal DOOM Installer ]" --infobox "Placing game files ..." 10 40;
	sleep 1;
	install -d /usr/share/games/brutal-doom
	install -d /usr/share/applications

	install -m644 brutal-doom.pk3 /usr/share/games/brutal-doom/brutal-doom.pk3
	install -m644 DOOM2.WAD /usr/share/games/brutal-doom/DOOM2.WAD
	# install -m644 doom-metal-vol5.wad /usr/share/games/brutal-doom/doom-metal-vol5.wad
	cp -r gzdoom /usr/share/games/brutal-doom
	chmod +x /usr/share/games/brutal-doom/*
	install -m777 brutal-doom.jpg /usr/share/games/brutal-doom/brutal-doom.jpg
	install -m777 gzdoom.ini /usr/share/games/brutal-doom/gzdoom.ini 
	install -m777 BrutalDOOM.desktop /usr/share/applications/BrutalDOOM.desktop
	rm -rf gzdoom GZDoom.v4.10.0.LinuxPortable.tar.xz DOOM2.WAD
	clear;
	dialog --title "[ Brutal DOOM Installer ]" --msgbox "All done, game is ready to play :)" 10 40;
	clear;
	exit 0;
}

start_setup
