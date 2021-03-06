;;; anything-dabbrev-expand.el --- dabbrev-expand / dabbrev-completion using anything.el
;; $Id: anything-dabbrev-expand.el,v 1.6 2008/03/21 02:11:28 rubikitch Exp $

;; Copyright (C) 2008  rubikitch

;; Author: rubikitch <rubikitch@ruby-lang.org>
;; Keywords: dabbrev, convenience, anything
;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/anything-dabbrev-expand.el

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Dynamic abbrev for multiple selection using `anything'.
;; This package is tested on Emacs 22.

;;; Installation:

;; Put this file into your load-path, and add following line to .emacs.
;;
;;   (require 'anything-dabbrev-expand)
;;   (global-set-key "\M-/" 'anything-dabbrev-expand)
;;   (define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)

;;; Usage:

;; anything-dabbrev-expand behaves as follows.
;;
;; (1) First, execute `anything-dabbrev-expand'.
;;     And this function behaves as well as normal dabbrev-expand.
;; (2) Next, execute `anything-dabbrev-expand' again.
;;     Then `anything' selection menu appears.
;;     It contains dabbrev candidates in current buffer.
;; (3) After waiting for `anything-dabbrev-idle-delay' seconds in selection menu,
;;     It searches dabbrev candidates from all buffers.
;;
;;     or
;; (3')execute `anything-dabbrev-find-all-buffers' in selection menu.
;;     It searches dabbrev candidates from all buffers.

;;; Note:

;; The main idea of this package is based on dabbrev-expand-multiple.el.
;; dabbrev-expand-multiple.el has Copyright to khiker.

;;; History:

;; $Log: anything-dabbrev-expand.el,v $
;; Revision 1.6  2008/03/21 02:11:28  rubikitch
;; bugfix: avoid colecting candidates from all buffers when anything is exited.
;; New variable: anything-dabbrev-all-min-length
;;
;; Revision 1.5  2008/01/27 15:17:33  rubikitch
;; automatically search dabbrev candidates from all buffers.
;;
;; Revision 1.4  2008/01/14 04:19:31  rubikitch
;; supress compilation warning
;;
;; Revision 1.3  2008/01/14 04:08:45  rubikitch
;; small bugfix
;;
;; Revision 1.2  2008/01/14 04:04:41  rubikitch
;; * added `require'.
;; * revive `target' when quitting `anything'.
;;
;; Revision 1.1  2008/01/13 20:58:57  rubikitch
;; Initial revision
;;

;;; Code:

(require 'dabbrev)
(require 'anything)

(defvar anything-dabbrev-map (copy-keymap anything-map)
  "Keymap for `anything-dabbrev-expand'. It is based on `anything-map'.")
(defvar anything-dabbrev-idle-delay 0.7
  "*The user has to be idle for this many seconds, before
  dabbrev candidates from all buffers are collected.")
(defvar anything-dabbrev-all-min-length 4
  "*Automatically collects candidates from all buffers when input is larger than this value.")
(defvar anything-dabbrev-last-target nil)
(defvar anything-dabbrev-expand-candidate-number-limit anything-candidate-number-limit
  "*Do not show more candidates than this limit from dabbrev candidates.")
(defvar anything-dabbrev-candidates nil)
(defvar anything-dabbrev-all-candidates nil)
(defvar anything-dabbrev-source
  '((name . "dabbrev")
     (candidates . anything-dabbrev-candidates)
     (action . insert)
     (volatile)))
(defvar anything-dabbrev-all-source
  '((name . "dabbrev (all buffer)")
    (init
     . (lambda ()
         (setq anything-dabbrev-all-candidates nil)
         (run-with-idle-timer
          anything-dabbrev-idle-delay nil
          (lambda ()
            (when (and (get-buffer-window anything-buffer)
                       (>= (length anything-dabbrev-last-target) anything-dabbrev-all-min-length))
              (setq anything-dabbrev-all-candidates
                    (anything-dabbrev-get-all-candidates anything-dabbrev-last-target))
              (anything-update))))))
    (candidates . anything-dabbrev-all-candidates)
    (action . insert)
    (volatile)))
(defvar anything-dabbrev-sources
  (list anything-dabbrev-source anything-dabbrev-all-source))

(defun anything-dabbrev-expand ()
  "The command does dynamic abbrev expansion for multiple selection using `anything'.

When you execute this command, it behaves as well as normal
`dabbrev-expand'. It complements only one candidate.

If that candidate is not something that you want, execute this command again.
It displays multiple selection using `anything'. "
  (interactive)
  (dabbrev--reset-global-variables)
  (let ((target (dabbrev--abbrev-at-point)))
    (cond ((eq last-command 'anything-dabbrev-expand)
           (delete-char (- (length target)))
           (condition-case x
               (anything-dabbrev-expand-main anything-dabbrev-last-target)
             (quit (insert anything-dabbrev-last-target))))
          (t
           (let ((abbrev (dabbrev--find-expansion target 0 dabbrev-case-fold-search)))
             (cond
              (abbrev
               (insert (substring abbrev (length target)))
               (setq anything-dabbrev-last-target target))
              (t
               (message "No dynamic expansion for `%s' found" target))))))))

(defun anything-dabbrev-get-candidates (abbrev &optional all)
  (let ((dabbrev-check-other-buffers all))
    (dabbrev--reset-global-variables)
    (dabbrev--find-all-expansions abbrev nil)))

(defun* anything-dabbrev-get-all-candidates (&optional (abbrev anything-dabbrev-last-target))
  (anything-dabbrev-get-candidates abbrev t))

(defun anything-dabbrev-expand-main (abbrev)
  "Execute `anything' for dabbrev candidates in current buffer."
  (let ((anything-candidate-number-limit anything-dabbrev-expand-candidate-number-limit)
        (anything-idle-delay anything-dabbrev-idle-delay)
        (anything-sources anything-dabbrev-sources))
    (setq anything-dabbrev-candidates (anything-dabbrev-get-candidates abbrev))
    (let ((anything-map anything-dabbrev-map))
      (anything))))

(defun anything-dabbrev-find-all-buffers (&rest ignore)
  "Display dabbrev candidates in all buffers."
  (interactive)
  (setq anything-dabbrev-candidates
        (anything-dabbrev-get-all-candidates anything-dabbrev-last-target))
  (anything-update))

(provide 'anything-dabbrev-expand)

;; How to save (DO NOT REMOVE!!)
;; (emacswiki-post "anything-dabbrev-expand.el")
;;; anything-dabbrev-expand.el ends here
