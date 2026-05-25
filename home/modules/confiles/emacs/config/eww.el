;;Configuration for eww browser
;; Optimización del motor de renderizado
(setq shr-use-colors nil)                ; Elimina el CSS de colores basura
(setq shr-use-fonts nil)                 ; Fuerza la tipografía de tu terminal/GUI
(setq shr-inhibit-images t)              ; Bloquea imágenes por defecto para velocidad (alterna con 'I')
(setq eww-search-prefix "https://lite.duckduckgo.com/lite/?q=") ; Forzar buscador sin JS

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "qutebrowser")
