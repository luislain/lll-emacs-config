;;; .emacs --- main configuration file of GNU Emacs

;; Copyright (C) 2020 luislain.com

;; Maintainer: lll@luislain.com
;; Keywords: config
;; Package: lll-emacs-config
;; Version: 0.1.5
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
(setq lll-init-string (format "Version (%s) build (%s) Default directory (%s) User directory (%s) User init file (%s) Custom file (%s) Auto save prefix (%s)"
			      emacs-version emacs-build-number default-directory user-emacs-directory user-init-file custom-file auto-save-list-file-prefix))

;; Any customization before this point should go in site-start.el file

;; https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
;; XDG_CONFIG_HOME  Should default to $HOME/.config.

;; Customize user-emacs-directory, probably introduced at Emacs 22.1
;; Customize custom-file relative to user-emacs-directory
(if (not (boundp 'user-emacs-directory))
    (setq-default custom-file (expand-file-name "custom.el"))
  (setq-default user-emacs-directory
		(expand-file-name
		 (concat ".emacs."
			 emacs-version
			 (if (boundp 'emacs-build-number)
			     (concat "-" (number-to-string emacs-build-number)))
			 (if (boundp 'emacs-build-time)
			     (concat "-" (format-time-string "%Y%m%d" emacs-build-time)))
			 "/")
		 default-directory)) ;; user-init-file dir
  (make-directory user-emacs-directory t)
  (setq-default custom-file (expand-file-name "custom.el" user-emacs-directory))
  ;; Reload default value of bumped variables
  (custom-reevaluate-setting 'auto-save-list-file-prefix))

;; (make-symbolic-link ".config/emacs" "~/.emacs.d")

;; TODO: (setq package-user-dir (expand-file-name ""))
;; TODO: (customize user-cache-directory and user-ramdisk-directory

;; Load or create the custom-file
(if (file-exists-p custom-file)
    (load custom-file)
  ;; If custom-file does NOT exists
  ;; Create the custom-file
  (with-temp-file custom-file
    (insert ";; Do manual customizations in here if M-x customize cannot be used")
    (newline) (newline)
    (insert ";; Do NOT modify lines below this point ......................")
    (newline))
  ;; Write in custom-file the first-run-customizations using customize-set-variable
  (setq lll-first-run-file
	(expand-file-name
	 "init-first-run.el"
	 default-directory)) ; user-init-file dir
  (and (file-exists-p lll-first-run-file)
       (load-file lll-first-run-file) ; Load first-run-customizations from config-file
       (customize-save-customized) ; Save first-run-customizations to custom-file
    ))

;; Search user configuration
(setq lll-init-user-file
      (expand-file-name
       "init-user.el"
       default-directory)) ; user-init-file dir

(if (file-exists-p lll-init-user-file)
    (load-file lll-init-user-file)
  ;; Load EMaCS config files (user onfiguration not found)

  ;; TODO: Use chemacs command line arg to load a specific profile
  ;; https://github.com/plexus/chemacs
  ;; (command-line-args) invocation-directory installation-directory

  ;; Load packages from melpa, Emacs 27 and below
  (unless (> emacs-major-version 27)
    (setq packages-file (expand-file-name ".emacs-pck.el"))
    (when (file-exists-p packages-file)
      (load-file packages-file))
    )

  ;; Load packages from source, Emacs 28 and above
  (when (> emacs-major-version 27)
    (setq sources-file (expand-file-name ".emacs-src.el"))
    (when (file-exists-p sources-file)
      (load-file sources-file))
    )

  ;; Load key bindings
  (setq key-bindings-file (expand-file-name ".emacs-kb.el"))
  (when (file-exists-p key-bindings-file)
    (load-file key-bindings-file))

  ;; Load development projects
  (setq development-file (expand-file-name ".emacs-dev.el"))
  (when (file-exists-p development-file)
    (load-file development-file))
  )
)

;; Any customization after this point should go in default.el file
;; Customize variables using (M-x customize) and (M-x org-customize) whenever possible
