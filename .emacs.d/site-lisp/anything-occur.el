;;; anything-occur

(defvar anything-c-source-occur
  '((name . "Occur")
    (init . (lambda ()
              (setq anything-occur-current-buffer
                    (current-buffer))))
    (candidates . (lambda ()
                    (let ((anything-occur-buffer (get-buffer-create "*Anything Occur*")))
                      (with-current-buffer anything-occur-buffer
                        (occur-mode)
                        (erase-buffer)
                        (let ((count (occur-engine
				      (migemo-get-pattern anything-pattern)
				      (list anything-occur-current-buffer) anything-occur-buffer
				      list-matching-lines-default-context-lines case-fold-search
				      list-matching-lines-buffer-name-face
				      nil list-matching-lines-face
				      (not (eq occur-excluded-properties t)))))
                          (when (> count 0)
                            (setq next-error-last-buffer anything-occur-buffer)
                            (cdr (split-string (buffer-string) "\n" t))))))))
    (action . (("Goto line" . (lambda (candidate)
                                (with-current-buffer "*Anything Occur*"
                                  (search-forward candidate))
                                (goto-line (string-to-number candidate)
					   anything-occur-current-buffer)))))
    (match . (list '(lambda (c) t)))
    (requires-pattern . 3)
    (volatile)
    (delayed)))

(provide 'anything-occur)