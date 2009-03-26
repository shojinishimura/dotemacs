;;; yasnippets for shoulda
;;;
;;; Shoji Nishimura (shoji_n@muc.biglobe.ne.jp)
;;; 2008/06/24

(defun ruby-shoulda-mode-p ()
  false)

(yas/define-snippets
 'ruby-mode
 '(
   ("context" "context \"${context}\" do\n  $0\nend" "context - shoulda" (ruby-shoulda-mode-p))
   ("should" "should \"${message}\" do\n  $0\nend" "should - sholda" (ruby-shoulda-mode-p))
   ("setup" "setup do\n  $0\nend" "setup - shoulda" (ruby-shoulda-mode-p))))
