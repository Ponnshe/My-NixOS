;;;; PROJECTILE-AND-GIT.EL - NixOS

(use-package projectile
  :diminish projectile-mode
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :custom
  (projectile-completion-system 'ivy)
  (projectile-find-dir-includes-top-level t)
  :init
  (when (file-directory-p "~/Home/Personal")
    (setq projectile-project-search-path '("~/Home/Personal/Projects"
                                           "~/Home/Studying")))
  :config
  (projectile-mode +1))

(use-package counsel-projectile
  :after projectile
  :config
  (counsel-projectile-mode 1)
  (counsel-projectile-modify-action
   'counsel-projectile-switch-project-action
   '((default 3))))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
