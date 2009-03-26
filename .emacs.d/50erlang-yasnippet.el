;;; yasnippet for erlang
;;;
;;; Shoji Nishimura (shoji_n@muc.biglobe.ne.jp)
;;; 2008/10/01

;;; snippet
(yas/define-snippets
 'erlang-mode
 '(
   ;; General
   ("mod" "-module(${1:$(file-name-nondirectory (file-name-sans-extension (buffer-file-name))))})." "-module()." nil)
   ("exp" "-export([${1:start/0}])." "-export()." nil)
   ("imp" "-import(${1:lists}, [${2:map/2, sum/1}])." "-import()."nil)
   ("rec" "-record(${1:Name}, {${2:key1 = Default1, ...}}.)." "-record()." nil)
   ("def" "-define(${1:macro()}, ${2:Replacement})." "-define()." nil)
   ("case" "case ${1:Expression} of\n    ${2:Pattern1 when Guard1} ->\n        ${3:Exp1}$0\nend" "case" nil)
   ("if" "if\n    ${1:Guard} ->\n        ${2:Expr}$0\nend" "if" nil)
   ("try" "try ${1:Expr} of\n    ${Pattern} ->\n        ${Expr}\ncatch\n    ${throw}:${ExPat when Guard} ->\n        ${Expr}\nend" "try-of-catch-end" nil)
   ("try.1" "try ${Expr}\ncatch\n    ${throw}:${ExPat when Guard} ->\n        ${Expr}\nend" "try-catch-end" nil)
   ("after" "after\n    ${1:Expr}" "after" nil)
   ("begin" "begin\n    ${Expr1}$0\nend" "begin-end" nil)
   ("fun" "fun(${X, Y}) -> $0 end." "fun() -> ... end" nil)
   ("receive" "receive\n    $0\nend" "receive ... end" nil)
   ;;; idioms
   ;;; lists
   ("lists:.map" "lists:map" "lists:map" nil)
   ("lists:.filter" "lists:filter(${Fun}, ${list})" "lists:filter" nil)
   ("map" "map(${Fun}, ${list})" "lists:map()" nil)
   ("filter" "filter(${Fun}, ${list})" "lists:filter()" (erlang-import-p "lists" "filter/2"))
   )
)

(defun erlang-import-p (mod fun)
  nil
  )