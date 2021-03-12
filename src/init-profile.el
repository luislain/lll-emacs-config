;;; init-profile.el --- User customizations configuration file

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
;; User customizations, key bindings, macros and alias.

;;; Code:

;;; USER CUSTOMIZATIONS
;; ;; Git user
;; (customize-set-variable 'user-full-name		"User Name")
;; (customize-set-variable 'user-mail-address	"username@example.com")
;; ;; ChangeLog user
;; (customize-set-variable 'add-log-full-name	"User Name")
;; (customize-set-variable 'add-log-mailing-address "username@example.com")

;;; KEY BINDINGS
;; (define-key global-map (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-M-,") 'indent-region)
(global-set-key (kbd "C-x M-b") 'buffer-menu)

;; Globals mandatory for Org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; MACROS
(fset 'lll-sort-buffer-list
   (kmacro-lambda-form [?\C-x ?\C-b ?\C-x ?o ?\C-s ?t ?e ?r ?a ?c ?t ?i ?o return ?S ?S] 0 "%d"))

;;; ALIAS
(defun lll-flush-blank-lines ()
  "Delete blank lines."
  (interactive)
  (message "Flush %d blank lines in buffer %s from %d to %d"
	   (flush-lines "^ *$") ;; (point) (point-max) t))
	   (current-buffer) (point) (point-max)))

(defun lll-flush-blank-lines-region ()
  "Flush blank lines in the region of the current buffer."
  (interactive)
  (save-excursion
    ;; (exchange-point-and-mark)
    (flush-lines "^ *$" (region-beginning) (region-end) t))
  )
