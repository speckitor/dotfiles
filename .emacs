(setq custom-file "~/.emacs.custom.el")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq auto-save-default nil)
(setq make-backup-files nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(global-set-key (kbd "C-c c") 'compile)

(add-hook 'c-mode-common-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (setq c-basic-offset 4)))

(use-package timu-rouge-theme
  :ensure t
  :config
  (load-theme 'timu-rouge t))
