;; Emacs customizations
;; Carefully cherry-pick what customizations are done
;; Symbolp values before set the variable
;; Use debug-init if problems found

;; Backup customizations
(customize-set-variable 'backup-directory-alist
			(list (cons "." (expand-file-name (file-name-as-directory "backups/local")
							  user-emacs-directory))))
(customize-set-variable 'tramp-backup-directory-alist
			(list (cons "." (expand-file-name (file-name-as-directory "backups/tramp")
							  user-emacs-directory))))
;; (customize-set-variable 'make-backup-files nil)
(customize-set-variable 'backup-by-copying	t)
(customize-set-variable 'delete-old-versions	t)
(customize-set-variable 'kept-new-versions	3)
(customize-set-variable 'kept-old-versions	2)
(customize-set-variable 'version-control	t)
;; (customize-set-variable 'vc-make-backup-files t)
(customize-set-variable 'vc-command-messages	t)

;; Other customizations
(customize-set-variable 'show-paren-mode t)
(customize-set-variable 'display-time-24hr-format t)
(customize-set-variable 'calendar-date-style 'iso)
(customize-set-variable 'tool-bar-mode nil)
(customize-set-variable 'custom-enabled-themes '(tango-dark))
(customize-set-variable 'desktop-auto-save-timeout nil)
(customize-set-variable 'desktop-restore-frames nil)
(customize-set-variable 'desktop-save-mode t)
(customize-set-variable 'add-log-dont-create-changelog-file nil)
(customize-set-variable 'shell-command-prompt-show-cwd t)
(customize-set-variable 'dired-listing-switches "--group-directories-first -al")
(customize-set-variable 'show-trailing-whitespace t)

;; Packages customizations
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (if (not no-ssl)
      (customize-set-variable 'package-archives
			      (add-to-list 'package-archives
					   (cons "melpa" (concat proto "://melpa.org/packages/")) t))
    ;; '("melpa" . "https://melpa.org/packages/") t))
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again.")
    (customize-set-variable 'package-archives
			    (add-to-list 'package-archives
					 (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t))
    ;; '("melpa-stable" . "http://stable.melpa.org/packages/") t)))
    )
  )
;; (package-initialize)

;; Org customizations
(require 'org)
(customize-set-variable 'org-return-follows-link t)
(when (file-directory-p (expand-file-name "~/Documents/"))
    (customize-set-variable 'org-agenda-files '("~/Documents/")))
;; TODO: (customize-set-variable 'org-export-backends ())
;; TODO: (customize-set-variable 'org-babel-load-languages
;; 			(add-to-list
;; 			 (add-to-list
;; 			  (add-to-list
;; 			   'org-babel-load-languages
;; 			   '("shell" . t) t)
;; 			  '("python" . t) t)
;; 			 '("latex" . t) t))
