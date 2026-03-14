;;;; FILE-HANDLERS.EL - Managed by NixOS

;; Recentf
;; Keeps track of recently opened files to allow quick access via counsel-recentf.
(use-package recentf
  :ensure nil
  :config
  (recentf-mode 1))

;; Openwith
;; Allows opening specific file types with external applications (like PDF viewers).
;; https://github.com/jpkotta/openwith
(use-package openwith
  :config
  (setq openwith-associations
        '(("\\.pdf\\'" "sioyek" (file))
          ("\\.djvu\\'" "zathura" (file))
          ("\\.epub\\'" "zathura" (file))))
  (openwith-mode t))
