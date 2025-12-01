(setq custom-file "~/.emacs.custom.el")

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq
 use-package-always-ensure t
 use-package-verbose t)

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-face-attribute 'default nil :font "IosevkaNF-16")

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(repeat-mode 1)

(ido-mode 1)
(ido-everywhere 1)

(setq-default dired-dwim-target t)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox t))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))

(defun my-c-mode-hook ()
  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(use-package rust-mode)
(use-package haskell-mode)

(windmove-default-keybindings)

(global-set-key (kbd "C-<backspace>") #'kill-region)
(global-set-key (kbd "C-w") #'backward-kill-word)
(global-set-key (kbd "C-,") #'set-mark-command)
(global-set-key (kbd "C-.") #'rectangle-mark-mode)
(global-set-key (kbd "C-j") #'mark-word)

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay nil)
  (setq company-minimum-prefix-length 1)
  (global-set-key (kbd "M-<tab>") 'company-complete))

(use-package multiple-cursors
  :bind
  (("M-n" . mc/mark-next-like-this)
   ("M-p" . mc/mark-previous-like-this)
   ("C-c C-a" . mc/mark-all-like-this)))

(use-package smex
  :init
  (smex-initialize)
  :bind ("M-x" . smex))

(use-package magit
  :bind ("C-x g" . magit-status))
