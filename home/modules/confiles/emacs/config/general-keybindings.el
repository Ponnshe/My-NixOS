;;;; GENERAL-KEYBINDINGS.EL - NixOS

;; General Package
;; Let you set personalize keybindings
(use-package general
  :config
  (general-evil-setup)
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

;; Seting the keybindings
(rune/leader-keys
    ;; File Management
    "f"  '(:ignore t :which-key "files")
    "ff" '(counsel-find-file :which-key "find file")

    ;;Buffer Management
    "b"  '(:ignore t :which-key "buffers")
    "bs"  '(counsel-switch-buffer :which-key "switch buffers")
    "bk"  '(:ignore t :which-key "kill buffers")
    "bkl"  '(kill-buffer :which-key "buffers' list")
    "bkk"  '(kill-current-buffer :which-key "kill current buffer")

    ;; Org Management
    "o"  '(:ignore t :which-key "org")
    "oc"  '(org-capture :which-key "Org Capture Templates")
    "oe" '(:ignore t :which-key "Exportar org y visualizar")
    "oep" '(my/org-export-and-compile :which-key "Compilar org y visualizar en pdf")
)
