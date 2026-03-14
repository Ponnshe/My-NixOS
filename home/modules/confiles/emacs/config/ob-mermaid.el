(use-package mermaid-mode)

(use-package ob-mermaid
  :after org
  :config
  (setq ob-mermaid-cli-executable "mmdc")
  (setq ob-mermaid-cli-path "mmdc")
)

