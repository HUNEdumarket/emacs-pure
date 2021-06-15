(with-eval-after-load 'magit
  (define-key magit-hunk-section-map [mouse-1] 'magit-diff-visit-file)
  (define-key magit-file-section-map [mouse-1] 'magit-diff-visit-file)
  (define-key magit-commit-section-map [mouse-1] 'magit-diff-show-or-scroll-up)
  (define-key magit-revision-mode-map (kbd "<C-tab>") 'other-window)
  (define-key magit-status-mode-map (kbd "<C-tab>") 'other-window)
  (define-key magit-log-mode-map (kbd "<C-tab>") 'other-window)

  (define-key magit-hunk-section-map (kbd "SPC") nil)
  (define-key magit-file-section-map (kbd "SPC") nil)
  (define-key magit-commit-section-map (kbd "SPC") nil)
  (define-key magit-revision-mode-map (kbd "SPC") nil)
  (define-key magit-status-mode-map (kbd "SPC") nil)
  (define-key magit-process-mode-map (kbd "SPC") nil)
  (define-key magit-blame-mode-map (kbd "SPC") nil)

  (define-key magit-log-mode-map (kbd "<C-tab>") 'other-window)
  (define-key magit-revision-mode-map (kbd "C-c C-c") 'magit-section-cycle-global)
  (define-key magit-status-mode-map (kbd "C-c C-c") 'magit-section-cycle-global)
  (define-key magit-log-mode-map (kbd "C-c C-c") 'magit-section-cycle-global))

(defun my/magit-status ()
  "Open a magit directory."
  (interactive)
  (my/load-my "projectile")
  (projectile-mode 1)
  (if (projectile-project-p)
      (let ((project-root (projectile-project-root)))
				(message "proj-root: %s" project-root)
				(magit-status project-root)
				(delete-other-windows))
    (let ((current-prefix-arg '(4)))
      (call-interactively #'magit-status)
      (delete-other-windows))))

(straight-use-package 'magit)
(setq magit-auto-revert-mode nil)
(setq magit-log-margin '(t age-abbreviated magit-log-margin-width :author 11))
(setq magit--default-directory my/project-dir)  
(setq magit-section-initial-visibility-alist (quote ((untracked . hide) (stashes . hide))))

;; (my/installed "magit")
(provide 'my-magit)
