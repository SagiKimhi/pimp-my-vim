#!/bin/tcsh

# ------------------Aliases------------------

# Terminal window aliases:
alias saveScreen tput smcup
alias saveAndClearScreen tput smcup && clear
alias restoreScreen tput rmcup
alias saveCursorLoc tput sc
alias resetCursorLoc tput rc
alias setCursorAt tput cup 
alias setCursorAtHome tput cup 0 0
alias clearLineFromCurrentCursorPos tput el
alias colorTextRed tput setaf 1
alias colorTextGreen tput setaf 2
alias colorTextYellow tput setaf 3
alias colorTextBlue tput setaf 4
alias colorTextMagneta tput setaf 5
alias colorTextCyan tput setaf 6
alias colorTextWhite tput setaf 7
alias colorTextDefault tput setaf 9

# -------------------------------------------

saveAndClearScreen && setCursorAt 4 0
if ( "`id -u`" == "0" ) then
    echo "`colorTextRed`E: Please run this script as the guest user."
    echo "Aborting installation...\n"
    echo "`colorTextMagneta`Press ENTER to exit...`colorTextDefault`"
    set temp = $<
    restoreScreen
    exit
endif
setCursorAtHome
colorTextDefault
set dependencyDir = "${home}/pimp-my-vim-old-vim"
set dependencyList = "`( cd resources ; ls -A )`"
@ result = 1
if ! ( -d ${dependencyDir} ) then
    echo "Unable locate pimp my vim's backup files directory (should be ${dependencyDir})"
    echo "Aborting..."
    @ result = 0
endif

if ( ${result} ) then
    echo "Restoring files..."
    foreach file ( ${dependencyList} )
        if ( -e ${dependencyDir}/${file} ) then
            echo -n "Restoring old version of ${file}... "
            mv -f ${dependencyDir}/${file} ${home}/
            echo "Done."
        else
            rm -rf ${home}/${file}
        endif
    end
    echo "`colorTextGreen`All files have been restored successfuly.\n"
endif

echo "`colorTextMagneta`Press ENTER to exit...`colorTextDefault`"
set temp = $<
restoreScreen
