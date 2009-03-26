;;;; -*- mode: emacs-lisp; coding: iso-2022-7bit -*-
;;;;
;;;; Copyright (C) 2001 The Meadow Team

;; Author: Koichiro Ohba <koichiro@meadowy.org>
;;      Kyotaro HORIGUCHI <horiguti@meadowy.org>
;;      Hideyuki SHIRAI <shirai@meadowy.org>
;;      KOSEKI Yoshinori <kose@meadowy.org>
;;      and The Meadow Team.

;; ;;; Mule-UCS $B$N@_Dj(B
;; ;; ftp://ftp.m17n.org/pub/mule/Mule-UCS/ $B$,(B $B%*%U%#%7%c%k%5%$%H$G$9$,!"(B
;; ;; http://www.meadowy.org/~shirai/elisp/mule-ucs.tar.gz $B$K4{CN$N%Q%C%A(B
;; ;; $B$r$9$Y$FE,MQ$7$?$b$N$,$*$$$F$"$j$^$9!#(B
;; ;; (set-language-environment) $B$NA0$K@_Dj$7$^$9(B
(require 'jisx0213)


;;; $BF|K\8l4D6-@_Dj(B
(set-language-environment "Japanese")

;;; gnuserv
(require 'gnuserv)
(gnuserv-start)
(setq gnuserv-frame (selected-frame))

;;; IME$B$N@_Dj(B
(mw32-ime-initialize)
(setq default-input-method "MW32-IME")
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[$B$"(B]" "[--]"))
(add-hook 'mw32-ime-on-hook
          (function (lambda () (set-cursor-height 2))))
(add-hook 'mw32-ime-off-hook
          (function (lambda () (set-cursor-height 4))))


;; ;;; $B%+!<%=%k$N@_Dj(B
;; ;; (set-cursor-type 'box)            ; Meadow-1.10$B8_49(B (SKK$BEy$G?'$,JQ$k@_Dj(B)
;; ;; (set-cursor-type 'hairline-caret) ; $B=DK@%-%c%l%C%H(B


;;; $B%^%&%9%+!<%=%k$r>C$9@_Dj(B
(setq w32-hide-mouse-on-key t)
(setq w32-hide-mouse-timeout 5000)


;;; font-lock$B$N@_Dj(B
(global-font-lock-mode t)


;;; TrueType $B%U%)%s%H@_Dj(B
(w32-add-font
  "private-fontset"
  '((spec
     ((:char-spec ascii :height 120)
      strict
      (w32-logfont "Bitstream Vera Sans Mono" 0 -14 400 0 nil nil nil 0 1 3 49))
     ((:char-spec ascii :height 120 :weight bold)
      strict
      (w32-logfont "Bitstream Vera Sans Mono" 0 -14 700 0 nil nil nil 0 1 3 49))
     ((:char-spec ascii :height 120 :slant italic)
      strict
      (w32-logfont "Bitstream Vera Sans Mono" 0 -14 400 0   t nil nil 0 1 3 49))
     ((:char-spec ascii :height 120 :weight bold :slant italic)
      strict
      (w32-logfont "BitStream Vera Sans Mono" 0 -14 700 0   t nil nil 0 1 3 49))
     ((:char-spec japanese-jisx0208 :height 120)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -16 400 0 nil nil nil 128 1 3 49))
     ((:char-spec japanese-jisx0208 :height 120 :weight bold)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -16 700 0 nil nil nil 128 1 3 49)
      ((spacing . -1)))
     ((:char-spec japanese-jisx0208 :height 120 :slant italic)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -16 400 0   t nil nil 128 1 3 49))
     ((:char-spec japanese-jisx0208 :height 120 :weight bold :slant italic)
      strict
      (w32-logfont "IPA$B%4%7%C%/(B" 0 -16 700 0   t nil nil 128 1 3 49)
      ((spacing . -1))))))

(set-face-attribute 'variable-pitch nil :font "private-fontset")


;; ;;; BDF $B%U%)%s%H@_Dj(B
;;
;; ;;; ($BJ}K!$=$N(B1) Netinstall $B%Q%C%1!<%8$r;H$&J}K!(B
;; ;;; misc $B$H(B intlfonts $B%Q%C%1!<%8$rF~$l$^$9!#(B
;; ;;; .emacs$B$N@_Dj(B
;; (setq bdf-use-intlfonts16 t)
;; (setq initial-frame-alist '((font . "intlfonts16")))
;;
;; ;;; ($BJ}K!$=$N(B1')
;; ;;; intlfonts-file-16dot-alist $B$N7A<0$G(B bdf-fontset-alist $B$r=q$-!"(B
;; ;;; $B<!$r@_Dj$9$l$PNI$$!#(B
;; ;;;  (require 'bdf)
;; ;;;  (bdf-configure-fontset "bdf-fontset" bdf-fontset-alist)
;; ;;; $B>\:Y$O(B $MEADOW/pkginfo/auto-autoloads.el $B$H(B $MEADOW/site-lisp/bdf.el $B$r(B
;; ;;; $B;2>H$N$3$H!#(B
;;
;; ;;; ($BJ}K!$=$N(B2)
;; ;;; $B%U%)%s%H$N;XDjJ}K!$O<!$N%5%s%W%k$r;29M$K$9$k!#(B
;; ;;; normal, bold, italic, bold-itaric $B%U%)%s%H$r;XDj$9$kI,MW$"$j!#(B
;; (setq bdf-font-directory "c:/Meadow/fonts/intlfonts/")
;; (w32-add-font "bdf-fontset"
;; `((spec
;;    ;; ascii
;;    ((:char-spec ascii :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "lt1-16-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "lt1-16b-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "lt1-16i-etl.bdf" bdf-font-directory)))
;;    ((:char-spec ascii :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "lt1-16bi-etl.bdf" bdf-font-directory)))
;;    ;; katakana-jisx0201
;;    ((:char-spec katakana-jisx0201 :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb)))
;;    ((:char-spec katakana-jisx0201 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb)))
;;    ((:char-spec katakana-jisx0201 :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb)))
;;    ((:char-spec katakana-jisx0201 :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
;;     ((encoding . 1-byte-set-msb)))
;;    ;; latin-jisx0201
;;    ((:char-spec latin-jisx0201 :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ((:char-spec latin-jisx0201 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ((:char-spec latin-jisx0201 :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ((:char-spec latin-jisx0201 :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
;;    ;; japanese-jisx0208
;;    ((:char-spec japanese-jisx0208 :height any :weight normal :slant normal)
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
;;    ((:char-spec japanese-jisx0208 :height any :weight bold :slant normal)
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
;;    ((:char-spec japanese-jisx0208 :height any :weight normal :slant any)
;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
;;    ((:char-spec japanese-jisx0208 :height any :weight bold :slant any)
;;     strict (bdf-font ,(expand-file-name "j90-16b.bdf" bdf-font-directory))))))

;; $B=i4|%U%l!<%`$N@_Dj(B
(setq default-frame-alist
      (append (list '(foreground-color . "black")
                    '(background-color . "LemonChiffon")
                    '(background-color . "gray")
                    '(border-color . "black")
                    '(mouse-color . "white")
                    '(cursor-color . "black")
                    '(ime-font . (w32-logfont "IPA$B%4%7%C%/(B"
                                            0 -16 400 0 nil nil nil
                                            128 1 3 49)) ; TrueType $B$N$_(B
;;                  '(font . "bdf-fontset")    ; BDF
                    '(font . "private-fontset"); TrueType
                    '(width . 80)
                    '(height . 40)
                    '(top . 100)
                    '(left . 100))
              default-frame-alist))


;;; shell $B$N@_Dj(B

;;; Cygwin $B$N(B bash $B$r;H$&>l9g(B
(setq explicit-shell-file-name "bash")
(setq shell-file-name "sh")
(setq shell-command-switch "-c")

;; ;;; Virtually UN*X!$B$K$"$k(B tcsh.exe $B$r;H$&>l9g(B
;; (setq explicit-shell-file-name "tcsh.exe")
;; (setq shell-file-name "tcsh.exe")
;; (setq shell-command-switch "-c")

;; ;;; WindowsNT $B$KIUB0$N(B CMD.EXE $B$r;H$&>l9g!#(B
;; (setq explicit-shell-file-name "CMD.EXE")
;; (setq shell-file-name "CMD.EXE")
;; (setq shell-command-switch "\\/c")


;;; argument-editing $B$N@_Dj(B
(require 'mw32script)
(mw32script-init)


;; ;;; browse-url $B$N@_Dj(B
;; (global-set-key [S-mouse-2] 'browse-url-at-mouse)


;; ;;; $B0u:~$N@_Dj(B
;; ;; $B$3$N@_Dj$G(B M-x print-buffer RET $B$J$I$G$N0u:~$,$G$-$k$h$&$K$J$j$^$9(B
;; ;;
;; ;;  notepad $B$KM?$($k%Q%i%a!<%?$N7A<0$N@_Dj(B
;; (define-process-argument-editing "notepad"
;;   (lambda (x) (general-process-argument-editing-function x nil t)))
;;
;; (defun w32-print-region (start end
;;                                &optional lpr-prog delete-text buf display
;;                                &rest rest)
;;   (interactive)
;;   (let ((tmpfile (convert-standard-filename (buffer-name)))
;;         (w32-start-process-show-window t)
;;         ;; $B$b$7!"(Bdos $BAk$,8+$($F$$$d$J?M$O>e5-$N(B `t' $B$r(B `nil' $B$K$7$^$9(B
;;         ;; $B$?$@$7!"(B`nil' $B$K$9$k$H(B Meadow $B$,8G$^$k4D6-$b$"$k$+$b$7$l$^$;$s(B
;;         (coding-system-for-write w32-system-coding-system))
;;     (while (string-match "[/\\]" tmpfile)
;;       (setq tmpfile (replace-match "_" t nil tmpfile)))
;;     (setq tmpfile (expand-file-name (concat "_" tmpfile "_")
;;                                     temporary-file-directory))
;;     (write-region start end tmpfile nil 'nomsg)
;;     (call-process "notepad" nil nil nil "/p" tmpfile)
;;     (and (file-readable-p tmpfile) (file-writable-p tmpfile)
;;          (delete-file tmpfile))))
;;
;; (setq print-region-function 'w32-print-region)

;;; fakecygpty $B$N@_Dj(B
;; $B$3$N@_Dj$G(B cygwin $B$N2>A[C<Kv$rMW5a$9$k%W%m%0%i%`$r(B Meadow $B$+$i(B
;; $B07$($k$h$&$K$J$j$^$9(B
(setq mw32-process-wrapper-alist
       '(("/\\(bash\\|tcsh\\|svn\\|ssh\\|gpg[esvk]?\\)\\.exe" .
          (nil . ("fakecygpty.exe" . set-process-connection-type-pty)))))


;;; $B%m!<%+%k$N%i%$%V%i%j$r%m!<%I$7$^$9(B
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(defun load-emacs-directory (&optional dir pattern)
  (let ((dir (or dir "~/.emacs.d"))
        (pattern (or pattern "^[0-9][0-9].*.el$")))
    (mapc '(lambda (file) (load (concat dir "/" file)))
          (directory-files dir nil pattern))))

(load-emacs-directory)


;;;
;;; end of file
;;;

;; Beginning of the el4r block:
;; RCtool generated this block automatically. DO NOT MODIFY this block!
;(add-to-list 'load-path "C:/ruby/share/emacs/site-lisp")
;(require 'el4r)
;(el4r-boot)
;; End of the el4r block.
;; User-setting area is below this line.
