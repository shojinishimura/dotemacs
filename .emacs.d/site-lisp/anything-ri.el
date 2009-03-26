;;; anything-ri.el --- show ri manuals with anything

;;; Copyright (c) 2008 Shoji Nishimura

;; Author: Shoji Nishimura <shoji_n@muc.biglobe.ne.jp>

;;; Use and distribution subject to the term of the Ruby license.

;;; Commentary:

;; (0) You need anything.el and FastRI. 
;; (1) You need to add to .emacs:
;;     (require 'anything)
;;     (require 'anything-ri)
;;     ;; Add anything-c-source-ri to anything-sources
;;     (add-to-list 'anything-sources anything-c-source-ri)
;; (2) You need to start fastri-server before using anything-ri

(defvar anything-ri-cmd "fri")
(defvar anything-ri-all-entries-cmd "fri --list-names -T")
(defvar anything-ri-candidates nil)

(defun anything-ri-get-all-entries ()
  (cdr (sort (split-string 
	      (shell-command-to-string anything-ri-all-entries-cmd)
	      "\n")
	     #'string<)))

(defun anything-ri (query)
  (let ((sw (selected-window))
	(buffer (get-buffer-create "*ri*"))
	(command (concat anything-ri-cmd " -T -a " query)))
    (save-excursion
      (set-buffer buffer)
      (erase-buffer)
      (insert (shell-command-to-string command)))
    (pop-to-buffer buffer)
    (select-window sw)))

(defvar anything-c-source-ri
  '((name . "Ruby RI Manual")
    (candidates . (lambda ()
		    (unless anything-ri-candidates
		      (setq anything-ri-candidates
			    (anything-ri-get-all-entries)))
		    anything-ri-candidates))
    (action ("RI" . anything-ri))
    (match . (anything-c-match-on-ruby-method
	      anything-c-match-on-ruby-class/module))
    (delayed)
    (requires-pattern . 3)))

(defun anything-c-match-on-ruby-method (candidate)
  "Return non-nil if `anything-pattern' matches the method name of CANDIDATE."
  (let ((case-fold-search nil))
    (string-match (format "[\.#]%s" anything-pattern) candidate)))

(defun anything-c-match-on-ruby-class/module (candidate)
  "Return non-nil if `anything-pattern' matches the class/module of CANDIDATE."
  (let ((case-fold-search nil))
    (string-match (format "\\(^\\|\\(::\\)\\)%s" anything-pattern) candidate)))

(provide 'anything-ri)