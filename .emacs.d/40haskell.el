;;; 
(load "~/.emacs.d/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'auto-complete-mode)

(add-hook 'haskell-mode-hook
	  '(lambda ()
	     (progn
	       (define-key haskell-mode-map "{" 'insert-braces)
	       (define-key haskell-mode-map "}" 'fake-insert-char)
	       (define-key haskell-mode-map "(" 'insert-parens)
	       (define-key haskell-mode-map ")" 'fake-insert-char)
	       (define-key haskell-mode-map "[" 'insert-brackets)
	       (define-key haskell-mode-map "]" 'fake-insert-char)
	       (define-key haskell-mode-map "\"" 'insert-double-quotation)
	       )))

;======================================================================
; flymake-mode for haskell
;======================================================================
;http://d.hatena.ne.jp/jeneshicc/20090630/1246364354
(require 'flymake)

(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "ghc"
    	(list "--make" "-fbyte-code"
    	      (concat "-i"base-dir)
    	      source)))

(defvar multiline-flymake-mode nil)
(defvar flymake-split-output-multiline nil)

(defadvice flymake-split-output
  (around flymake-split-output-multiline activate protect)
  (if multiline-flymake-mode
      (let ((flymake-split-output-multiline t))
	ad-do-it)
    ad-do-it))

(defadvice flymake-split-string
  (before flymake-split-string-multiline activate)
  (when flymake-split-output-multiline
    (ad-set-arg 1 "^\\s *$")))

(add-hook
 'haskell-mode-hook
 '(lambda ()
    (add-to-list 'flymake-allowed-file-name-masks
		 '("\\.l?hs$" flymake-Haskell-init flymake-simple-java-cleanup))
    (add-to-list 'flymake-err-line-patterns
     		 '("^\\(.+\\.l?hs\\):\\([0-9]+\\):\\([0-9]+\\):\\(\\(?:.\\|\\W\\)+\\)"
     		   1 2 3 4))
    (set (make-local-variable 'multiline-flymake-mode) t)
    (if (not (null buffer-file-name)) (flymake-mode))
    ))

;; Display messages at the minibuffer
(global-set-key "\C-cd"
                'flymake-show-and-sit )

(defun flymake-show-and-sit ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (progn
    (let* ( (line-no             (flymake-current-line-no) )
	    (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
	    (count               (length line-err-info-list))
	    )
      (while (> count 0)
	(when line-err-info-list
	  (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
		 (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
		 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
		 (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
	    (message "[%s] %s" line text)
	    )
	  )
	(setq count (1- count)))))
  (sit-for 60.0)
  )