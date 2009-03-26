;;; yasnippet for rake
;;;
;;; Shoji Nishimura (shoji_n@muc.biglobe.ne.jp)
;;; 2008/06/24

(defun ruby-rake-mode-p ()
  (string-match "[rR]akefile" (file-name-nondirectory (buffer-file-name))))

(yas/define-snippets
 'ruby-mode
 '(
   ("namespace" "namespace :${name} do\n$0\nend\n" "namespace :name do ... end" (ruby-rake-mode-p))
   ("desc" "desc \"${msg}\"" "desc message" (ruby-rake-mode-p))
   ("task" "task ${target} do\n$0\nend" "task target do ... end" (ruby-rake-mode-p))
   ("task.d" "task ${target} => ${depend} do\n$0\nend" "task target => depend do ... end" (ruby-rake-mode-p))
   ("file" "file \"${name}\" => ${req} do |${t}|\n$0\nend" "file name => dep do |t| ... end" (ruby-rake-mode-p))
   ("rule" "rule '.${from}' => '.${to}' do |${t}|\n$0\nend" "rule .c => .o to |t| ... end" (ruby-rake-mode-p))
   )
 'text-mode)

