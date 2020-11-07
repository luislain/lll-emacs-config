# Emacs Make and Configuration System (EMaCS)

Traditionally GNU Emacs uses the `.emacs` [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) and the `.emacs.d`  
directory, both located in the user home directory `$HOME`. The programmer itch comes  
this time from the need of running different compilations of GNU Emacs. Current  
workarounds found were some scripts for renaming `.emacs.d` directory. Let's better make  
GNU Emacs deal with this task. EMaCS will use the `user-emacs-directory` variable to set  
a specific configuration directory for every Emacs build. The single `$HOME/.emacs.d`  
configuration directory won't be used anymore. XDG-compatible standard (`$HOME/.config`)  
will be followed. No matter if you use the traditional `$HOME/.emacs` init file (with the  
associated `$HOME/.emacs.d` directory) or the XDG-compatible  
`$HOME./config/emacs/init.el` init file (with the associated `$HOME/.config/emacs`  
directoy), EMaCS witll set the `user-emacs-directory` variable to the value  
`$HOME/.config/emacs/<version>-<build>-<date>`. Only one single `.emacs` init file is  
used for running many different version and builds of GNU Emacs.  

-   default.el, (site-lisp) location
-   site-start.el, (site-lisp) location


## Custom file

-   custom.el, location
-   first run customizations


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
    # Traditional location
    [ -f $HOME/.emacs ] && mv -vf $HOME/.emacs $HOME/.emacs-user
    [ -f $HOME/.emacs.el ] && mv -vf $HOME/.emacs.el $HOME/.emacs-user.el
    [ -f $HOME/.emacs.d/init.el && mv $HOME/.emacs.d/init.el $HOME/.emacs.d/init-user.el
    cp -vf ./src/.emacs $HOME
    # XDG-compatible location
    [ -f $HOME/.config/emacs/init.el ] && mv -vf $HOME/.config/emacs/init.el $HOME/.config/emacs/init-user.el
    mkdir -p $HOME/.config/emacs && cp -vf ./src/.emacs $HOME/.config/emacs/init.el
    ```


## Run Vanilla

Run your currently installed version of GNU Emacs. EMaCS vanilla version of the `.emacs`  
file will use your `.emacs-user` file with the  
`$HOME/.config/emacs/<version>-<build>-<date>` directory as `.emacs.d` dir.  


## Run Customized

-   custom.el


## Run Full

-   packages, keyboard binds


## Run Profile

-   specific profile


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


# Release life-cycle

1.  **checkout** `dev` branch
2.  **create** and **checkout** new `release/vx.y.z` branch
3.  **reset** (mixed) `release/vx.y.z` branch to `vx.y` branch  
    1.  Discard "`dev` branch only" files and `ChangeLog` file
    2.  Update `ChangeLog` file with changes to show in `master` branch
4.  **commit** `release/vx.y.z` branch
5.  **checkout** `vx.y` branch
6.  **merge** (probably ff) `release/vx.y.z` branch into `vx.y` branch
7.  **checkout** `dev` branch
8.  **merge** (&#x2013;no-commit &#x2013;no-ff) `vx.y` branch into `dev` branch  
    1.  Remove ChangeLog file from merge (ours)
    2.  Commit merge (should be empty)
9.  Repeat this loop (Steps 1-8) any times before merge into `master` branch
10. **checkout** `master` branch
11. **merge** (&#x2013;squash) `vx.y` branch  
    1.  Fix merge conflicts
12. **commit** `master` branch  
    1.  Fix squash merge message (release/vx.y.z)
13. **checkout** `vx.y` branch
14. **merge** `master` branch into `vx.y` (should be empty)
15. **checkout** `master` branch
16. **tag** `master` branch with new release `tags/vx.y.z`
17. **push** `master` branch into origin
18. **checkout** `dev` branch  
    1.  Fork release x.y (when required)
    2.  Bump version x.y.z to next release
