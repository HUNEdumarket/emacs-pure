(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("c:/ProgramData/Git/usr/bin" "c:/ProgramData/chocolatey/bin" "c:/ProgramData/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(defvar my/base-dir "c:/Projects")
(defvar my/dark-theme-hook '())
(defvar my/light-theme-hook '())
(defvar my/cursor-color "red")
(defvar my/cursor-type 'box)

(defun my/theme () (my/light-theme))

;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"

	(require 'my-haskell)
	(require 'my-web)
	(require 'my-csharp)
	(require 'my-dev)

	(eval-after-load 'org-mode
		(setq org-todo-keywords
					'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "FAILED"))
					org-support-shift-select t
					org-log-done t))

	(add-hook 'my/dark-theme-hook (lambda ()
																	(load-theme 'wombat)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'wombat)))
	(add-to-list 'default-frame-alist '(height . 45))
  (add-to-list 'default-frame-alist '(width . 140))
	(set-frame-size (selected-frame) 140 45))

(setq browse-url-generic-program "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe")

(provide 'my-const)
