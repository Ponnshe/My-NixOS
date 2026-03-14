;;;; WHICH-KEY.EL - Managed by NixOS

;; Which Key
;; Show informations while pressing key combinations
;; https://github.com/justbur/emacs-which-key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3)
)
