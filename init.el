;; -*- lexical-binding: t -*-

;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; ;; and `package-pinned-packages`. Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (package-initialize)

;; (message "%s" file-name-handler-alist)
;; (setq debug-on-error t)

(defalias 'yes-or-no-p 'y-or-n-p)

(let ((my-load-file
       (expand-file-name (concat user-emacs-directory "progs"))))
  (add-to-list 'load-path my-load-file))

;; the ide mode enabled or not
(defvar my/dev-env nil)
;; the ide mode hook
(defvar my/dev-hook '())

(require 'my-const)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-check-for-modifications nil)

(setq completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

(load (expand-file-name (concat user-emacs-directory "custom.el")))
(require 'my-defun)
(require 'my-keys)
;; (require 'my-layout)

(straight-use-package 'diminish)
(straight-use-package 'selectrum)
(straight-use-package 'prescient)
(straight-use-package 'selectrum-prescient)
(straight-use-package 'marginalia)
(straight-use-package 'mini-frame)
(straight-use-package 'consult)
(straight-use-package 'rg)
(straight-use-package 'undo-tree)
(straight-use-package 'anzu)
(straight-use-package 'markdown-mode)
(straight-use-package 'transpose-frame)
(straight-use-package 'git-timemachine)
(straight-use-package 'dired-single)
(straight-use-package 'which-key)
(straight-use-package 'visual-regexp)

(selectrum-mode +1)
(selectrum-prescient-mode +1)
(prescient-persist-mode +1)
(marginalia-mode +1)
(mini-frame-mode +1)
(global-undo-tree-mode +1)
(diminish 'undo-tree-mode)
(diminish 'anzu-mode)
(global-anzu-mode +1)
(show-paren-mode +1)
(cua-mode +1)
(which-key-mode +1)
(diminish 'which-key-mode)

(eldoc-mode -1)
;; set defaults
(setq-default
 dired-dwim-target t
 ;; doom-modeline-height 25
 autoload-compute-prefixes nil
 frame-inhibit-implied-resize t
 initial-major-mode 'fundamental-mode
 find-file-visit-truename nil
 ffap-machine-p-known 'accept     ; don't ping things that look like domain names
 idle-update-delay 1              ; update ui slightly less often
 ;; History & backup settings (save nothing, that's what git is for)
 auto-save-default nil
 create-lockfiles nil
 history-length 500
 make-backup-files nil  ; don't create backup~ files
 package-check-signature nil
 custom-file (concat user-emacs-directory "custom.el")
 inhibit-startup-screen t
 tab-width 2
 split-height-threshold 0
 split-width-threshold nil
 bidi-paragraph-direction 'left-to-right
 bidi-display-reordering nil
 gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"
 browse-url-browser-function 'browse-url-generic
 set-mark-command-repeat-pop t
 resize-mini-windows t
 completions-format 'vertical
 isearch-allow-scroll t
 scroll-preserve-screen-position t
 isearch-allow-prefix t
 linum-format "%3s"
 mark-ring-max 32)

;; dired
(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
   loaded."
  ;; <add other stuff here>
  (define-key dired-mode-map [remap dired-find-file]
    'dired-single-buffer)
  (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
    'dired-single-buffer-mouse)
  (define-key dired-mode-map [remap dired-up-directory]
    'dired-single-up-directory))

;; if dired's already loaded, then the keymap will be bound
(if (boundp 'dired-mode-map)
    ;; we're good to go; just add our bindings
    (my-dired-init)
  ;; it's not loaded yet, so add our bindings to the load-hook
  (add-hook 'dired-load-hook 'my-dired-init))

;; Better scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(set-window-scroll-bars (minibuffer-window) nil nil)

;; do not split window
(setq split-width-threshold (- (window-width) 10))
(setq split-height-threshold nil)

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer

(add-hook 'nxml-mode-hook 'my/long-line)
(add-hook 'json-mode-hook 'my/long-line)
(add-to-list 'auto-mode-alist '("\\.log.*\\'" . auto-revert-mode))
(put 'list-timers 'disabled nil)


;; add exec-path
(mapcar (lambda (cdir)
					(add-to-list 'exec-path cdir)) my/exec-dir)
(mapcar (lambda (cdir)
					(setenv (concat cdir ";" (getenv "PATH")))) my/exec-dir)

(setq find-ls-option '("-exec ls -ldh {} +" . "-ldh"))
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(winner-mode +1)
(with-eval-after-load 'ediff
	;; add ediff configuration
	(setq ediff-split-window-function 'split-window-horizontally)
	(setq ediff-merge-split-window-function 'split-window-vertically)
	(setq ediff-diff-options "-w")
	(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
	(setq ediff-window-setup-function #'ediff-setup-windows-plain))

(add-hook 'so-long-mode-hook (lambda ()
															 (require 'longlines)
															 (longlines-mode)))

(cd my/base-dir)

(blink-cursor-mode 0)
(set-cursor-color my/cursor-color)
(setq-default cursor-type my/cursor-type)

(my/end-of-init)

