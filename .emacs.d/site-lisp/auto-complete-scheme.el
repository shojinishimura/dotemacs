;; auto-complete configrations for scheme-mode
(require 'auto-complete)

(defvar r5rs-keywords
  '("abs" "acos" "and" "angle"
    "append" "apply" "asin" "assoc"
    "assq" "assv" "atan" "begin"
    "boolean?" "caar" "cadr" "call-with-current-continuation"
    "call-with-input-file" "call-with-output-file" "call-with-values" "car"
    "case" "cdddar" "cddddr" "cdr"
    "ceiling" "char->integer" "char-alphabetic?" "char-ci<=?"
    "char-ci<?" "char-ci=?" "char-ci>=?" "char-ci>?"
    "char-downcase" "char-lower-case?" "char-numeric?" "char-ready?"
    "char-upcase" "char-upper-case?" "char-whitespace?" "char<=?"
    "char<?" "char=?" "char>=?" "char>?"
    "char?" "close-input-port" "close-output-port" "complex?"
    "cond" "cons" "cos" "current-input-port"
    "current-output-port" "delay" "denominator" "display"
    "dynamic-wind" "eof-object?" "eq?" "equal?"
    "eqv?" "eval" "even?" "exact->inexact"
    "exact?" "exp" "expt" "floor"
    "for-each" "force" "gcd" "if"
    "imag-part" "inexact->exact" "inexact?" "input-port?"
    "integer->char" "integer?" "interaction-environment" "lambda"
    "lcm" "length" "let" "let*"
    "let-syntax" "letrec" "letrec-syntax" "list"
    "list->string" "list->vector" "list-ref" "list-tail"
    "list?" "load" "log" "magnitude"
    "make-polar" "make-rectangular" "make-string" "make-vector"
    "map" "max" "member" "memq"
    "memv" "min" "modulo" "negative?"
    "newline" "not" "null-environment" "null?"
    "number->string" "number?" "numerator" "odd?"
    "open-input-file" "open-output-file" "or" "output-port?"
    "pair?" "peek-char" "positive?" "procedure?"
    "quasiquote" "quote" "quotient" "rational?"
    "rationalize" "read" "read-char" "real-part"
    "real?" "remainder" "reverse" "round"
    "scheme-report-environment" "set!" "set-car!" "set-cdr!"
    "sin" "sqrt" "string" "string->list"
    "string->number" "string->symbol" "string-append" "string-ci<=?"
    "string-ci<?" "string-ci=?" "string-ci>=?" "string-ci>?"
    "string-copy" "string-fill!" "string-length" "string-ref"
    "string-set!" "string<=?" "string<?" "string=?"
    "string>=?" "string>?" "string?" "substring"
    "symbol->string" "symbol?" "syntax-rules" "tan"
    "template" "transcript-off" "transcript-on" "truncate"
    "values" "vector" "vector->list" "vector-fill!"
    "vector-length" "vector-ref" "vector-set!" "vector?"
    "with-input-from-file" "with-output-to-file" "write" "write-char"
    "zero?"))
(defvar ac-source-r5rs
  '((candidates . (lambda () (all-completions ac-target r5rs-keywords)))))

(defvar ac-source-gauche-file-symbols
  '((candidates
     . (lambda () 
	 (all-completions ac-target ac-source-gauche-file-symbols-cache)
	 ))))

(defvar ac-source-gauche-file-symbols-cache nil)
(defun ac-source-gauche-collect-file-symbols ()
  (interactive)
  (if (not (eq 0 (shell-command "gosh -b" nil)))
      nil
    (setq ac-source-gauche-file-symbols-cache
	  (delete "" (split-string (shell-command-to-string
				  (format "gosh -b -e'(letrec ((car-of-car (lambda (x) (if (pair? x) (car-of-car (car x)) x)))) (with-input-from-file \"%s\" (lambda () (let loop((sexp (read))) (if (eof-object? sexp) #f (begin (cond ((not (pair? sexp)) #f) ((or (eq? (quote define) (car sexp)) (eq? (quote define-syntax) (car sexp)) (eq? (quote define-macro) (car sexp)) (eq? (quote define-class) (car sexp))) (print (car-of-car (cadr sexp))))) (loop (read))))))))'" (buffer-file-name))) "\n")))))

(defun ac-imenu-scheme-candidate ()
  (mapcar (lambda (x)
	    (or (and (string-match "()$" x) (substring x 0 -2))
		x))
	  (ac-imenu-candidate)))

(defvar ac-source-scheme-symbols
  '((init . (lambda ()
	      (require 'imenu)
	      (setq ac-imenu-index
		    (ignore-errors (imenu--make-index-alist)))))
    (candidates . ac-imenu-scheme-candidate))
  "Source for scheme symbols.")



(add-hook 'scheme-mode-hook
	  '(lambda ()
	     (make-local-variable 'ac-sources)
	     (make-local-variable 'ac-source-gauche-file-symbols-cache)
	     (make-local-variable 'after-save-hook)
	     (setq ac-sources '(ac-source-scheme-symbols ac-source-r5rs ac-source-words-in-buffer))
;	     (add-to-list 'ac-sources 'ac-source-r5rs)
;	     (add-to-list 'ac-sources 'ac-source-gauche-file-symbols)
;	     (add-hook 'after-save-hook
;		       'ac-source-gauche-collect-file-symbols)
;	     (ac-source-gauche-collect-file-symbols)
	     ))


(provide 'auto-complete-scheme)