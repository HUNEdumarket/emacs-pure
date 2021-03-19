(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-unset-key (kbd "C-c d"))
(global-set-key (kbd "C-c d") 'duplicate-line)
(global-set-key (kbd "C-c n") 'move-line-down)
(global-set-key (kbd "C-c p") 'move-line-up)
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(global-set-key (kbd "C-c l") 'recenter)
(global-set-key (kbd "<S-return>") 'crux-smart-open-line)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "C-`") 'window-toggle-side-windows)
(global-unset-key (kbd "C-s"))
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-M-o") 'find-file-literally-at-point)
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-c i") 'indent-buffer)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "<M-return>") 'find-file-at-point)
(global-set-key (kbd "C-l") 'my/menu-base)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-b") 'switch-to-buffer)
(global-set-key (kbd "C-S-k") 'my/kill-buffer-close-window)
(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "C-S-o") 'project-find-file)
(global-set-key (kbd "M-;") 'my/comment-uncomment-line)
(global-set-key (kbd "C-S-v") 'my/xah-select-line)
(global-set-key (kbd "C-,") 'consult-global-mark)
(add-hook 'magit-status-mode-hook (lambda ()
																		(define-key magit-status-mode-map (kbd "<C-tab>") 'other-window)
																		(define-key magit-log-mode-map (kbd "<C-tab>") 'other-window)
																		(define-key magit-revision-mode-map (kbd "<C-tab>") 'other-window)
																		(define-key magit-stash-mode-map (kbd "<C-tab>") 'other-window)
																		(define-key magit-diff-mode-map (kbd "<C-tab>") 'other-window)))

(provide 'my-keys)
