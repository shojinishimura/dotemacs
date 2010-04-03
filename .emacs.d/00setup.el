;;; Minor mode
(display-time)
(column-number-mode t)
(show-paren-mode t)

;; Subversion
(require 'vc-svn)

;; Interactive do
(require 'ido)
(ido-mode t)

;; recentf
(require 'recentf)
(recentf-mode 1)

;; dabbrev
(require 'dabbrev)

;; migemo
;(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary 
      (concat (getenv "EMACSDIR") "/packages/etc/migemo/migemo-dict"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'japanese-shift-jis-unix)

;; color-moccur
(require 'color-moccur)
(setq moccur-split-word t)
(setq moccur-use-migemo t)
(setq color-moccur-default-ime-status nil)
(setq *moccur-buffer-name-exclusion-list*
      '("\\*.+\\*"))

(require 'moccur-edit)

(require 'cygwin-mount)
;; bm
(require 'bm)
(global-set-key [?\C-\M- ] 'bm-toggle)

;; compile
(require 'compile)
(add-hook 'compilation-mode-hook
	  '(lambda ()
	     (setq default-process-coding-system '(sjis-dos . sjis-dos))))

; treat ImageMagick path
(when (featurep 'meadow)
  (defun my-compilation-mode-hook ()
    (let* ((path (getenv "PATH"))
	   (newpath
	    (replace-regexp-in-string 
	     "^C:\\\\Program Files\\\\imagemagick-6.2.8-q16;" 
	     ""
	     path)))
      (setenv "PATH" newpath)))
  (add-hook 'compilation-mode-hook 'my-compilation-mode-hook))

;; flymake
(require 'flymake)
(defun flymake-display-err-minibuf () 
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no (flymake-current-line-no))
         (line-err-info-list
	  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file
		(flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count)))))

;; brackets
(require 'brackets)

;;; Indent
(defun indent-current-buffer ()
  (interactive)
  (indent-region (point-min) (point-max))
  (message "indent buffer"))
(global-set-key "\C-c\C-i" 'indent-current-buffer)

(global-set-key "\t" 'indent-for-tab-command)

;;; yaml
(add-to-list 'auto-mode-alist '("\\.yaml" . yaml-mode))

;;; keymap
(define-key global-map "\C-xg" 'goto-line)