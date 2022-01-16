Pimp my Vim
===========
A simple vim upgrade including various settings, a plugin manager, plugins, and useful key remaps


Installation
---------------

- ### Requirements

    <h3>The tcsh shell is required for this installation script</h3>

    you can get the tcsh shell by simply running `sudo apt-get install tcsh`

    And you can then switch to the tcsh shell by running the commands:
    ```
    chsh
    /bin/tcsh
    ```

    And then simply log out and back in to your system for the action to take place.

</br>

--------------

</br>

- ### Pimp-my-vim

    To run the pimp-my-vim installation, close this directory to your computer,

    open it in your terminal, and run the following commands:

    ```
    chmod +x install.sh
    ./install.sh
    ``` 
    The installer will also back up you previous .vim, .vimrc, and other dotfiles if such exist into its own backup directory under
    your home directory

    <img src="https://github.com/SagiKimhi/media/blob/main/pimp-my-vim/pimp-my-vim-installation.gif" height="600" width="850">
    
    
    
    You can also uninstall this vim upgrade at any point by simply running:

    ```
    chmod +x uninstall.sh
    ./uninstall.sh
    ```

</br></br>


Quick partial feature summary
--------------------------------

- [Color theme and syntax highlighting](#colortheme)
- [Autocompletion](#autocompletion)
- [File browsing tree](#file-tree)
- [Undo tree](#undo-tree)
- [Text movearound](#text-movement)
- [Auto indentation](#autoindent)
- [File finding with Ctrl+p](#file-finding)
- [Jumping to and between definitions](#def-jumping)
- [Much more...](#etc.)


Color theme and syntax highlighting
-----------------------------------
Using the onedark colortheme plugin:

<img src="https://github.com/SagiKimhi/media/blob/main/pimp-my-vim/pimp-my-vim-colortheme.jpg" height="600" width="700">


Autocompletion
---------------
Using AutoComplPop plugin:

<img src="https://github.com/SagiKimhi/media/blob/main/pimp-my-vim/pimp-my-vim-autocomplete.gif" height="550" width="550">


File browsing tree
---------------
Using nerdtree plugin:

<img src="https://github.com/SagiKimhi/media/blob/main/pimp-my-vim/pimp-my-vim-file-browsing.gif" height="500" width="850">


Undo tree
----------
Using undotree plugin:

<img src="https://github.com/SagiKimhi/media/blob/main/pimp-my-vim/pimp-my-vim-undo-tree.jpg" height="450" width="450">


Text movearound
--------------
This is done with simple key remaps:

- J and K in visual mode
- 'Leader key' (currently spacebar) + J / K in normal mode
- Ctrl + j / k in insert mode

<img src="https://github.com/SagiKimhi/media/blob/main/pimp-my-vim/pimp-my-vim-text-movearound.gif" height="600" width="650">
