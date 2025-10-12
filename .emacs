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

(setq c-default-style
      '((c-mode . "linux")))

(defun my-c-mode-hook ()
  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil))
(add-hook 'c-mode-hook 'my-c-mode-hook)

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))

(use-package tree-sitter)

(use-package tree-sitter-langs)

(require 'tree-sitter)
(require 'tree-sitter-langs)

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package projectile)

(use-package lsp-mode)
(use-package lsp-ui
  :custom
  (lsp-ui-doc-position 'at-point))

(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'python-mode-hook 'lsp)

(setq lsp-enable-symbol-highlighting nil)
(setq lsp-headerline-breadcrumb-enable nil)

(use-package company
  :bind
  (("C-n" . company-complete))
  :config (global-company-mode))

(use-package smex
  :init
  (smex-initialize)
  :bind ("M-x" . smex))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-multiedit
  :config
  (evil-multiedit-default-keybinds))

(use-package magit
  :bind ("C-x g" . magit-status))

(with-eval-after-load 'lsp-ui
  (evil-define-key 'normal lsp-mode-map
                   (kbd "K") #'lsp-ui-doc-glance))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-y") #'company-complete-selection)
  (define-key company-active-map (kbd "RET") nil))
