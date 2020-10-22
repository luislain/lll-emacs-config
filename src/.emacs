
;; before-init-time after-init-time
(setq lll-init-string (format 
       "Version (%s) build (%s) Default directory (%s) User directory (%s)
User init file (%s) Custom file (%s) Auto save prefix (%s)"
       emacs-version emacs-build-number default-directory user-emacs-directory
       user-init-file custom-file auto-save-list-file-prefix))
;; Any customization before this point should go in site-start.el file

;; Customize user-emacs-directory
(if (< emacs-major-version 23)
    ;; user-emacs-directory was probably introduced at Emacs 22.1
    (setq custom-file (expand-file-name "custom.el"))
  ;; For Emacs 23 and above
  (setq user-emacs-directory
	(expand-file-name
	 (concat "~/.config/emacs/"
		 emacs-version
		 "-" (number-to-string emacs-build-number)
		 "-" (format-time-string "%Y%m%d" emacs-build-time) "/")))
  (make-directory user-emacs-directory t)
  ;; Reload default value of bumped variables
  (custom-reevaluate-setting 'auto-save-list-file-prefix)
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory)))
;; TODO: (setq package-user-dir (expand-file-name ""))
;; TODO: (customize user-cache-directory and user-ramdisk-directory
;; TODO: Use chemacs command line arg for specific user-emacs-directory
;; https://github.com/plexus/chemacs
;; (command-line-args) invocation-directory installation-directory

;; After defining the custom-file, check what to do
(if (file-exists-p custom-file)
    (load custom-file)
  ;; If custom-file does NOT exists create a new one and initialize it
  (with-temp-file custom-file
    (insert ";; Do manual customizations in here if M-x customize cannot be used")
    (newline) (newline)
    (insert ";; Do NOT modify lines below this point ......................")
    (newline))
  ;; Use customize-set-variable for initializing values in first run customizations file
  (setq first-run-custom-file
	(expand-file-name ".emacs-frc.el")) ; Search for the file where .emacs is located
  ;; Make first-run-customizations persistent
  (and (file-exists-p first-run-custom-file)
       (load-file first-run-custom-file) ; Load first run customizations from config-file
       (customize-save-customized) ; Save first run customizations to custom-file
    ))

;; Load user configuration or lll customizations
(setq lll-user-emacs-config-file (expand-file-name ".emacs-user"))
(if (file-exists-p lll-user-emacs-config-file)
    (load-file lll-user-emacs-config-file)

  ;; Load packages from melpa, Emacs 27 and below
  (unless (> emacs-major-version 27)
    (setq packages-file (expand-file-name ".emacs-pck.el"))
    (when (file-exists-p packages-file)
      (load-file packages-file))
    )

  ;; Load packages from source, Emacs 28
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

;; Any customization after this point should go in default.el file
;; Customize variables using (M-x customize) and (M-x org-customize) whenever possible
