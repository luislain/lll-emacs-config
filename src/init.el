;;; init.el --- main configuration file of GNU Emacs

;; Copyright (C) 2020 luislain.com

;; Maintainer: lll@luislain.com
;; Keywords: config
;; Package: lll-emacs-config
;; Version: 0.1.8
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

;; loadup.el

;; startup.el

;; L396 auto-save-list-file-prefix <- user-emacs-directory
;; normal-top-level
;; -> L538 startup--xdg-or-homedot (.emacs.d) -> user-emacs-directory
;; -> L548 load-path <- data-directory ../lisp
;; -> L677 command-line
;; -> L1224 startup--load-user-init-file (early-init)
;; -> L1369 startup--load-user-init-file (site-start & init)
;; user-emacs-directory -> startup-init-directory

;; early-init.el
;; Any customization before this point should go in site-start.el file (site-run-file)
;; package-directory-list
;; package-user-dir
;; user-real-login-name

;; (invocation-directory)
;; (default-directory)

(defconst lll-user-init-directory
  (expand-file-name (file-name-as-directory (file-name-directory user-init-file)))
  "The directory used for the `user-init-file' file.")

;; User current init file
(defvar lll-user-init-file
  (expand-file-name "init-user.el" lll-user-init-directory)
  "The complete path to the file with the profile of the user configuration.")

;; User current init file backup
(defconst lll-user-init-file-backup
  (expand-file-name "init-user-backup.el" lll-user-init-directory)
  "The complete path to the file storing the previous user configuration.")

;; Load debug file
(defconst lll-debug-file
  (expand-file-name "init-debug.el" lll-user-init-directory)
  "The complete path of the file with the lll-emacs-config debug options.")
(if (file-exists-p lll-debug-file) (load-file lll-debug-file))

;; https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
;; XDG_CONFIG_HOME Should default to $HOME/.config.
;; TODO: (make-symbolic-link ".config/emacs" "~/.emacs.d")
;; Check compatibility with Emacs 26 and lower
(if (boundp 'startup--xdg-config-home-emacs)
    (defvaralias 'lll-xdg-emacs-directory 'startup--xdg-config-home-emacs
      "XDG compatible directory based on `startup--xdg-config-home-emacs'")
  (defconst lll-xdg-emacs-directory
    (let ((xdg-config-home (getenv "XDG_CONFIG_HOME")))
      (if xdg-config-home
	  (expand-file-name (file-name-as-directory
			      (concat (file-name-as-directory xdg-config-home)
				      "emacs"))))
      ;;startup--xdg-config-default
      (expand-file-name (file-name-as-directory "~/.config/emacs")))
    "The path to the XDG-compatible directory for GNU Emacs."))

(make-directory lll-xdg-emacs-directory t)

;; TODO: Use chemacs command line arg to load a specific profile
;; https://github.com/plexus/chemacs
;; (command-line-args) invocation-directory installation-directory

;; GNU Emacs variant
(defconst lll-emacs-variant
  (concat emacs-version
	  (if (boundp 'emacs-build-number)
	      (concat "-" (number-to-string emacs-build-number)))
	  (if (boundp 'emacs-build-time)
	      (concat "-" (format-time-string "%Y%m%d" emacs-build-time))))
  "The string defining the variant of the GNU Emacs instance running.

This string will be used to create the `user-emacs-directory'.")

;; 2befb4f0a1494f699f56215d5f28ba055663d881
;; Author:     Paul Eggert <eggert@cs.ucla.edu>
;; AuthorDate: Sat Aug 31 14:47:04 2019 -0700
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=583#56
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=15539#40
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=37354

;; Define Custom file and set user-emacs-directory as a side effect
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
    (custom-reevaluate-setting 'abbreviated-home-dir)
    (custom-reevaluate-setting 'abbrev-file-name)
    ;; TODO: (setq package-user-dir (expand-file-name ""))
    ;; TODO: (customize user-cache-directory and user-ramdisk-directory
    ;; Set current user init, at Emacs 23.1
    (setq-default lll-user-init-file (locate-user-emacs-file "init-user.el"))
    ;; Customize custom-file relative to user-emacs-directory
    (locate-user-emacs-file "custom.el"))
  "The complete path to the file storing customizations.

Sets `user-emacs-directory' as a side effect.
Updates `lll-user-init-file' value based on `user-emacs-directory' as a side effect.")

;; Load current user configuration or EMaCS config files
(if (file-exists-p lll-user-init-file)
    (load-file lll-user-init-file)
  ;; Load EMaCS config files
  (require 'package)
  ;; Load or create custom-file.
  (customize-set-variable 'custom-file lll-custom-file)
  ;; (setq custom-file lll-custom-file)

  (if (file-exists-p custom-file)
      (load-file custom-file)
    ;; IF custom-file does NOT exists ask to the user for using the current config
    (if (and (file-exists-p lll-user-init-file-backup)
	     (y-or-n-p "Do you want to use your current configuration ? ")
	     (copy-file lll-user-init-file-backup lll-user-init-file 0)
	     (load-file lll-user-init-file))
	(message "Use existing `lll-user-init-file' user configuration.")
      ;; IF user does NOT want to use the current config, create the custom-file
      (with-temp-file custom-file
	(insert ";; Do manual customizations in here if M-x customize cannot be used") (newline 3)
	(insert ";; Do NOT modify lines below this point ......................") (newline 2)
	)
      ;; Load first-run
      (defconst lll-first-run-file (expand-file-name "init-first-run.el" lll-xdg-emacs-directory))
      (if (file-exists-p lll-first-run-file)
	  (load-file lll-first-run-file) ; Load first-run-customizations from config-file
	(warn "Missign first run init file: %S" lll-first-run-file))
      )
    )
  (message "Message 01")
  ;; Check that it is NOT the first run using the lll-init-user-file
  (unless (file-exists-p lll-user-init-file)
    (message "Message 02")
    (package-initialize)
    ;; Load EMaCS packages file. Use melpa for Emacs 27 and below
    (defconst lll-packages-init (expand-file-name "init-packages.el" lll-xdg-emacs-directory))
    (if (< emacs-major-version 28)
	(when (file-exists-p lll-packages-init)
	    (message "Message 03")
	  (defconst lll-packages-custom (locate-user-emacs-file "custom-packages.el"))
	  (unless (file-exists-p lll-packages-custom)
	    (message "Message 03.1")
	    (with-temp-file lll-packages-custom
	      (insert ";; Load default init-packages.") (newline)
	      (insert "(load-file lll-packages-init)") (newline 2)
	      (insert (concat ";; Add below specific packages for "
			      lll-emacs-variant))
	      (newline 3)
	      ))
	  ;; (condition-case lll-load-packages-error
	  ;;(y-or-n-p "Before-packages")
	  (load-file lll-packages-custom)
	  ;;(y-or-n-p "After-packages")
	  ;; (error
	  ;;  (warn "Error loading packages (%S)" (error-message-string lll-load-packages-error))))
	  )
      ;; Load packages from source, Emacs 28 and above
      (defconst lll-sources-init (expand-file-name "init-sources.el" lll-xdg-emacs-directory))
      (message "Message 05")
      (when (file-exists-p lll-sources-init)
	(defconst lll-sources-custom (locate-user-emacs-file "custom-sources.el"))
	(unless (file-exists-p lll-sources-custom)
	  (with-temp-file lll-sources-custom
	    (insert ";; Load default init-sources.") (newline)
	    (insert "(load-file lll-sources-init)") (newline 2)
	    (insert (concat ";; Add below specific sources for "
			    lll-emacs-variant))
	    (newline 3)
	    ))
	(load-file lll-sources-custom)))
    ;; Load development projects
    (defconst lll-development-init (expand-file-name "init-dev.el" lll-xdg-emacs-directory))
    (message "Message 06")
    (when (file-exists-p lll-development-init)
      (defconst lll-development-custom (locate-user-emacs-file "custom-dev.el"))
      (unless (file-exists-p lll-development-custom)
	(with-temp-file lll-development-custom
	  (insert ";; Load default init-development.") (newline)
	  (insert "(load-file lll-development-init)") (newline 2)
	  (insert (concat ";; Add below specific development for "
			  lll-emacs-variant))
	  (newline 3)
	  ))
      (load-file lll-development-custom))
    ;; Load EMaCS profile init file.
    (defconst lll-profile-init (expand-file-name "init-profile.el" lll-xdg-emacs-directory))
    (message "Message 07")
    (when (file-exists-p lll-profile-init)
      (defconst lll-profile-custom (locate-user-emacs-file "custom-profile.el"))
      (unless (file-exists-p lll-profile-custom)
	(message "Message 08")
	(with-temp-file lll-profile-custom
	  (insert ";; Load default init-profile customizations.") (newline)
	  (insert "(load-file lll-profile-init)") (newline 2)
	  (insert (concat ";; Add below specific customizations for " lll-emacs-variant)) (newline 3)
	  ))
      (load-file lll-profile-custom))
    )
  )

;; Any customization after this point should go in default.el file
;; Customize variables using (M-x customize) and (M-x org-customize) whenever possible
