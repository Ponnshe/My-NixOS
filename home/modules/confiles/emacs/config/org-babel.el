;;;; ORG-BABEL.EL - NixOS

(use-package ob-typescript)
(use-package ob-go)
(use-package ob-rust)

(setq org-plantuml-exec-mode 'plantuml)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (C . t)
   (sql . t)
   (typescript . t)
   (java . t)
   (shell . t)
   (plantuml . t)
   (go . t)
   (mermaid . t)
   (rust . t)))

(setq org-confirm-babel-evaluate nil)

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("cp"  . "src C"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("cpp" . "src C++"))
  (add-to-list 'org-structure-template-alist '("ja" . "src java"))
  (add-to-list 'org-structure-template-alist '("rs" . "src rust"))
  (add-to-list 'org-structure-template-alist '("pu" . "src plantuml :result file :file plantuml-images/")))
