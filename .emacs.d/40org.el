;;; org, remember
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

(defun gtd()
  (interactive)
  (find-file "~/org/gtd.org"))
(global-set-key "\C-cg" 'gtd)

(setq org-return-follows-link t)
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

(require 'remember)
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(defun notes()
  (interactive)
  (find-file "~/org/notes.org"))

(define-key global-map "\C-cr" 'org-remember)
(define-key global-map "\C-cm" 'notes)

(custom-set-variables
 '(org-agenda-files '("~/org/gtd.org"))
 '(org-agenda-ndays 7)
 '(org-agenda-repeating-timestamp-show-all nil)
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-sorting-strategy '((agenda time-up priority-down tag-up) (todo tag-up)))
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-todo-ignore-deadlines t)
 '(org-agenda-todo-ignore-scheduled t)
 '(org-agenda-todo-ignore-with-date t)
 '(org-agenda-window-setup (quote other-window))
 '(org-agenda-start-with-follow-mode t)
 '(org-deadline-warning-days 7)
 '(org-export-html-style "<link rel=\"stylesheet\" type=\"text/css\" href=\"mystyles.css\">")
 '(org-fast-tag-selection-single-key nil)
 '(org-enforce-todo-dependencies nil)
 '(org-enforce-todo-checkbox-dependencies nil)
 '(org-log-state-notes-into-drawer t)
 '(org-refile-targets '(("gtd.org" :maxlevel . 1)))
 '(org-reverse-note-order t)
 '(org-tags-column -78)
 '(org-directory "~/org/")
 '(org-default-notes-file "~/org/notes.org")
 '(org-remember-templates
   '(("Todo" ?t "%[~/.emacs.d/templates/org-todo.txt]" "~/org/gtd.org" "Inbox")
     ("Memo" ?m "* %^{Title} %U %^g\n%?" "~/org/notes.org" 'top)
     ("Clipboard" ?c "* %^{Title} %U %^g\n%c\n%?" "~/org/notes.org" 'top)
     ("Appt" ?a "%[~/.emacs.d/templates/org-appt.txt]" "~/org/gtd.org" "Calendar")
     ("Borrow" ?b "%[~/.emacs.d/templates/org-borrow.txt]" "~/org/gtd.org" "Borrowed")
     ("Lend" ?l "%[~/.emacs.d/templates/org-lend.txt]" "~/org/gtd.org" "Lending")
     ))
 '(org-agenda-custom-commands
   '(("d" "Daily Action List"
      ((agenda "" ((org-agenda-ndays 1)
		   (org-agenda-sorting-strategy
		    '((agenda time-up priority-down tag-up)))
		   (org-deadline-warning-days 0)))))
     ("c" "DONE List" ((todo "DONE|DEFERRED|CANCELLED" nil)))
     ))
)

(defun my-org-blocker-hook(prop)
  (let ((to-state (cadr (member :to prop))))
    (if (member to-state '("CANCELLED" "DEFERRED"))
	t
      (and
       (org-block-todo-from-children-or-siblings prop)
       (org-block-todo-from-checkboxes prop))
      )))

(add-hook 'org-blocker-hook 'my-org-blocker-hook)


  