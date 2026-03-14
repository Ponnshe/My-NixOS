;;;; DIRED.EL - Gestionado por NixOS

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom
  (dired-listing-switches "-alh")
  (dired-kill-when-opening-new-dired-buffer t)
  :hook ((dired-mode . diredfl-mode)
         (dired-mode . all-the-icons-dired-mode))
  :config
  (require 'dired-x))

(use-package diredfl)

(use-package all-the-icons-dired)

(use-package dired-rainbow
  :config
  (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
  (dired-rainbow-define text "#c3e88d" ("txt" "md" "org" "doc" "docx" "pdf"))
  (dired-rainbow-define code "#ffcb6b" ("el" "py" "c" "cpp" "js" "java" "sh"))
  (dired-rainbow-define media "#ff5370" ("jpg" "jpeg" "png" "gif" "bmp" "mp4" "mkv" "avi" "mp3" "ogg" "flac")))

(use-package dired-preview
  :config
  (setq dired-preview-use-other-window t
        dired-preview-delay 0.1)
  (add-hook 'dired-mode-hook 'dired-preview-mode))
