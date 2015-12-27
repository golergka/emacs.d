;;; Initialize package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(defvar required-packages
  '(evil zenburn-theme slime)
  "A list of packages that should be loaded at launch")
(require 'cl)

(defun packages-installed-p()
  (loop for p in required-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(unless (packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;; Evil mode
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map "M-x" 'execute-extended-command)

;;; Zenburn color theme
(load-theme 'zenburn t)

;;; Slime
(setq slime-lisp-implementations
      '((sbcl ("/usr/local/bin/sbcl") :coding-system utf-8-unix)))
(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
(require 'slime)
(slime-setup '(slime-fancy))
