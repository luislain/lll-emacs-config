;;; init-packages.el --- packages configuration file of GNU Emacs

;; Copyright (C) 2020 luislain.com

;; Maintainer: lll@luislain.com
;; Keywords: config
;; Package: lll-emacs-config

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

;; Stable packages
(message "Packages")
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
;;(setq user-emacs-directory "~/.cache/emacs")
;;(use-package no-littering)
;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
;;(setq auto-save-file-name-transforms
;;       `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; Org customizations
;; (require 'org)
;; (customize-set-variable 'org-return-follows-link t)
;; (when (file-directory-p (expand-file-name "~/Documents/"))
;;     (customize-set-variable 'org-agenda-files '("~/Documents/")))

;; TODO: (customize-set-variable 'org-export-backends ())
;; TODO: (customize-set-variable 'org-babel-load-languages
;; 			(add-to-list
;; 			 (add-to-list
;; 			  (add-to-list
;; 			   'org-babel-load-languages
;; 			   '("shell" . t) t)
;; 			  '("python" . t) t)
;; 			 '("latex" . t) t))

;; (use-package ox-gfm
;;   :ensure t
;;   :after org ;; (featurep 'org)
;;   :config
;;   (eval-after-load "org" '(require 'ox-gfm nil t)))

;; Globals mandatory for Org mode
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)

(use-package org
  :ensure nil
  :defer t
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
	 )
  :custom
  (org-log-done 'time)
  (calendar-latitude 43.65107) ;; set it to your location, currently default: Toronto, Canada
  (calendar-longitude -79.347015) ;; Usable for M-x `sunrise-sunset' or in `org-agenda'
  ;; (org-export-backends (quote (ascii html icalendar latex md odt)))
  )
;; (require 'org) 
;; (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)) 

;; (defun lll-org-confirm-babel-evaluate (lang body)
;;   (not (or (string= lang "ditaa") (string= lang "sql") )))
;; (setq org-confirm-babel-evaluate #'lll-org-confirm-babel-evaluate)

;; (use-package markdown-mode
;;   :ensure t
;;   :commands (markdown-mode gfm-mode)
;;   :mode (("README\\.md\\'" . gfm-mode)
;;          ("\\.md\\'" . gfm-mode)
;;          ("\\.markdown\\'" . markdown-mode))
;;   :init (setq markdown-command "markdown"))

;; (use-package php-mode
;;   :ensure t)

;; (use-package lua-mode
;;   :ensure t
;;   :mode ("\\.lua\\'" . lua-mode))

;; (use-package gitlab-ci-mode
;;   :ensure t)

;; (use-package dockerfile-mode
;;   :ensure t
;;   :commands (dockerfile-mode)
;;   :mode (("Dockerfile\\'" . dockerfile-mode)))

;; (use-package gnuplot
;;   :ensure t
;;   :commands (gnuplot-mode)
;;   :mode (("\\.gp$" . gnuplot-mode)
;; 	 ("\\.dem$" . gnuplot-mode)))

;; ;; Bleeding edge packages
;; (when (and (boundp 'lll-ssl-available)
;; 	   lll-ssl-available)

;;   ;; :after graphql
;;   (use-package magit
;;     :ensure t
;;     :bind (("C-x g" . magit-status)
;; 	   ("C-x M-g" . magit-dispatch))
;;     )

;;   (use-package docker
;;     :ensure t
;;     :bind ("C-c d" . docker))

;;   (use-package nov
;;     :ensure t
;;     :mode ("\\.epub\\'" . nov-mode))

;;   (use-package csv-mode
;;     :ensure t
;;     :mode ("\\.[Cc][Ss][Vv]\\'" . csv-mode))

;;   )
