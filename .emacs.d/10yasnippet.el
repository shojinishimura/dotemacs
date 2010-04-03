;;; YASnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (expand-file-name "~/.emacs.d/snippets"))

(setq yas/trigger-key (kbd "SPC"))
(setq yas/next-field-key (kbd "TAB"))
(define-key yas/keymap "\C-g" 'undo)
(define-key yas/keymap [tab] 'yas/next-field-group)

(setq yas/text-popup-function #'yas/dropdown-list-popup-for-template)
(setq yas/buffer-local-condition
      '(or (not (or (string= "font-lock-comment-face"
                             (get-char-property (point) 'face))
                    (string= "font-lock-string-face"
                             (get-char-property (point) 'face))))
           '(require-snippet-condition . force-in-comment)))

(defvar flymake-is-active-flag nil)

(setq yas/expand-prev-status nil)
(defadvice yas/expand (around yas/expand-suppress-when-canceled activate)
  "suppress yas/expand invocation after canceled."
  (if (eq yas/expand-prev-status 'interrupted)
      (progn (insert yas/trigger-key) (setq yas/expand-prev-status nil))
    (progn (setq yas/expand-prev-status ad-do-it)
	   (message yas/expand-prev-status))))

(defadvice yas/undo-expand-snippet
  (after yas/undo-expand-snippet-mark-status activate)
  "mark status when yas/undo-expand-snippet is called."
  (setq yas/expand-prev-status 'interrupted))

(defun yas/indent-snippet ()
  (indent-region yas/snippet-beg yas/snippet-end)
  (indent-according-to-mode))
(add-hook 'yas/after-exit-snippet-hook 'yas/indent-snippet)

(defadvice yas/expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
        (or flymake-is-active-flag
            (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))

(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (when flymake-is-active-flag
               (flymake-mode-on)
               (setq flymake-is-active-flag nil))))

(add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)

;;; experimental code
(defun yas/keys-at-current-position ()
  (let ((start (point))
        (end (point))
        (syntaxes yas/key-syntaxes)
        syntax keys)
    (while syntaxes
      (setq syntax (car syntaxes))
      (setq syntaxes (cdr syntaxes))
      (save-excursion
        (skip-syntax-backward syntax)
        (setq start (point)))
      (let ((key (buffer-substring-no-properties start end)))
        (when (not (or (string= key "") (assoc key keys)))
          (setq keys (cons (list key start end) keys))))
      (setq start end))
    (reverse keys)))

(defun yas/current-snippet-keys (table)
  (if (null table)
      '()
    (let ((keys '()))
      (maphash #'(lambda (key v)
                   (let ((templates (yas/filter-templates-by-condition v)))
                     (when templates
                       (setq keys (cons (list key templates) keys)))))
               (yas/snippet-table-hash table))
      (append keys (yas/snippet-table-parent table)))))

(defun yas/super-expand ()
  "Extended version of yas/expand."
  (interactive)
  (let ((local-condition (yas/template-condition-predicate
                          yas/buffer-local-condition)))
    (if local-condition
        (let ((yas/require-template-condition
               (if (and (consp local-condition)
                        (eq 'require-snippet-condition (car local-condition))
                        (symbolp (cdr local-condition)))
                   (cdr local-condition)
                 nil)))
          ;...
          ))))