;;;; ORG-MODE.EL - Gestionado por NixOS

(defun efs/org-mode-setup ()
  (visual-line-mode 1)
  (column-number-mode 1)
  (setq-local org-src-preserve-indentation t)
  (setq-local org-src-tab-acts-natively t)
  (setq-local org-src-fontify-natively t)
	(setq org-preview-latex-default-process 'dvisvgm)
	)

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(use-package org
  :defer t
  :hook (org-mode . efs/org-mode-setup)
  :init
  (setq org-agenda-files
        '("~/Home/Personal/Life/Tasks.org"
          "~/Home/Personal/Life/Habits.org"
          "~/Home/Personal/Life/calendars"
          "/home/ponnshe/Home/Personal/org-mind/20251226230713-life_2026.org"))
  :config
  (setq org-M-RET-may-split-line nil)
  (setq org-startup-folded 'overview)
  (setq org-ellipsis " ▾")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-log-reschedule 'note)

  (require 'org-tempo)
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)" "MISSED(m@)")
          (sequence "TOREAD(r)" "READING(c)" "|" "COMPLETED(c)")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("Tasks.org" :maxlevel . 1)))

  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
        '((:startgroup)
          (:endgroup)
          ("STUDY" . ?S) ("NOTE" . ?N) ("CLASE" . ?C)
          ("TP" . ?T) ("PARCIALITO" . ?p) ("EJERCICIOS" . ?E) ("PARCIAL" . ?P)))

  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "+NOTE/+TODO" ((org-agenda-overriding-header "Notes to write")))
            (tags-todo "/STUDY+ACTIVE" ((org-agenda-overriding-header "STUDY")))
            (todo "READING" ((org-agenda-overriding-header "Reading")))
            (todo "TOREAD" ((org-agenda-overriding-header "To Read")))
            (todo "TODO"
                  ((org-agenda-overriding-header "Not Scheduled Tasks")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp 'regexp ":NOTE"))))))))

  (setq org-capture-templates
        `(("s" "Fast Note")
          ("ss" "Task" entry (file+olp "~/Home/Personal/Life/refile.org" "Inbox")
           "* %?\n  %U\n" :empty-lines 1)
          ("t" "Tasks / Projects")
          ("tt" "Task" entry (file+olp "~/Home/Personal/Life/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)))

  (define-key global-map (kbd "C-c a") (lambda () (interactive) (org-agenda nil "d")))

  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (setq org-startup-with-inline-images nil))

(use-package org-download
  :hook (dired-mode-hook . org-download-enable))
