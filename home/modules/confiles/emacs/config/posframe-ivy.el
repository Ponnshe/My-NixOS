;;;; IVY-POSFRAME.EL - Managed by NixOS

;; Ivy Posframe
;; Displays Ivy menus in a pop-up child frame (posframe) instead of the minibuffer,
;; keeping the focus at the center of the screen.
;; https://github.com/tumashu/ivy-posframe
(use-package ivy-posframe
  :config
  ;; Set the position of the posframe.
  ;;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
  
  (setq ivy-posframe-parameters
        '((left-fringe . 4)
          (right-fringe . 4)))
  
  ;; Enable ivy-posframe
  (ivy-posframe-mode 1)

  ;; Re-bind navigation keys specifically for the posframe minibuffer
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line))
