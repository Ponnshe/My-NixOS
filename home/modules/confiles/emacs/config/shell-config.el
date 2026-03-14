(use-package vterm
  :config
  ;; Usar Zsh en lugar de Bash en vterm
  (setq vterm-shell "/run/current-system/sw/bin/zsh")
  (setenv "ZDOTDIR" (getenv "HOME")))
