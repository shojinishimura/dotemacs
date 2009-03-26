(setq load-path (cons "C:/Program Files/erl5.5.4/lib/tools-2.5.4/emacs"
		      load-path))
(setq erlang-root-dir "C:/Program Files/erl5.5.4")
(setq exec-path (cons "C:/Program Files/erl5.5.4/bin" exec-path))
(require 'erlang-start)

(add-hook 'erlang-mode-hook 'yas/minor-mode-on)
