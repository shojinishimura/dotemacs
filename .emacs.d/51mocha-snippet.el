;;; yasnippets for mocha
;;;
;;; Shoji Nishimura
;;; 2008/06/29

(defun ruby-mocha-mode-p ()
  false)

(yas/define-snippets
 'ruby-mode
 '(
   ("expects" "expects(${:method})" "expects(:method) - mocha" (ruby-mocha-mode-p))
   ("with" "with(${args})" "with(arg1, arg2, ...) - mocha" (ruby-mocha-mode-p))
   ("returns" "returns(${value})" "returns(value) - mocha" (ruby-mocha-mode-p))
   ("stubs" "stubs(${:method})" "stubs(:method) - mocha" (ruby-mocha-mode-p))
   ("stub" "stub(${:method} => ${value}${, ...})" "stub(:method => value, ...) - mocha" (ruby-mocha-mode-p))
   )
 'text-mode)
