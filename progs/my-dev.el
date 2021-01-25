(my/init-all-packages)
(require 'diff-hl)
(require 'highlight-indent-guides)
(require 'company-capf)
(require 'smartparens)
(require 'js2-mode)
(require 'web-mode)
(require 'tide)
(require 'my-eglot)

(with-eval-after-load 'highlight-indent-guides
	(custom-set-variables
	 '(highlight-indent-guides-method 'bitmap)))

(with-eval-after-load 'ediff
	(setq ediff-window-setup-function 'ediff-setup-windows-plain-merge)
	(setq ediff-split-window-function 'split-window-horizontally))

(defun my/local-prog-mode ()
	"T."
	(setq-local tab-width 2)
	(display-line-numbers-mode)
	(highlight-indent-guides-mode t)
	(diff-hl-mode t)
	(smartparens-mode))

(setq compilation-auto-jump-to-first-error nil)
(setq compilation-ask-about-save nil)
;; Stop on the first error.
(setq compilation-scroll-output 'next-error)
;; Don't stop on info or warnings.
(setq compilation-skip-threshold 2)
(setq eldoc-echo-area-use-multiline-p nil)
(setq eldoc-echo-area-prefer-doc-buffer t)
(setq flycheck-display-errors-function nil)
(add-hook 'prog-mode-hook 'my/local-prog-mode)
(add-hook 'haskell-mode-hook 'eglot-ensure)
(setq company-minimum-prefix-length 1)
(add-to-list 'auto-mode-alist '("\\.julius\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.hamlet\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))

(add-hook 'typescript-mode-hook (lambda ()
																	(tide-setup)
																	(flycheck-mode +1)
																	(setq flycheck-check-syntax-automatically '(save mode-enabled))
																	(eldoc-mode +1)))
(add-hook 'js2-mode-hook 'flymake-jslint-load)

(provide 'my-dev)
