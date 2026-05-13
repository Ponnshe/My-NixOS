;;;; INIT.EL - Gestionado por NixOS

;; Basic adjust for performance
(setq gc-cons-threshold (* 50 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1024 1024))))

;; Load nix dependencies
(load (expand-file-name "nix-env.el" user-emacs-directory) t)

;; Deviate custom system
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(load (expand-file-name "config/use-package.el" user-emacs-directory)) ;;Package manager 
(setq org-image-actual-width '(300))

;; UI and base config
(load (expand-file-name "config/general.el" user-emacs-directory))

;; Global keybindings
(load (expand-file-name "config/keybindings.el" user-emacs-directory))
(load (expand-file-name "config/general-keybindings.el" user-emacs-directory))

;; Core
(load (expand-file-name "config/evil-mode.el" user-emacs-directory))
(load (expand-file-name "config/ivy.el" user-emacs-directory))
(load (expand-file-name "config/counsel.el" user-emacs-directory))
(load (expand-file-name "config/which-key.el" user-emacs-directory))
(load (expand-file-name "config/posframe-ivy.el" user-emacs-directory))
(load (expand-file-name "config/open-with.el" user-emacs-directory))
(load (expand-file-name "config/editing-config.el" user-emacs-directory))

;; Org Mode & Roam
(load (expand-file-name "config/org-mode.el" user-emacs-directory))
(load (expand-file-name "config/org-babel.el" user-emacs-directory))
(load (expand-file-name "config/org-export.el" user-emacs-directory))
(load (expand-file-name "config/org-roam.el" user-emacs-directory))
(load (expand-file-name "config/org-roam-ui.el" user-emacs-directory))
(load (expand-file-name "config/org-modern.el" user-emacs-directory))
(load (expand-file-name "config/org-roam-bibtex.el" user-emacs-directory))
(load (expand-file-name "config/appt.el" user-emacs-directory))

;; Tools and dev
(load (expand-file-name "config/dired.el" user-emacs-directory))
(load (expand-file-name "config/projectile-and-git.el" user-emacs-directory))
(load (expand-file-name "config/shell-config.el" user-emacs-directory))
(load (expand-file-name "config/plantuml.el" user-emacs-directory))
(load (expand-file-name "config/rustic.el" user-emacs-directory))
(load (expand-file-name "config/ob-mermaid.el" user-emacs-directory))

(load (expand-file-name "config/sudo-edit.el" user-emacs-directory))
(load (expand-file-name "config/eww.el" user-emacs-directory))
;; Aesthetics
(load (expand-file-name "config/doom-modeline.el" user-emacs-directory))
(load (expand-file-name "config/rand-theme.el" user-emacs-directory))
(load (expand-file-name "config/doom-themes.el" user-emacs-directory))
(load (expand-file-name "config/all-the-icons.el" user-emacs-directory))

;; Fixes for HTML export and custom variables
(setq org-html-htmlize-output-type 'css
      org-html-htmlize-font-prefix "org-"
      org-html-htmlize-generate-css 'file)

(setq debug-on-error t)
