header() {
    clear_noclear
    cat <<-EOF
----------------------------------------------------------------------------------------------------

        ${PURPLE}##${RESET}                         ${GREEN}##${RESET} 
        ${PURPLE}##     ##${RESET}    ${GREEN}###    ###   ###${RESET} 
        ${PURPLE}##  #  ##${RESET}  ${GREEN}##   ##  #### ####${RESET}          Script configuration for Arch Linux
        ${PURPLE}## ### ##${RESET} ${GREEN}##     ## ## ### ##${RESET} 
        ${PURPLE}#### ####${RESET} ${GREEN}######### ##  #  ##${RESET} 
        ${PURPLE}###   ###${RESET} ${GREEN}##     ## ##     ##${RESET}          https://github.com/resu-xuniL/arch-settings
        ${PURPLE}##     ##${RESET} ${GREEN}##     ## ##     ##${RESET} 

----------------------------------------------------------------------------------------------------
EOF

    sleep 1

    printf "${BOLD}${RED}"
    center_text "/!\ THIS SCRIPT WILL MAKE CHANGES TO THE SYSTEM ! /!\\" "$(tput cols)"
    printf "${RESET}"
    center_text "(Some steps may take longer, depending on your Internet connection and CPU.)" "$(tput cols)"
    printf "%b" "\033[5B"
}