# UI
start_uninstall() {
    dialog --title "[ Brutal DOOM Uninstaller ]" --yesno "Are you sure, that you want to uninstall Brutal DOOM?" 10 40;
	result=$?;
	if [ $result -eq 1 ]; then
		clear;
		exit 0;
	fi
	clear;
	warning_about_saves;
}

warning_about_saves() {
    dialog --title "[ Brutal DOOM Uninstaller ]" --yesno "WARNING! This program will COMPLETELY erase Brutal DOOM itself with it's configuration\nAll saves will be lost!" 10 60;
	result=$?;
	if [ $result -eq 1 ]; then
		clear;
		exit 0;
	fi
	clear;
	deleting_game_files;
}

deleting_game_files() {
    dialog --title "[ Brutal DOOM Uninstaller ]" --infobox "Deleting Brutal DOOM files ..." 10 60;
    sleep 1;
    rm -rf /usr/share/games/brutal-doom /usr/share/applications/BrutalDOOM.desktop
	dialog --title "[ Brutal DOOM Uninstaller ]" --msgbox "Deleting Brutal DOOM has been completed!" 10 60;
	clear;
	exit 0;
}
start_uninstall;