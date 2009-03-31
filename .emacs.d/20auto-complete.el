(require 'auto-complete)
(require 'auto-complete-yasnippet)
(require 'auto-complete-yasnippet)
(require 'auto-complete-emacs-lisp)

(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(setq ac-auto-start 1)
(setq ac-dwim t)
(set-default 'ac-sources 
	     '(ac-source-yasnippet
	       ac-source-abbrev
	       ac-source-words-in-buffer))
(add-to-list 'ac-modes 'scheme-mode)