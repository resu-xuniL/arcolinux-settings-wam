#!/usr/bin/env bash

source src/init.sh
source src/cmd.sh
source src/cmd_main.sh
source src/_dep.sh
source src/end.sh

start_time="$(date +%s)"
LOG_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/logfile_archlinux_$(date "+%Y%m%d-%H%M%S").log"

if [[ ${CURRENT_OS} == "Arch Linux" ]]; then
    if [[ -z ${XDG_CURRENT_DESKTOP} ]]; then
        check_internet || exit 1

        init

        exec_log "sudo cp ${INSTALL_DIRECTORY}/_archlinux/environment /etc" "${GREEN}[+]${RESET} Copying [${YELLOW}environment${RESET}] file to [${YELLOW}/etc${RESET}] folder"
        exec_log "sudo cp ${INSTALL_DIRECTORY}/_archlinux/pacman.conf /etc" "${GREEN}[+]${RESET} Copying [${YELLOW}pacman.conf${RESET}] file to [${YELLOW}/etc${RESET}] folder"
        exec_log "sudo cp ${INSTALL_DIRECTORY}/_archlinux/arcolinux-mirrorlist /etc/pacman.d" "${GREEN}[+]${RESET} Copying [${YELLOW}arcolinux-mirrorlist${RESET}] file to [${YELLOW}/etc/pacman.d${RESET}] folder"
        exec_log "sudo cp ${INSTALL_DIRECTORY}/_archlinux/mirrorlist /etc/pacman.d" "${GREEN}[+]${RESET} Copying [${YELLOW}mirrorlist${RESET}] file to [${YELLOW}/etc/pacman.d${RESET}] folder"

        exec_log "cp ${INSTALL_DIRECTORY}/_archlinux/.face ${HOME}" "${GREEN}[+]${RESET} Copying [${YELLOW}icon${RESET}] file to [${YELLOW}${HOME}${RESET}]"

        exec_log "sudo pacman-key --recv-keys 74F5DE85A506BF64" "${GREEN}[+]${RESET} Importing [${YELLOW}public keys${RESET}] for [${YELLOW}Arcolinux repo${RESET}] packages"
        exec_log "sudo pacman-key --lsign-key 74F5DE85A506BF64" "${GREEN}[+]${RESET} Updating [${YELLOW}trust database keys${RESET}]"

        exec_log "sudo pacman -Syyu --noconfirm" "${GREEN}[+]${RESET} Updating full system ${RED}(might be long)${RESET}"

        arch_required

        action_type="config_files"
        file_conf="X11-keymap"
        exec_log "sudo localectl set-x11-keymap fr" "${GREEN}[+]${RESET} Setting [${YELLOW}x11-keymap${RESET}] to [${YELLOW}fr${RESET}]"
        file_conf="SDDM"
        exec_log "sudo systemctl enable sddm" "${GREEN}[+]${RESET} Enabling [${YELLOW}SDDM${RESET}]"
        file_conf="Locate"
        exec_log "sudo updatedb" "${GREEN}[+]${RESET} Updating [${YELLOW}locate${RESET}] database"
        file_conf="XFCE Terminal"
        exec_log "xfconf-query -c xfce4-terminal -p /scrolling-bar -n -t string -s TERMINAL_SCROLLBAR_NONE" "${GREEN}[+]${RESET} XFCE terminal : creating property [${YELLOW}SCROLLING BAR${RESET}] and setting it to [${YELLOW}NONE${RESET}]"
        exec_log "xfconf-query -c xfce4-terminal -p /misc-default-geometry -n -t string -s 100x30" "${GREEN}[+]${RESET} XFCE terminal : creating property [${YELLOW}DEFAULT GEOMETRY${RESET}] and setting it to [${YELLOW}100x30${RESET}]"
        exec_log "xfconf-query -c xfce4-session -p /general/SaveOnExit -n -t bool -s false" "${GREEN}[+]${RESET} XFCE session : creating property [${YELLOW}SAVE ON EXIT${RESET}] and setting it to [${YELLOW}FALSE${RESET}]"

        endscript "${start_time}"
    else
        log_msg "${RED}/!\ [${RESET}${BB}${YELLOW}ARCH LINUX${RESET}${RED}] is set and can be riced. Run [${RESET}${BB}${YELLOW}settings.sh${RESET}${RED}] script now /!\ ${RESET}\n"
        exit
    fi
else
    log_msg "${RED}/!\ THIS IS NOT AN [${RESET}${BB}${YELLOW}ARCH LINUX${RESET}${RED}] DISTRO /!\ ${RESET}\n"
    exit
fi
