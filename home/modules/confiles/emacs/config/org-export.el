;;;; ORG-EXPORT.EL - NixOS

(require 'ox-md)

;; Compilación LaTeX y aplicaciones externas
(setq org-latex-pdf-process
      '("latexmk -pdf -interaction=nonstopmode -outdir=/home/ponnshe/exportaciones-latex %f"))

(defun my/org-export-and-compile ()
  (interactive)
  "Exporta a LaTeX, compila con latexmk y abre el PDF en Emacs sin bloquear."
  (when (eq major-mode 'org-mode)
    (org-latex-export-to-latex)
    (shell-command (format "latexmk -pdf -interaction=nonstopmode -outdir=%s %s"
                           (shell-quote-argument (expand-file-name "~/exportaciones-latex"))
                           (shell-quote-argument (concat (file-name-sans-extension buffer-file-name) ".tex"))))
    (let ((pdf-file (expand-file-name (concat (file-name-sans-extension (buffer-name)) ".pdf") 
                                      "~/exportaciones-latex/")))
      (when (file-exists-p pdf-file)
        (let ((mupdf-process (shell-command-to-string "pgrep -x mupdf")))
          (cond
           ((not (string-blank-p mupdf-process))
            (shell-command (format "kill -SIGHUP %s" mupdf-process)))
           ((string-blank-p mupdf-process)
            (start-process "open-pdf" nil "mupdf" pdf-file))))))))

(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.html\\'" . "qutebrowser %s")
        ("\\.\\(png\\|jpg\\|jpeg\\)\\'" . "imv %s")))

(setq org-format-latex-options
      '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
