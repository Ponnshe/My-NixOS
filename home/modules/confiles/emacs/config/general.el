;;;; GENERAL.EL - Gestionado por NixOS

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1) (setq visible-bell t)

(set-face-attribute 'default nil :font "Hack Nerd Font" :height 200)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; Ocultar números de línea en terminales
(dolist (mode '(term-mode-hook
                eshell-mode-hook
                vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Home.org al iniciar
(add-hook 'emacs-startup-hook
          (lambda ()
            (find-file "/home/ponnshe/Home/Personal/Life/home.org")
            (org-agenda nil "d")))

;; Archivos auto-guardados
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save-list/" t)))

(unless (file-exists-p "~/.emacs.d/auto-save-list/")
  (make-directory "~/.emacs.d/auto-save-list/" t))

(setq select-enable-clipboard t)
