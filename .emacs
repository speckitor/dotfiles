(setq custom-file "~/.emacs.custom.el")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(setq
 use-package-always-ensure t
 use-package-verbose t)

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(setq ring-bell-function 'ignore)

(set-face-attribute 'default nil :font "Iosevka-16")

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq-default dired-dwim-target t)
(windmove-default-keybindings)

(setq split-height-threshold 0)
(setq split-width-threshold nil)

(setq-default show-trailing-whitespace t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(add-to-list 'load-path "~/.emacs.local/")
(require 'simpc-mode)
(require 'simpc3-mode)

(use-package haskell-mode)
(use-package go-mode)

(ido-mode 1)
(ido-everywhere 1)
(use-package smex
  :init
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

(use-package company
  :init
  (global-company-mode)
  :config
  (setq company-minimum-prefix-length 3
        company-idle-delay 2.0)
  (global-set-key (kbd "M-<tab>") 'company-complete))

(use-package multiple-cursors
  :init
  (require 'multiple-cursors)
  (global-set-key (kbd "M-n") 'mc/mark-next-like-this)
  (global-set-key (kbd "M-p") 'mc/mark-previous-like-this)
  (global-set-key (kbd "M-[") 'mc/mark-all-like-this))

(use-package doric-themes
  :init
  (load-theme 'doric-walnut t))
