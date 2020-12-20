# Emacs Make and Configuration System (EMaCS)

Traditionally GNU Emacs uses the `.emacs` [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) and the `.emacs.d`  
[DotEmacsDotD](https://www.emacswiki.org/emacs/DotEmacsDotD) directory, both located in the user `$HOME` directory. The programmer itch  
comes this time from the need to share the same configuration files for running different  
versions and compilations of GNU Emacs. Current workarounds found were some scripts for  
renaming `.emacs.d` directory, let's better make GNU Emacs itself deal with this task.  

EMaCS will backup your current [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) renaming it to `init-user-backup.el`:  

-   `$HOME/.emacs` -> `$HOME/init-user-backup.el`
-   `$HOME/.emacs.el` -> `$HOME/init-user-backup.el`
-   `$HOME/.emacs.d/init.el` -> `$HOME/.emacs.d/init-user-backup.el`
-   `$HOME./config/emacs/init.el` -> `$HOME./config/emacs/init-user-backup.el`

EMaCS will overwrite your current [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) with the project's `./src/.emacs`:  

-   `./src/.emacs` -> `$HOME/.emacs`
-   `./src/.emacs` -> `$HOME/.emacs.el`
-   `./src/.emacs` -> `$HOME/.emacs.d/init.el`
-   `./src/.emacs` -> `$HOME./config/emacs/init.el`

The current `user-emacs-directory` directory (any of `$HOME/.emacs.d` or the XDG-compatible  
`$HOME/.config/emacs`) is not used by EMaCS to store the user customizations. EMaCS will  
create a custom `user-emacs-directory` directory at run time for each GNU Emacs instance  
runned. EMaCS will always set the `user-emacs-directory` variable into the XDG-compatible  
path `$HOME/.config/emacs` with the value `.emacs.<version>-<build>-<date>`:  
`$HOME/.config/emacs/.emacs.<version>-<build>-<date>`.  


## Running different versions and builds of Emacs

The EMaCS [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) `src/.emacs` will be shared for running many different  
versions and builds of GNU Emacs. EMaCS provides the main GNU Emacs [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html)  
`src/.emacs`, that will be the new `user-init-file` config file for all GNU Emacs versions  
and builds in the system. The same [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) `src/.emacs` will be used with the  
different `user-emacs-directory` drectories created at runtime relying in the version of  
GNU Emacs runned.  

It's adviced to do NOT modify the EMaCS [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) `src/.emacs`, any custom  
configurations may be done in any of the included configuration files.  


## Compiling Emacs from source code.

EMaCS provides the `./bin/emacs-compile.sh` script to compile GNU Emacs from source code.  


# Quick start


## EMaCS Clone

EMaCS project is hosted in gitlab.com:  

-   Git clone the EMaCS `lll-emacs-config` repository  
    
    ```shell
    git clone https://gitlab.com/lll-tools/emacs/lll-emacs-config.git
    cd lll-emacs-config
    make help
    ```

EMaCS provides a default `Makefile` with PHONY targets.  

-   Execute `make` or `make help` for a list of the available options.  
    
    ```shell
    make
    ```
-   Execute `make check-local` to search and show the existing GNU Emacs [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) `src/.emacs`.  
    
    ```shell
    make check-local
    ```
-   Execute `make info-local` to search and show the existing GNU Emacs config files in the system.  
    
    ```shell
    make info-local
    ```


## EMaCS Install

Install the files needed to run the current GNU Emacs installed in the system using the EMaCS  
[initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) `src/.emacs`.  

-   Execute `make install-data-local`:  
    
    -   **Search** for the current `user-init-file`.
    -   **Backup** the current `user-init-file` (any of `.emacs` or `.emacs.el` or  
        `./.emacs.d/init.el` or `./config/emacs/init.el`) as `init-user-backup.el` in the same  
        location of the current `user-init-file` found.
    -   **Copy** the EMaCS [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) `src/.emacs` file as the current `user-init-file`.
    
    ```shell
    make install-data-local
    ```

Un-install EMaCS, revert the [initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) to the previous value.  

-   Execute `make clean-local` to revert the installation of EMaCS in the system.  
    
    -   **Restore** the `init-user-backup.el` as the current `user-init-file`.
    -   **Remove** the `init-user.el` if exists.
    
    ```shell
    make clean-local
    ```


## EMaCS Run

The first time that you run any installed version of GNU Emacs using the EMaCS  
[initialization file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html) `src/.emacs`, it will ask if the `init-user-backup.el` should be  
used.  

-   **YES**, EMaCS will copy the backup of the user current configuration  
    `init-user-backup.el` to the file `init-user.el` and will use it with the  
    `$HOME/.config/emacs/.emacs.<version>-<build>-<date>` directory as  
    `user-emacs-directory`.
-   **NO**, EMaCS will create an empty plain `init-user.el` file to add your customizations.


## EMaCS Clone and Make GNU Emacs

-   Execute `make install-exec-local` to clone the GNU Emacs source code repository.  
    
    -   Git clone GNU Emacs source code in `./emacs` directory.
    
    ```shell
    make install-exec-local
    ```

-   Execute `make install-local` to do both `make install-data-local` and `make install-exec-local`.  
    
    ```shell
    make install-local
    ```


# EMaCS installation options


## Install Vanilla

-   Execute `make install-vanilla` to install files needed to run the current GNU Emacs  
    installation in the system.  
    
    -   `make install-data-local`
    -   Copy the EMaCS first run file `./src/init-first-run.el` to the XDG-compatible  
        directory `./config/emacs/init-first-run.el`.
    
    ```shell
    make install-vanilla
    ```


## Install Full

-   Execute `make install-full` to install files needed to run the current GNU Emacs  
    installation in the system.  
    
    -   `make install-vanilla`
    -   Copy the EMaCS first run file `./src/init-packages.el` to the XDG-compatible  
        directory `./config/emacs/init-packages.el`.
    -   Copy the EMaCS first run file `./src/init-sources.el` to the XDG-compatible  
        directory `./config/emacs/init-sources.el`.
    -   Copy the EMaCS first run file `./src/init-key-bindings.el` to the XDG-compatible  
        directory `./config/emacs/init-key-bindings.el`.
    -   Copy the EMaCS first run file `./src/init-dev-projects.el` to the XDG-compatible  
        directory `./config/emacs/init-dev-projects.el`.
    
    ```shell
    make install-full
    ```


# EMaCS run details

GNU Emacs [customizations](https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html) for standard options.  

EMaCS vanilla installation will **copy** the `init-first-run.el` file in the XDG-compatible directory.  

EMaCS `user-init-file` will **search** for the `init-user.el` file.  

EMaCS `user-init-file` will **search** for the `init-first-run.el` file with common  
customizations to **import** them in the new `custom.el` file of any new GNU Emacs  
environment.  

EMaCS `user-init-file` will **create** a new empty `custom.el` file in the  
`user-emacs-directory` directory the first time that a new version or build of GNU Emacs is runned.  

EMaCS `user-init-file` will **search** for the `custom.el` file in the  
`user-emacs-directory` created.  

-   custom.el, location
-   default.el, (site-lisp) location
-   site-start.el, (site-lisp) location


## Run Profile

-   specific profile


# EMaCS Configuration


## User Customizations

Edit `init-user.el` file.  
Define your preferences.  


## First Run Customizations

Edit `init-first-run.el` file.  
Define your common preferences.  


## Melpa packages

Edit `init-packages.el` file.  
Define your preferred packages.  


## Source packages

Edit `init-sources.el` file.  
Define the packages used from source, NOT from melpa.  


## Keyboard shortcuts and alias

Edit `init-key-bindings.el` file  
Define your key bindings.  


## Development el modes

Edit `init-dev-projects.el` file.  
Define your Elisp modules under development.  


# EMaCS Make GNU Emacs

-   Run the compilation script.  
    
    ```shell
    ./bin/emacs-compile.sh
    ```
-   Run new compiled Emacs.  
    
    ```shell
    ./emacs/src/emacs
    ```


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
8.  **tag** `dev` branch with `tags/vx.y.z`
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


## Only when new fork from previous release

1.  **merge** (&#x2013;no-commit &#x2013;no-ff) `vx.y` branch into `dev` branch  
    1.  Remove ChangeLog file from merge (ours)
    2.  Commit merge (should be empty)
