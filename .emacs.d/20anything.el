;;; anything
(require 'anything-config)
(require 'anything)

(require 'anything-migemo)
(require 'anything-match-plugin)
(require 'anything-complete)

(require 'anything-ri)
(require 'anything-dummy)

(require 'anything-occur)
(require 'anything-c-moccur)
(require 'anything-imenu)
(require 'anything-bm)

(require 'anything-gtags)
(require 'anything-etags)
(require 'anything-c-yasnippet)
;(require 'anything-dabbrev-expand)

(global-set-key "\C-xb" 'anything-switch)
(global-set-key "\C-x\C-b" 'anything-switch)
(define-key global-map [(control ?\;)] 'anything-switch)
(define-key global-map [(control ?\:)] 'anything-search)
(define-key global-map [(control ?\@)] 'anything-resume)
(define-key global-map "\M-/" 'anything-insert)
(define-key anything-map "\C-f" 'anything-next-source)
(define-key anything-map "\C-b" 'anything-previous-source)
(define-key anything-map (kbd "C-M-p") 'anything-previous-page)
(define-key anything-map (kbd "C-M-n") 'anything-next-page)
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)

(require 'color-moccur)
(setq moccur-split-word t)
;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) 
  (setq moccur-use-migemo t))

;;; anything-c-moccurの設定
(require 'anything-c-moccur)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))


(defvar locate-home-database "/var/home.locatedb")
(defvar anything-c-source-locate-home
  '((name . "Locate")
    (candidates . (lambda ()
                    (start-process "locate-process" nil
                                   "locate" "-d" locate-home-database "-i" "-r" "--"
                                   anything-pattern)))
    (type . file)
    (requires-pattern . 3)
    (delayed))
  "Source for retrieving files in home directory matching the current input pattern
with locate.")

(setq anything-c-yas-space-match-any-greedy t)
(setq anything-c-yas-display-key-on-candidate t)

(defun anything-dabbrev-get-candidates (abbrev &optional all)
  (let ((dabbrev-check-other-buffers all))
    (dabbrev--reset-global-variables)
    (dabbrev--find-all-expansions abbrev nil)))

(defun anything-dabbrev-insert (c init-target)
  (delete-char (- (length init-target)))
  (insert c))

(defvar anything-c-source-dabbrev-buffer
  '((name . "dabbrev (current buffer)")
    (init . (lambda ()
              (dabbrev--reset-global-variables)
              (setq dabbrev-init-target  (dabbrev--abbrev-at-point))
              (setq anything-c-source-dabbrev-candidates
                    (anything-dabbrev-get-candidates dabbrev-init-target))))
    (candidates . anything-c-source-dabbrev-candidates)
    (action . (lambda (c)
                (anything-dabbrev-insert c dabbrev-init-target)))
    (volatile)))

(defvar anything-c-source-dabbrev-all-buffers
  '((name . "dabbrev (all buffers)")
    (init . (lambda ()
              (dabbrev--reset-global-variables)
              (setq dabbrev-init-target-all (dabbrev--abbrev-at-point))
              (setq anything-c-source-dabbrev-all-candidates
                    (anything-dabbrev-get-candidates dabbrev-init-target-all t))))
    (candidates . anything-c-source-dabbrev-all-candidates)
    (action . (lambda (c)
                (anything-dabbrev-insert c dabbrev-init-target-all)))
    (volatile)))

(defun anything-lisp-symbol-begin ()
  (save-excursion
    (skip-syntax-backward "w_")
    (point)))

(defvar anything-c-source-lisp-symbol
  '((name . "Lisp symbols")
    (init . (lambda ()
              (setq anything-lisp-init-target
                    (buffer-substring-no-properties
                     (anything-lisp-symbol-begin) (point)))
              (setq anything-c-source-lisp-symbol-candidates
                    (sort (all-completions anything-lisp-init-target obarray
                                           #'(lambda (sym)
                                               (or (boundp sym)
                                                   (fboundp sym)
                                                   (symbol-plist sym))))
                          'string-lessp))))
    (candidates . anything-c-source-lisp-symbol-candidates)
    (action . (lambda (c)
                (anything-dabbrev-insert c anything-lisp-init-target)))
    (volatile)))

(defun anything-search ()
  (interactive)
  (let ((anything-sources
         (list
          anything-c-source-occur
          anything-c-source-bm
          anything-c-source-imenu
          )))
    (anything)))

(defun anything-insert ()
  (interactive)
  (let ((anything-sources
         (list
          anything-c-source-yasnippet
          anything-c-source-dabbrev-buffer
          anything-c-source-dabbrev-all-buffers
          anything-c-source-lisp-symbol
          )))
    (anything)))

(defun anything-switch ()
  (interactive)
  (let ((anything-sources
         (list
          anything-c-source-buffers
          anything-c-source-recentf
          anything-c-source-file-name-history
          anything-c-source-locate-home
          anything-c-source-bookmarks
          anything-c-source-buffer-not-found
          anything-c-source-man-pages
          anything-c-source-info-pages
          anything-c-source-calculation-result
          )))
    (anything)))

