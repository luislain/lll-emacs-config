Luis Lain


1 Emacs Make and Configuration System (EMaCS)
=============================================

  Traditionally GNU Emacs uses the `.emacs' [initialization file] and
  the `.emacs.d' directory,
  both located in the user home directory `$HOME'. The programmer itch
  comes this time from
  the need to share the same configuration files for running different
  versions and
  compilations of GNU Emacs. Current workarounds found were some scripts
  for renaming
  `.emacs.d' directory. Let's better make GNU Emacs deal with this task,
  EMaCS will set the
  `user-emacs-directory' variable to the value
  `(default-directory)/.emacs.<version>-<build>-<date>'.

  The value of `(default-directory)' relies on the value of
  `user-init-file' at run time.
  - If you are using the traditional `$HOME/.emacs' or `$HOME/.emacs.el'
    init file (with the
    associated `$HOME/.emacs.d' directory), then `(default-directory)'
    is `$HOME'.
  - If you are using `$HOME/.emacs.d/init.el' init file (with the
    associated
    `$HOME/.emacs.d' directory), then `(default-directory)' is
    `$HOME/.emacs.d'.
  - If you are using the XDG-compatible `$HOME./config/emacs/init.el'
    init file (with the
    associated `$HOME/.config/emacs' directoy), then
    `(default-directory)' is
    `$HOME/.config/emacs'.

  The one and only init file used (any of `.emacs' or `.emacs.el' or
  `./.emacs.d/init.el' or
  `./config/emacs/init.el') will be shared for running many different
  versions and builds of
  GNU Emacs. To avoid conflicts, at the same location of the init file,
  a custom
  `user-emacs-directory' directory will be created at run time for each
  one of the GNU Emacs
  instances runned.


[initialization file]
<https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html>

1.1 Running different versions and builds of Emacs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  EMaCS provides the main GNU Emacs configuration file `src/.emacs',
  that will be the new
  `user-init-file' config file for all GNU Emacs versions and builds in
  the system.


1.2 Compiling Emacs from source code.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  EMaCS provides the `./bin/emacs-compile.sh' script to compile GNU
  Emacs from source code.


2 Quick start
=============

2.1 EMaCS Installation
~~~~~~~~~~~~~~~~~~~~~~

  - Git clone the EMaCS `lll-emacs-config' repository
    ,----
    | git clone https://gitlab.com/lll-tools/emacs/lll-emacs-config.git
    | cd lll-emacs-config
    | make help
    `----


2.2 EMaCS Deploy
~~~~~~~~~~~~~~~~

  A default `Makefile' with PHONY targets is provided, execute `make' or
  `make help' for a
  list of the available options.

  - Execute `make check' to search and show the existing GNU Emacs
    config files in the system.

  - Execute `make install-data' to install files needed to run the
    current GNU Emacs
    installation in the system.
    - Search for the current `user-init-file'
    - Backup the current `user-init-file' as `init-user.el' in the same
      location
    - Copy the EMaCS config file `./src/.emacs' file as the current
      `user-init-file'
    - Copy the EMaCS first run file `./src/init-first-run.el' to the
      same location of the
      current `user-init-file'

  - Execute `make install-exec' to clone the GNU Emacs source code
    repository.
    - Git clone GNU Emacs source code in `./emacs' directory

  - Execute `make install' to do both `make install-data' and `make
    install-exec'.


3 Run existing GNU Emacs installation
=====================================

  EMaCS `make install-data' installation will *copy* the file
  `./src/.emacs' to the same
  location and with the same name of the current `user-init-file' found
  in the system.


3.1 Current user-init-file
~~~~~~~~~~~~~~~~~~~~~~~~~~

  EMaCS installation will *backup* the current `user-init-file' config
  of GNU Emacs (any of
  `.emacs' or `.emacs.el' or `./.emacs.d/init.el' or
  `./config/emacs/init.el') to
  `init-user.el' file in the same location of the current config file
  found.


3.2 Customizations first-run-file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  EMaCS installation will *copy* the `init-first-run.el' file in the
  same location of the
  `user-init-file' found.

  EMaCS `user-init-file' will *create* a new empty `custom.el' file in
  the
  `user-emacs-directory' the first time that a new version or build of
  GNU Emacs is runned.

  EMaCS `user-init-file' will search in its same location for the
  `init-first-run.el' file
  with common customizations to *import* them in the new `custom.el'
  file of any new GNU
  Emacs environment.

  EMaCS `user-init-file' will *search* for the `custom.el' file in the
  `user-emacs-directory' created.
  - custom.el, location
  - default.el, (site-lisp) location
  - site-start.el, (site-lisp) location


3.2.1 Run Vanilla
-----------------

  Run your currently installed version of GNU Emacs. EMaCS vanilla
  version of the `.emacs'
  file will use the `init-user.el' file with the backup of the user
  current configuration.
  `(default-directory)/.emacs.<version>-<build>-<date>' directory as
  `.emacs.d' dir.


3.2.2 Run Customized
--------------------

  - custom.el


3.2.3 Run Full
--------------

  - packages, keyboard binds


3.2.4 Run Profile
-----------------

  - specific profile


4 Make
======

  - Run the compilation script.
    ,----
    | ./bin/emacs-compile.sh
    `----
  - Run new compiled Emacs.
    ,----
    | ./emacs/src/emacs
    `----


5 Configuration
===============

5.1 First Run Customizations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Edit `init-first-run.el' file.
  Define your common preferences.


5.2 Melpa packages
~~~~~~~~~~~~~~~~~~

  Edit `.emacs-pck.el' file.
  Define your preferred packages.


5.3 Keyboard shortcuts and alias
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Edit `.emacs-kb.el' file
  Define your key bindings.


5.4 Development el modes
~~~~~~~~~~~~~~~~~~~~~~~~

  Edit `.emacs-dev.el' file.
  Define your Elisp modules under development.


5.5 Source packages
~~~~~~~~~~~~~~~~~~~

  Edit `.emacs-src.el' file.
  Define the packages used from source, NOT from melpa.


6 Contributions
===============

  <https://gitlab.com/lll-tools/emacs/lll-emacs-config/-/issues>


7 Release life-cycle
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


7.1 Only when new fork from previous release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  1. *merge* (--no-commit --no-ff) `vx.y' branch into `dev' branch
     1. Remove ChangeLog file from merge (ours)
     2. Commit merge (should be empty)
