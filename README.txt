Luis Lain


1 Emacs Make and Configuration System (EMaCS)
=============================================

  Traditionally GNU Emacs uses the `.emacs' [initialization file] and
  the `.emacs.d'
  [DotEmacsDotD] directory, both located in the user `$HOME'
  directory. The programmer itch
  comes this time from the need to share the same configuration files
  for running different
  versions and compilations of GNU Emacs. Current workarounds found were
  some scripts for
  renaming `.emacs.d' directory, let's better make GNU Emacs itself deal
  with this task.

  EMaCS will backup your current [initialization file] renaming it to
  `init-user-backup.el':
  - `$HOME/.emacs' -> `$HOME/init-user-backup.el'
  - `$HOME/.emacs.el' -> `$HOME/init-user-backup.el'
  - `$HOME/.emacs.d/init.el' -> `$HOME/.emacs.d/init-user-backup.el'
  - `$HOME./config/emacs/init.el' ->
    `$HOME./config/emacs/init-user-backup.el'

  EMaCS will overwrite your current [initialization file] with the
  project's `./src/.emacs':
  - `./src/.emacs' -> `$HOME/.emacs'
  - `./src/.emacs' -> `$HOME/.emacs.el'
  - `./src/.emacs' -> `$HOME/.emacs.d/init.el'
  - `./src/.emacs' -> `$HOME./config/emacs/init.el'

  The current `user-emacs-directory' directory (any of `$HOME/.emacs.d'
  or the XDG-compatible
  `$HOME/.config/emacs') is not used by EMaCS to store the user
  customizations. EMaCS will
  create a custom `user-emacs-directory' directory at run time for each
  GNU Emacs instance
  runned. EMaCS will always set the `user-emacs-directory' variable into
  the XDG-compatible
  path `$HOME/.config/emacs' with the value
  `.emacs.<version>-<build>-<date>':
  `$HOME/.config/emacs/.emacs.<version>-<build>-<date>'.


[initialization file]
<https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html>

[DotEmacsDotD] <https://www.emacswiki.org/emacs/DotEmacsDotD>

1.1 Running different versions and builds of Emacs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  The EMaCS [initialization file] `src/.emacs' will be shared for
  running many different
  versions and builds of GNU Emacs. EMaCS provides the main GNU Emacs
  [initialization file]
  `src/.emacs', that will be the new `user-init-file' config file for
  all GNU Emacs versions
  and builds in the system. The same [initialization file] `src/.emacs'
  will be used with the
  different `user-emacs-directory' drectories created at runtime relying
  in the version of
  GNU Emacs runned.

  It's adviced to do NOT modify the EMaCS [initialization file]
  `src/.emacs', any custom
  configurations may be done in any of the included configuration files.


[initialization file]
<https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html>


1.2 Compiling Emacs from source code.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  EMaCS provides the `./bin/emacs-compile.sh' script to compile GNU
  Emacs from source code.


2 Quick start
=============

2.1 EMaCS Clone
~~~~~~~~~~~~~~~

  EMaCS project is hosted in gitlab.com:
  - Git clone the EMaCS `lll-emacs-config' repository
    ,----
    | git clone https://gitlab.com/lll-tools/emacs/lll-emacs-config.git
    | cd lll-emacs-config
    | make help
    `----

  EMaCS provides a default `Makefile' with PHONY targets.
  - Execute `make' or `make help' for a list of the available options.
    ,----
    | make
    `----
  - Execute `make check-local' to search and show the existing GNU Emacs
    [initialization file] `src/.emacs'.
    ,----
    | make check-local
    `----
  - Execute `make info-local' to search and show the existing GNU Emacs
    config files in the system.
    ,----
    | make info-local
    `----


[initialization file]
<https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html>


2.2 EMaCS Install
~~~~~~~~~~~~~~~~~

  Install the files needed to run the current GNU Emacs installed in the
  system using the EMaCS
  [initialization file] `src/.emacs'.

  - Execute `make install-data-local':
    - *Search* for the current `user-init-file'.
    - *Backup* the current `user-init-file' (any of `.emacs' or
       `.emacs.el' or
      `./.emacs.d/init.el' or `./config/emacs/init.el') as
      `init-user-backup.el' in the same
      location of the current `user-init-file' found.
    - *Copy* the EMaCS [initialization file] `src/.emacs' file as the
       current `user-init-file'.
    ,----
    | make install-data-local
    `----

  Un-install EMaCS, revert the [initialization file] to the previous
  value.
  - Execute `make clean-local' to revert the installation of EMaCS in
    the system.
    - *Restore* the `init-user-backup.el' as the current
       `user-init-file'.
    - *Remove* the `init-user.el' if exists.
    ,----
    | make clean-local
    `----


[initialization file]
<https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html>


2.3 EMaCS Run
~~~~~~~~~~~~~

  The first time that you run any installed version of GNU Emacs using
  the EMaCS
  [initialization file] `src/.emacs', it will ask if the
  `init-user-backup.el' should be
  used.
  - *YES*, EMaCS will copy the backup of the user current configuration
    `init-user-backup.el' to the file `init-user.el' and will use it
    with the
    `$HOME/.config/emacs/.emacs.<version>-<build>-<date>' directory as
    `user-emacs-directory'.
  - *NO*, EMaCS will create an empty plain `init-user.el' file to add
     your customizations.


[initialization file]
<https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html>


2.4 EMaCS Clone and Make GNU Emacs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Execute `make install-exec-local' to clone the GNU Emacs source code
    repository.
    - Git clone GNU Emacs source code in `./emacs' directory.
    ,----
    | make install-exec-local
    `----

  - Execute `make install-local' to do both `make install-data-local'
    and `make install-exec-local'.
    ,----
    | make install-local
    `----


3 EMaCS installation options
============================

3.1 Install Vanilla
~~~~~~~~~~~~~~~~~~~

  - Execute `make install-vanilla' to install files needed to run the
    current GNU Emacs
    installation in the system.
    - `make install-data-local'
    - Copy the EMaCS first run file `./src/init-first-run.el' to the
      XDG-compatible
      directory `./config/emacs/init-first-run.el'.
    ,----
    | make install-vanilla
    `----


3.2 Install Full
~~~~~~~~~~~~~~~~

  - Execute `make install-full' to install files needed to run the
    current GNU Emacs
    installation in the system.
    - `make install-vanilla'
    - Copy the EMaCS first run file `./src/init-packages.el' to the
      XDG-compatible
      directory `./config/emacs/init-packages.el'.
    - Copy the EMaCS first run file `./src/init-sources.el' to the
      XDG-compatible
      directory `./config/emacs/init-sources.el'.
    - Copy the EMaCS first run file `./src/init-key-bindings.el' to the
      XDG-compatible
      directory `./config/emacs/init-key-bindings.el'.
    - Copy the EMaCS first run file `./src/init-dev-projects.el' to the
      XDG-compatible
      directory `./config/emacs/init-dev-projects.el'.
    ,----
    | make install-full
    `----


4 EMaCS run details
===================

  GNU Emacs [customizations] for standard options.

  EMaCS vanilla installation will *copy* the `init-first-run.el' file in
  the XDG-compatible directory.

  EMaCS `user-init-file' will *search* for the `init-user.el' file.

  EMaCS `user-init-file' will *search* for the `init-first-run.el' file
  with common
  customizations to *import* them in the new `custom.el' file of any new
  GNU Emacs
  environment.

  EMaCS `user-init-file' will *create* a new empty `custom.el' file in
  the
  `user-emacs-directory' directory the first time that a new version or
  build of GNU Emacs is runned.

  EMaCS `user-init-file' will *search* for the `custom.el' file in the
  `user-emacs-directory' created.
  - custom.el, location
  - default.el, (site-lisp) location
  - site-start.el, (site-lisp) location


[customizations]
<https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html>

4.1 Run Profile
~~~~~~~~~~~~~~~

  - specific profile


5 EMaCS Configuration
=====================

5.1 User Customizations
~~~~~~~~~~~~~~~~~~~~~~~

  Edit `init-user.el' file.
  Define your preferences.


5.2 First Run Customizations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Edit `init-first-run.el' file.
  Define your common preferences.


5.3 Melpa packages
~~~~~~~~~~~~~~~~~~

  Edit `init-packages.el' file.
  Define your preferred packages.


5.4 Source packages
~~~~~~~~~~~~~~~~~~~

  Edit `init-sources.el' file.
  Define the packages used from source, NOT from melpa.


5.5 Keyboard shortcuts and alias
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Edit `init-key-bindings.el' file
  Define your key bindings.


5.6 Development el modes
~~~~~~~~~~~~~~~~~~~~~~~~

  Edit `init-dev-projects.el' file.
  Define your Elisp modules under development.


6 EMaCS Make GNU Emacs
======================

  - Run the compilation script.
    ,----
    | ./bin/emacs-compile.sh
    `----
  - Run new compiled Emacs.
    ,----
    | ./emacs/src/emacs
    `----


7 Contributions
===============

  <https://gitlab.com/lll-tools/emacs/lll-emacs-config/-/issues>


8 Release life-cycle
====================

  1. *checkout* `dev' branch
  2. *create* and *checkout* new `release/vx.y.z' branch
  3. *reset* (mixed) `release/vx.y.z' branch to `vx.y' branch
     1. Discard "`dev' branch only" files and `ChangeLog' file
     2. Update `ChangeLog' file with changes to show in `master' branch
  4. *commit* `release/vx.y.z' branch
  5. *checkout* `vx.y' branch
  6. *merge* (probably ff) `release/vx.y.z' branch into `vx.y' branch
  7. *checkout* `dev' branch
  8. *tag* `dev' branch with `tags/vx.y.z'
  9. Repeat this loop (Steps 1-8) any times before merge into `master'
     branch
  10. *checkout* `master' branch
  11. *merge* (--squash) `vx.y' branch
      1. Fix merge conflicts
  12. *commit* `master' branch
      1. Fix squash merge message (release/vx.y.z)
  13. *checkout* `vx.y' branch
  14. *merge* `master' branch into `vx.y' (should be empty)
  15. *checkout* `master' branch
  16. *tag* `master' branch with new release `tags/vx.y.z'
  17. *push* `master' branch into origin
  18. *checkout* `dev' branch
      1. Fork release x.y (when required)
      2. Bump version x.y.z to next release


8.1 Only when new fork from previous release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  1. *merge* (--no-commit --no-ff) `vx.y' branch into `dev' branch
     1. Remove ChangeLog file from merge (ours)
     2. Commit merge (should be empty)
