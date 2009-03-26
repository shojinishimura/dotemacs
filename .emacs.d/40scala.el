;;;
(require 'scala-mode-auto)

(add-hook 'scala-mode-hook
	  '(lambda ()
;	     (define-key scala-mode-map "\t" 'scala-indent-line)
	     (scala-electric-mode)
	     (custom-set-variables
	      '(scala-interpreter "scala")
	      )
	     (yas/minor-mode-on)))