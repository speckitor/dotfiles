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

(set-face-attribute 'default nil :font "AdwaitaMono-16")

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(ido-mode 1)
(ido-everywhere 1)

(load-file "~/.emacs.local/simpc-mode.el")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

(use-package company
  :bind (("C-." . company-complete))
  :config (global-company-mode))

(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :bind ("M-x" . smex))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-multiedit
  :ensure t
  :config
  (evil-multiedit-default-keybinds))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))
