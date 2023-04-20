;                 Center text buffer
(defun my-resize-margins ()
  (let ((margin-size (/ (- (frame-width) 80) 2)))
    (set-window-margins nil margin-size margin-size)))

(add-hook 'window-configuration-change-hook #'my-resize-margins)
(my-resize-margins)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
;                 Disable anoing warning
; (setq warning-minimum-level :emergency)

;                 Basic customize and config
(set-face-attribute 'default nil :family "FiraCode Regular NFM" :height 140) 
(setq inhibit-startup-message t)
(defalias 'yes-or-no-p 'y-or-n-p)
(scroll-bar-mode -1)                       
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;                      Package managers
(require 'package)
(require 'use-package)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

(package-initialize)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;                 Powerline
(use-package powerline
  :ensure t)
(powerline-default-theme)

;                 OrgMode
(use-package org
  :ensure t
  :config
  (setq org-clock-continuously non-nil))


(use-package org-superstar  ;; Improved version of org-bullets
    :ensure t
    :config
    (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))
(setq org-startup-indented t)           ;; Indent according to section
(setq org-startup-with-inline-images t) ;; Display images in-buffer by default

;                 EvilMode
(use-package evil
  :ensure t
  :init (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1))

(use-package evil-org
  :ensure t
  :after (evil org)
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(setq org-log-done t)
(setq org-agenda-files '("/mnt/storage/08_Notes/Agenda"))
(global-set-key (kbd "C-c a") 'org-agenda)


;                 Moonfly theme
(straight-use-package 
  '(doom-moonfly-theme :type git :host github :repo "stackmystack/doom-moonfly-theme"))
(load-theme 'doom-moonfly t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("99c8b8dda5cbf702891baf066627c55328d651b0c2d91108c8f62bcadd15581c" "21a16ad93c996b7c6b0ecbf9a8ab8b5a56a5c098533f42e2904c738afbc6f205" default))
 '(package-selected-packages '(org-superstar evil use-package))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

