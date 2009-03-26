;;; mmm-mode
(require 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)

;(set-face-bold-p 'mmm-default-submode-face t)
;(set-face-background 'mmm-default-submode-face "DarkSeaGreen")
(set-face-background 'mmm-default-submode-face nil)

(mmm-add-classes
 '((erb-code
    :submode ruby-mode
    :front "<%[#=]?"
    :back "%>")))

(add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))
;(add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil eruby))

(add-hook 'html-mode-hook
	  (lambda ()
	    (setq mmm-classes '(erb-code))
	    (mmm-mode-on)))