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

;;(require 'package)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;;(require 'use-package)

(use-package ox-gfm
  :ensure t
  :after org ;; (featurep 'org)
  :config
  (eval-after-load "org" '(require 'ox-gfm nil t)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "markdown"))

;; :after graphql
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch))
  )

(use-package gitlab-ci-mode
  :ensure t)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package dockerfile-mode
  :ensure t
  :commands (dockerfile-mode)
  :mode (("Dockerfile\\'" . dockerfile-mode)))

(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode))

(use-package csv-mode
  :ensure t
  :mode ("\\.[Cc][Ss][Vv]\\'" . csv-mode))

(use-package php-mode
  :ensure t)

(use-package lua-mode
  :ensure t
  :mode ("\\.lua\\'" . lua-mode))

(use-package gnuplot
  :ensure t
  :commands (gnuplot-mode)
  :mode (("\\.gp$" . gnuplot-mode)
	 ("\\.dem$" . gnuplot-mode)))
