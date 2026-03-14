;;;; ORG-ROAM-BIBTEX.EL - NixOS

(use-package bibtex-completion
  :config
  (setq bibtex-completion-bibliography '("~/library/library.bib")
        bibtex-completion-pdf-field "File"
        bibtex-completion-notes-path "~/Home/Personal/org-mind/grimorio/library"))

(use-package ivy-bibtex
  :config
  (setq ivy-re-builders-alist
        '((ivy-bibtex . ivy--regex-ignore-order)
          (t . ivy--regex-plus))))

(use-package org-roam-bibtex
  :after org-roam
  :config
  (setq bibtex-completion-bibliography '("~/library/library.bib")
        bibtex-completion-pdf-field "File"
        bibtex-completion-notes-path "~/Home/Personal/org-mind/grimorio/library"
        org-roam-bibtex-preformat-keywords
        '("=key=" "title" "url" "file" "author-or-editor" "keywords" "year" "doi" "isbn" "abstract")
        orb-roam-ref-format ""
        org-roam-bibtex-include-notes t)
  (org-roam-bibtex-mode 1))

(with-eval-after-load 'org-roam
  (add-to-list 'org-roam-capture-templates
               '("r" "reference" plain "%?"
                 :if-new (file+head "grimorio/library/${citekey}.org"
                                    "#+title: ${title}\n#+category: #+filetags:")
                 :unnarrowed t
                 :empty-lines 0)))

(use-package citar
  :config
  (setq citar-bibliography '("~/library/library.bib")
        citar-notes-paths '("~/Home/Personal/org-mind/grimorio/library")))

(with-eval-after-load 'org
  (require 'oc)
  (require 'oc-bibtex)
  (setq org-cite-global-bibliography '("~/library/library.bib")
        org-cite-insert-processor 'citar
        org-cite-follow-processor 'citar))
