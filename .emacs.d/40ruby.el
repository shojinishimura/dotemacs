;;; Ruby
(require 'ruby-mode)
(require 'ruby-electric)
(require 'inf-ruby)
(require 'rdebug)
(require 'ri-ruby)

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\(?:^\\|/\\)[rR]akefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; additional ruby-electric
(defun ruby-in-literal ()
  (let* ((here (point))
	 (state (save-excursion
		  (ruby-beginning-of-defun)
		  (parse-partial-sexp (point) here))))
    (or (nth 3 state)
	(nth 4 state)
	nil)))

(defun ruby-electric-backspace (arg)
  (interactive "*P")
  (if (or arg (ruby-in-literal))
      (backward-delete-char-untabify (prefix-numeric-value arg))
    (let ((here (point)))
      (skip-chars-backward " \t\n")
      (if (/= (point) here)
	  (delete-region (point) here)
	(backward-delete-char-untabify 1)))))

(defun ruby-electric-delete (arg)
  (interactive "*P")
  (if (or arg (ruby-in-literal))
      (backward-delete-char-untabify (- (prefix-numeric-value arg)))
    (let ((here (point)))
      (skip-chars-backward " \t\n")
      (if (/= (point) here)
	  (delete-region (point) here)
	(backward-delete-char-untabify -1)))))

(defun ruby-electric-forward-char (arg)
  (interactive "p")
  (self-insert-command arg)
  (when (= last-command-char (following-char))
    (delete-char 1)))

(defun ruby-required-p (lib)
  (save-excursion
    (beginning-of-buffer)
    (re-search-forward (concat "require\s+\\(\"\\|\'\\)" lib "\\1") nil t)))

;;; Execution
(defun ruby-eval-buffer ()
  (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (point-min) (point-max) "ruby"))

(defun my-ruby-compilation-mode-hook ()
  (make-variable-buffer-local 'compilation-error-regexp-alist)
  (setq compilation-error-regexp-alist 
        (append compilation-error-regexp-alist 
                (list (list  
                       (concat "\\(.*?\\)\\([0-9A-Za-z_./\:-]+\\.rb\\):\\([0-9]+\\)") 2 3))))
  (make-variable-buffer-local 'compile-command)
  (setq compile-command (concat "ruby -Ks" (buffer-file-name) " "))
  )

(add-hook 'ruby-mode-hook 'my-ruby-compilation-mode-hook)

;;; flymake
(defun flymake-ruby-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("[rR]akefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
		    
;;; Keymap
(add-hook 'ruby-mode-hook 'shoji/ruby-extra-keys)
(defun shoji/ruby-extra-keys ()
  (define-key ruby-mode-map "\C-m" 'newline-and-indent)
  (define-key ruby-mode-map " " 'ruby-electric-space)
  (define-key ruby-mode-map ")" 'ruby-electric-forward-char)
  (define-key ruby-mode-map "}" 'ruby-electric-forward-char)
  (define-key ruby-mode-map "]" 'ruby-electric-forward-char)
  (define-key ruby-mode-map "\t" 'indent-for-tab-command)
  (define-key ruby-mode-map [backspace] 'ruby-electric-backspace)
  (define-key ruby-mode-map "\C-h" 'ruby-electric-backspace)
  ;(define-key ruby-mode-map [delete] 'ruby-electric-delete)
  ;(define-key ruby-mode-map "\C-d" 'ruby-electric-delete)
  (define-key ruby-mode-map "\C-cd" 'flymake-display-err-minibuf)
  (define-key ruby-mode-map [f1] 'ri)
  (define-key ruby-mode-map [f4] 'ri-ruby-show-args)
  (define-key ruby-mode-map "\M-\C-i" 'ri-ruby-complete-symbol)
  (define-key ruby-mode-map [f5] 'compile)
  (define-key ruby-mode-map "\C-cd" 'flymake-display-err-menu-for-current-line)
  )

;;; hook
(defun my-ruby-mode-hook ()
  (inf-ruby-keys)
  (ruby-electric-mode t)
  ;(add-ruby-abbrev 'ruby-mode-abbrev-table)
  (setq ruby-deep-indent-paren-style nil)
  (modify-syntax-entry ?! "w" (syntax-table))
  (modify-syntax-entry ?: "w" (syntax-table))
  (modify-syntax-entry ?? "w" (syntax-table))
  (modify-syntax-entry ?_ "w" (syntax-table))
;  (make-local-variable 'hippie-expand-try-functions-list)
;  (setq hippie-expand-try-functions-list
;	'(
;	  yas/hippie-try-expand
;	  try-complete-abbrev
;	  try-expand-dabbrev
;	  try-expand-dabbrev-all-buffers
;	  try-expand-dabbrev-from-kill))
;  (make-local-variable 'hippie-expand-only-buffers)
;  (setq hippie-expand-only-buffers (list 'ruby-mode))
  (if (not (null buffer-file-name)) (flymake-mode)))

(add-hook 'ruby-mode-hook
	  'my-ruby-mode-hook)

