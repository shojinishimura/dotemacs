;;; anything-dummy

(defun anything-c-define-dummy-source (name func &rest other-attrib)
  `((name . ,name)
    (candidates "dummy")
    ,@other-attrib
    (filtered-candidate-transformer
     . (lambda (candidates source)
         (funcall ',func)))
    (requires-pattern . 1)
    (volatile)
    (category create)))

(defun anything-c-dummy-candidate ()
  ;; `source' is defined in filtered-candidate-transformer
  (list (cons (concat (assoc-default 'name source) 
                      " '" anything-input "'")
              anything-input)))

(defvar anything-c-source-buffer-not-found
  (anything-c-define-dummy-source
   "Create buffer"
   (lambda () (unless (get-buffer anything-input)
                (anything-c-dummy-candidate)))
   '(type . buffer)))

(defvar anything-c-source-M-x
  (anything-c-define-dummy-source
   "M-x"
   #'anything-c-dummy-candidate
   '(type . command)))

(provide 'anything-dummy)