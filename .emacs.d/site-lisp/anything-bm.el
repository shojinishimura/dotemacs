;;; anything-bm
(require 'bm)

(defvar anything-c-source-bm
  '((name . "Visible Bookmarks")
    (init . (lambda ()
              (let ((bookmarks (bm-lists)))
                (setq anything-bm-marks
                      (delq nil
                            (mapcar (lambda (bm)
                                      (let ((start (overlay-start bm))
                                            (end (overlay-end bm)))
                                        (if (< (- end start) 2)
                                            nil
                                          (format "%7d: %s"
                                                  (line-number-at-pos start)
                                                  (buffer-substring start (1- end))))))
                                    (append (car bookmarks) (cdr bookmarks))))))))
    (candidates . (lambda ()
                    anything-bm-marks))
    (action . (("Goto line" . (lambda (candidate)
                                (goto-line (string-to-number candidate))))))))

(provide 'anything-bm)