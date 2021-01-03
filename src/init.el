;;; init.el --- main configuration file of GNU Emacs

;; Copyright (C) 2020 luislain.com

;; Maintainer: lll@luislain.com
;; Keywords: config
;; Package: lll-emacs-config
;; Version: 0.1.7
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

;; Any customization before this point should go in site-start.el file
(defconst lll-user-init-directory
      (expand-file-name (file-name-as-directory (file-name-directory user-init-file))))

;; Load debug file
(defconst lll-debug-file
  (expand-file-name "init-debug.el" lll-user-init-directory))
(if (file-exists-p lll-debug-file) (load-file lll-debug-file))

;; https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
;; XDG_CONFIG_HOME Should default to $HOME/.config.
;; TODO: (make-symbolic-link ".config/emacs" "~/.emacs.d")
(defconst lll-xdg-emacs-directory
      (if (getenv "XDG_CONFIG_HOME")
	  (expand-file-name (file-name-as-directory
			     (concat (file-name-as-directory (getenv "XDG_CONFIG_HOME")) "emacs")))
	(expand-file-name (file-name-as-directory "~/.config/emacs"))))
(make-directory lll-xdg-emacs-directory t)

;; TODO: Use chemacs command line arg to load a specific profile
;; https://github.com/plexus/chemacs
;; (command-line-args) invocation-directory installation-directory

;; Emacs variant
(defconst lll-emacs-variant
  (concat emacs-version
	  (if (boundp 'emacs-build-number)
	      (concat "-" (number-to-string emacs-build-number)))
	  (if (boundp 'emacs-build-time)
	      (concat "-" (format-time-string "%Y%m%d" emacs-build-time)))))

;; User current init backup
(defconst lll-init-user-backup-file
  (expand-file-name "init-user-backup.el" lll-user-init-directory))

;; User current init
(defvar lll-init-user-file
  (expand-file-name "init-user.el" lll-user-init-directory))

;; Custom file
(defconst lll-custom-file
  (if (not (boundp 'user-emacs-directory))
      (expand-file-name "custom.el" lll-user-init-directory)
    ;; Customize user-emacs-directory, probably introduced at Emacs 22.1
    (setq-default user-emacs-directory
		  (expand-file-name
		   (file-name-as-directory (concat ".emacs." lll-emacs-variant))
		   lll-xdg-emacs-directory))
    (make-directory user-emacs-directory t)
    ;; Reload default value of dumped variables
    (custom-reevaluate-setting 'auto-save-list-file-prefix)
    (custom-reevaluate-setting 'custom-theme-directory)
    ;; TODO: (setq package-user-dir (expand-file-name ""))
    ;; TODO: (customize user-cache-directory and user-ramdisk-directory
    ;; Set current user init
    (setq-default lll-init-user-file (locate-user-emacs-file "init-user.el"))
    ;; Customize custom-file relative to user-emacs-directory
    (locate-user-emacs-file "custom.el")))

;; Load existing user configuration
(if (file-exists-p lll-init-user-file)
    (load-file lll-init-user-file)
  ;; Load EMaCS config files
  (customize-set-variable 'custom-file lll-custom-file)
  (if (file-exists-p custom-file)
      (load-file custom-file)
    ;; IF custom-file does NOT exists ask to the user for use current config
    (if (and (file-exists-p lll-init-user-backup-file)
	     (y-or-n-p "Do you want to use your current configuration ? ")
	     (copy-file lll-init-user-backup-file lll-init-user-file 0)
	     (load-file lll-init-user-file))
	(message "Use existing user configuration.")
      ;; IF user does NOT use current config, create the custom-file
      (with-temp-file custom-file
	(insert ";; Do manual customizations in here if M-x customize cannot be used") (newline 3)
	(insert ";; Do NOT modify lines below this point ......................") (newline 3))
      ;; Write in custom-file the first-run-customizations using customize-set-variable
      (defconst lll-first-run-file (expand-file-name "init-first-run.el" lll-xdg-emacs-directory))
      (when (file-exists-p lll-first-run-file)
	(load-file lll-first-run-file) ; Load first-run-customizations from config-file
	(message "Create new custom file with first run file."))
      (customize-save-customized) ; Save first-run customizations to custom-file
      (package-initialize)))
  ;; Check if it is the first time
  (unless (file-exists-p lll-init-user-file)
    ;; Load user profile
    (defconst lll-profile-init (expand-file-name "init-profile.el" lll-xdg-emacs-directory))
    (when (file-exists-p lll-profile-init)
      (defconst lll-profile-custom (locate-user-emacs-file "custom-profile.el"))
      (unless (file-exists-p lll-profile-custom)
	(with-temp-file lll-profile-custom
	  (insert ";; Load default init-profile customizations.") (newline)
	  (insert "(load-file lll-profile-init)") (newline 2)
	  (insert (concat ";; Add below specific customizations for " lll-emacs-variant)) (newline 3)
	  ))
      (load-file lll-profile-custom))
    ;; Load packages from melpa, Emacs 27 and below
    (defconst lll-packages-init (expand-file-name "init-packages.el" lll-xdg-emacs-directory))
    (if (< emacs-major-version 28)
	(when (file-exists-p lll-packages-init)
	  (defconst lll-packages-custom (locate-user-emacs-file "custom-packages.el"))
	  (unless (file-exists-p lll-packages-custom)
	    (with-temp-file lll-packages-custom
	      (insert ";; Load default init-packages.") (newline)
	      (insert "(load-file lll-packages-init)") (newline 2)
	      (insert (concat ";; Add below specific packages for " lll-emacs-variant)) (newline 3)
	      ))
	  (load-file lll-packages-custom))
      ;; Load packages from source, Emacs 28 and above
      (defconst lll-sources-init (expand-file-name "init-sources.el" lll-xdg-emacs-directory))
      (when (file-exists-p lll-sources-init)
	(defconst lll-sources-custom (locate-user-emacs-file "custom-sources.el"))
	(unless (file-exists-p lll-sources-custom)
	  (with-temp-file lll-sources-custom
	    (insert ";; Load default init-sources.") (newline)
	    (insert "(load-file lll-sources-init)") (newline 2)
	    (insert (concat ";; Add below specific sources for " lll-emacs-variant)) (newline 3)
	    ))
	(load-file lll-sources-custom)))
    ;; Load development projects
    (defconst lll-development-init (expand-file-name "init-dev.el" lll-xdg-emacs-directory))
    (when (file-exists-p lll-development-init)
      (defconst lll-development-custom (locate-user-emacs-file "custom-dev.el"))
      (unless (file-exists-p lll-development-custom)
	(with-temp-file lll-development-custom
	  (insert ";; Load default init-development.") (newline)
	  (insert "(load-file lll-development-init)") (newline 2)
	  (insert (concat ";; Add below specific development for " lll-emacs-variant)) (newline 3)
	  ))
      (load-file lll-development-custom))
    )
  )
;; Any customization after this point should go in default.el file
;; Customize variables using (M-x customize) and (M-x org-customize) whenever possible
