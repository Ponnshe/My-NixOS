(use-package elfeed
  :bind ("C-x w" . elfeed)
  :config
  (setq elfeed-db-directory "~/.emacs.d/elfeeddb"))

(use-package elfeed-org
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/Home/Personal/Life/elfeed.org")))
