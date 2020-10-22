# Emacs Make and Configuration System (EMaCS)

Traditionally Emacs uses the `.emacs` file and the `.emacs.d` directory both located in  
the user home directory.  The programmer itch comes this time from the need of running  
different compilations of Emacs. Current workarounds found were some scripts for renaming  
`.emacs.d` directory. Let's better make Emacs deal with the task.  EMaCS will use the  
`user-emacs-directory` variable to set a specific configuration directory for every Emacs  
build. The single `$HOME/.emacs.d` configuration directory won't be used anymore.  


## Running different versions of Emacs.

-   src/.emacs, configuration file


## Compiling Emacs from source code.

-   bin/emacs-compile.sh, compilation script


# Quick start


## Installation

-   Clone the Git repository.  
    
    ```shell
    git clone https://gitlab.com/lll-tools/emacs/lll-emacs-config.git
    ```
-   Backup your `.emacs` file and copy this project `.emacs` file to your $HOME directory.  
    
    ```shell
    cp -vf $HOME/.emacs $HOME/.emacs-user
    cp -vf ./src/.emacs $HOME
    ```


## Run Vanilla

Run your currently installed emacs. EMaCS vanilla version of the `.emacs` file will use  
your `.emacs-user` with `$HOME/.config/emacs/<version>.<build>.<date>` as `.emacs.d` dir.  


# Make

-   Run the compilation script.  
    
    ```shell
    ./bin/emacs-compile.sh
    ```
-   Run new compiled Emacs.  
    
    ```shell
    ./emacs/src/emacs
    ```


# Configuration


## First Run Customizations

Edit `.emacs-frc.el` file.  
Define your common preferences.  


## Melpa packages

Edit `.emacs-pck.el` file.  
Define your preferred packages.  


## Keyboard shortcuts and alias

Edit `.emacs-kb.el` file  
Define your key bindings.  


## Development el modes

Edit `.emacs-dev.el` file.  
Define your Elisp modules under development.  


## Source packages

Edit `.emacs-src.el` file.  
Define the packages used from source, NOT from melpa.  


# Contributions

<https://gitlab.com/lll-tools/emacs/lll-emacs-config/-/issues>
