;;; .emacs --- main configuration file of GNU Emacs

;; Copyright (C) 2020 luislain.com

;; Maintainer: lll@luislain.com
;; Keywords: config
;; Package: lll-emacs-config
;; Version: 0.1.6
;; Package-Requires: ((emacs "24.5") (transient "0.2.0"))

;; This file is NOT part of GNU Emacs.

;; This file is part of EMaCS.

;; Emacs Make and Configuration System (EMaCS) is free software; you can
;; redistribute it and/or modify it under the terms of the GNU General
;; Public License as published by the Free Software Foundation; either
;; version 3 of the License, or (at your option) any later version.

;; Emacs Make and Configuration System (EMaCS) is distributed in the hope
;; that it will be useful, but WITHOUT ANY WARRANTY; without even the
;; implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with EMaCS.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

;; setq lll-init-string-before in site-start.el file
;; setq lll-init-string-after in default.el file
(setq lll-init-string (format "Version (%s) build (%s) Default directory (%s) User directory (%s) User init file (%s) Custom file (%s) Auto save prefix (%s) Custom theme dir (%s)"
			      emacs-version emacs-build-number default-directory user-emacs-directory user-init-file custom-file auto-save-list-file-prefix custom-theme-directory))

;; Any customization before this point should go in site-start.el file

;; https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
;; XDG_CONFIG_HOME  Should default to $HOME/.config.
;; TODO: (make-symbolic-link ".config/emacs" "~/.emacs.d")
;; (getenv "HOME")
(setq lll-xdg-emacs-directory (expand-file-name (file-name-as-directory "~/.config/emacs")))
(make-directory lll-xdg-emacs-directory t)

;; TODO: Use chemacs command line arg to load a specific profile
;; https://github.com/plexus/chemacs
;; (command-line-args) invocation-directory installation-directory

;; Customize user-emacs-directory, probably introduced at Emacs 22.1
(if (not (boundp 'user-emacs-directory))
    (setq lll-custom-file (expand-file-name "custom.el"))
  (setq-default user-emacs-directory
		(expand-file-name
		 (file-name-as-directory
		  (concat ".emacs."
			  emacs-version
			  (if (boundp 'emacs-build-number)
			      (concat "-" (number-to-string emacs-build-number)))
			  (if (boundp 'emacs-build-time)
			      (concat "-" (format-time-string "%Y%m%d" emacs-build-time)))))
		 lll-xdg-emacs-directory)) ;; or user-init-file dir
  (make-directory user-emacs-directory t)
  ;; Reload default value of dumped variables
  (custom-reevaluate-setting 'auto-save-list-file-prefix)
  (custom-reevaluate-setting 'custom-theme-directory)
  ;; Custom file
  (setq lll-custom-file (expand-file-name "custom.el" user-emacs-directory)))
;; TODO: (setq package-user-dir (expand-file-name ""))
;; TODO: (customize user-cache-directory and user-ramdisk-directory

;; Customize custom-file relative to user-emacs-directory
;; (setq-default custom-file lll-custom-file)
(customize-set-variable 'custom-file lll-custom-file)

;; Load existing user configuration, (make install)
(setq lll-init-user-backup-file (expand-file-name "init-user-backup.el")) ; user-init-file dir
(setq lll-init-user-file (expand-file-name "init-user.el")) ; user-init-file dir
(when (file-exists-p lll-init-user-file)
  (load-file lll-init-user-file)
  (message "Load existing user init file.")
  )

;; Load EMaCS config files
;; TODO: Test if there are some customized values not saved (load user-init) or create first-run
;; (when (get symbol 'customized-value)

;; Load or create the custom-file
(if (file-exists-p custom-file)
    (load custom-file)
  ;; If custom-file does NOT exists
  ;; Ask user for use existing config
  (and (file-exists-p lll-init-user-backup-file)
       (y-or-n-p "Do you want to use your current configuration ? ")
       (copy-file lll-init-user-backup-file lll-init-user-file 0)
       (load lll-init-user-file)
       (message "Use exisitng user configuration."))
  ;; Create the custom-file
  (unless (file-exists-p custom-file)
    (with-temp-file custom-file
      (insert ";; Do manual customizations in here if M-x customize cannot be used") (newline)
      (newline)
      (insert ";; Do NOT modify lines below this point ......................") (newline))
    ;; Write in custom-file the first-run-customizations using customize-set-variable
    (setq lll-first-run-file (expand-file-name "init-first-run.el" lll-xdg-emacs-directory))
    (when (file-exists-p lll-first-run-file)
      (load-file lll-first-run-file) ; Load first-run-customizations from config-file
      (message "Create new custom file with first run file."))
    (customize-save-customized) ; Save user-init or first-run customizations to custom-file
    )
  )

;; Load user custom
(setq lll-profile-file (expand-file-name "init-profile.el" lll-xdg-emacs-directory))
(if (file-exists-p lll-profile-file) (load-file lll-profile-file))

;; Load packages from melpa, Emacs 27 and below
(setq lll-packages-file (expand-file-name "init-packages.el" lll-xdg-emacs-directory))
(if (< emacs-major-version 28)
    (if (file-exists-p lll-packages-file) (load-file lll-packages-file))
  ;; Load packages from source, Emacs 28 and above
  (setq lll-sources-file (expand-file-name "init-sources.el" lll-xdg-emacs-directory))
  (if (file-exists-p lll-sources-file) (load-file lll-sources-file))
  )

;; Load key bindings
(setq lll-keybindings-file (expand-file-name "init-key-bindings.el" lll-xdg-emacs-directory))
(if (file-exists-p lll-keybindings-file) (load-file lll-keybindings-file))

;; Load development projects
(setq lll-development-file (expand-file-name "init-dev-projects.el" lll-xdg-emacs-directory))
(if (file-exists-p lll-development-file) (load-file lll-development-file))

;; Any customization after this point should go in default.el file
;; Customize variables using (M-x customize) and (M-x org-customize) whenever possible
