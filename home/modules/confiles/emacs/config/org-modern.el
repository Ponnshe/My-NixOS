(use-package org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇")
        org-modern-list '((?- . "•") (?+ . "◦"))))
