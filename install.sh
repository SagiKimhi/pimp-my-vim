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
alias setDimText tput dim
alias setBrightText tput bold
alias highlightText tput smso
alias setTextUnderscore tput smul
alias unsetTextUnderscore tput rmul
alias unsetTextAttributes tput sgr0

# Package handling aliases:
alias getPackageSize apt-cache --no-all-versions show 

# -------------------------------------------

# Create a new clean screen for the installation
saveAndClearScreen && setCursorAt 4 0 && saveCursorLoc
if ( "`id -u`" == "0" ) then
    echo "`colorTextRed`E: Please run this script as the guest user."
    echo "Aborting installation...\n"
    echo "`colorTextMagneta`Press ENTER to exit...`colorTextDefault`"
    set temp = $<
    restoreScreen
    exit
endif

set apt = "sudo apt-get"
set dependencyList = ( "vim" "python3" "curl" 'exuberant-ctags' )
set progList = ( "vim" "python3" "curl" "ctags" )
@ result = 1

setCursorAtHome
# Print an installation progress title
set usrMsg = "Instlling essential dependencies... "
echo -n "`colorTextCyan`${usrMsg}`colorTextYellow`( 1 / ${#dependencyList} )\n`colorTextDefault`"

# Print an empty progress Bar
colorTextGreen
@ barSize = 80
@ fillSize = ( ${barSize} / ${#dependencyList} )
echo -n "["
while ( ${barSize} > 0 )
    echo -n " "
    @ barSize -= 1
end
echo -n "]"
colorTextDefault
# Actual installation loop
foreach i ( `seq 1 ${#dependencyList}` )

    # Update installation progress title
    setCursorAt 0 $%usrMsg
    echo -n "`colorTextYellow`( $i / ${#dependencyList} )`colorTextDefault`"
    resetCursorLoc
    
    # Check whether or not the program is already installed
    if ( ! { ( where ${progList[$i]} >& /dev/null ) } ) then
        set temp = "`getPackageSize ${dependencyList[$i]} | grep '^Size: '`"
        set pkgSize = $temp:s/Size: //
	@ pkgSize /= 1000
        set temp = "KB/s"
	if ( ${pkgSize} >= 1000 ) then
            @ pkgSize /= 1000
            set temp = "MB/s"
        endif
        echo "Missing dependency: ${dependencyList[$i]}... (${pkgSize} ${temp})"
        echo -n "Do you wish to install it now? (y/n) "
        set usrAnswr = $<
        if ( "$usrAnswr" == "y" || "$usrAnswr" == "Y" ) then
            echo "Installing ${dependencyList[$i]}... "
            set install = "${apt} install ${dependencyList[$i]} -y"
            if ( ! { eval "$install >& /dev/null" } ) then
                echo "`colorTextRed`Installation failed. Aborting installation...`colorTextDefault`"
                @ result = 0
                break
            else
                echo -n "\rPackage ${dependencyList[$i]} was installed successfuly.`clearLineFromCurrentCursorPos`\n"
            endif
        else
            echo "`colorTextRed`Aborting installation..."
            @ result = 0
            break
        endif
    else
        echo "Package ${dependencyList[$i]} already exists. Moving on..."
    endif
    # Filling up the bar:
    saveCursorLoc
    @ progressBarLocation = ( ( $i - 1 ) * 20 + 1 )
    setCursorAt 1 ${progressBarLocation}
    colorTextGreen
    foreach i ( `seq 1 ${fillSize}` )
        echo -n "#"
        # sleep was added for a smooth animation, you may remove this, this is just a filler
        # untill ill learn how to get actual download data while program is running...
        sleep 0.005
    end
    colorTextDefault && resetCursorLoc
end

if ( ${result} ) then
    echo "`colorTextGreen`Dependancy packages updated successfuly!\n"
    colorTextWhite
    set dependencyDir = "`pwd`/resources"
    set dependencyList = "`( cd ${dependencyDir} ; ls -A )`"
    set backupDir = "${home}/pimp-my-vim-old-vim"
    @ usrAnswr = 0
    if ( -d ${backupDir} ) then
        echo "An older pimp-my-vim backup directory was found."
        echo -n "do you wish to overwrite the old backup files with your current "
        echo -n "vim files? (y/n): "
        set temp = $<
        if ( "${temp}" == "y" || "${temp}" == "Y" ) then
            @ usrAnswr = 1
        else
            if ( "${temp}" != "n" && "${temp}" != "N" ) then
                colorTextRed
                echo -n "I'll take that as a no... "
                echo "`setTextUnderscore`(sleeping for 5 seconds, hit ctrl-C to abort!)"
                unsetTextAttributes && colorTextWhite
                sleep 5
            endif
            @ usrAnswr = 0
        endif
    else
        mkdir ${backupDir}
    endif
    echo "Copying essential files..."
    foreach file ( ${dependencyList} )
        if ( ${usrAnswr} == 1 && -e ${home}/${file} ) then
            rm -rf ${backupDir}/${file}
            echo "Backing up old ${file} into ${backupDir}"
            mv -f ${home}/${file} ${backupDir}
        endif
        echo -n "Copying ${file} to ${home}/... "
        cp -r -f ${dependencyDir}/${file} ${home}/
        echo "Done."
    end
    echo "`colorTextGreen`All files copied successfuly.\n`colorTextWhite`"
    echo -n "Updating vimrc and vim plugins (this may take 20-40 seconds)... "
    ( vim ${home}/.vimrc +w +'so %' +PlugInstall +qall >& InstallationLog.txt && vim ${home}/.vimrc +PlugInstall +'so %' +qall >& InstallationLog.txt )
    echo "Done.\n"
    setDimText && colorTextYellow
    echo "* Please open up your vim editor and make sure no errors appear."
    echo -n "  If any errors appear, comment out the problemetic plugins from within the .vimrc "
    echo "file in your home folder."
    echo -n "  If the problem continues, uninstall this vim upgrade and report the problem "
    echo "in our github issues section.\n"
    unsetTextAttributes && setBrightText && colorTextGreen && setTextUnderscore
    echo "Installation finished successfuly.\n"
endif
unsetTextAttributes
echo "`colorTextMagneta`Press ENTER to exit...`colorTextDefault`"
set temp = $<
restoreScreen
