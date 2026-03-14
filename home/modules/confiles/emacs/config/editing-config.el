;;;; EDITING-CONFIG.EL - Managed by NixOS

;; Electric Pair Mode
;; Automatically closes parentheses, brackets, and quotes.
;; It's a built-in package, so we use :ensure nil.
(use-package elec-pair
  :ensure nil
  :init
  (electric-pair-mode 1)
  :config
  ;; Fix for Org-mode: Inhibit pairing of "<" to avoid breaking Org-tempo shortcuts
  (defun efs/org-mode-inhibit-less-than-pair (char)
    (if (and (eq major-mode 'org-mode)
             (eq char ?<))
        t
      (electric-pair-default-inhibit char)))

  (setq electric-pair-inhibit-predicate #'efs/org-mode-inhibit-less-than-pair))

;; Other basic editing defaults
(setq-default indent-tabs-mode nil) ; Use spaces instead of tabs
(setq make-backup-files nil)        ; Stop creating those annoying file.txt~
