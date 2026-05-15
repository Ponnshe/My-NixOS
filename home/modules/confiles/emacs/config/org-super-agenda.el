(use-package org-super-agenda
  :config
  (org-super-agenda-mode)
  (setq org-super-agenda-groups
        '((:name "TODAY'S SCHEDULE"
                 :scheduled today)
          (:name "DUE TODAY"
                 :deadline today)
          (:name "UPCOMING DEADLINES"
                 :deadline future)
          (:name "OVERDUE"
                 :deadline past)
          (:name "UNIVERSITY (UBA)"
                 :tag "UBA"))))
