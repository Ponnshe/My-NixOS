(use-package org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (with-eval-after-load 'org (global-org-modern-mode))
  (setq org-modern-star '("◉" "○" "◈" "◇")
        org-modern-list '((?- . "•") (?+ . "◦")))
	(setq org-modern-agenda 
        '((nil . "  ") ; Añade un margen a la izquierda
          (priority . t)
          (todo . t)
          (tags . t)
          (date . t)
          (time . t)))
)
