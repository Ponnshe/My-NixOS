;;;; APPT.EL - NixOS

(use-package appt
  :ensure nil
  :config
  (require 'org-agenda)

  ;; 1. Configuración de notificaciones
  (setq appt-message-warning-time 5) ;; Avisar 5 minutos antes
  (setq appt-display-interval 1)     ;; Avisar cada minuto una vez que empieza el aviso
  (setq appt-display-mode-line t)

  (setq appt-disp-window-function
        (lambda (min-to-app new-time msg)
          (let ((m (string-to-number min-to-app)))
            ;; Solo dispara si faltan 5 minutos o si es el momento exacto (0)
            (when (or (= m 5) (= m 0))
              (let* ((clean-msg (replace-regexp-in-string "\\[\\[.*?\\]\\[\\(.*?\\)\\]\\]" "\\1" msg))
                     (final-msg (replace-regexp-in-string "^[0-9:]+ " "" clean-msg))
                     (urgency (if (= m 0) "critical" "normal"))
                     (titulo (if (= m 0) 
                                 (format "¡AHORA!: %s" final-msg)
                               (format "PROXIMAMENTE: %s" final-msg))))
                
                (start-process "org-notification" nil "notify-send"
                               "-u" urgency
                               "-a" "Emacs Agenda"
                               "-i" "appointment-soon"
                               titulo
                               (format "Inicia en %s minutos (%s)" min-to-app new-time)))))))

  ;; 2. Sincronización automática
  (defun my/org-agenda-to-appt-silent ()
    "Actualiza las citas de appt desde los archivos de agenda sin molestar."
    (interactive)
    (setq appt-time-msg-list nil)
    (org-agenda-to-appt t))

  ;; Actualizar al guardar cualquier archivo org
  (add-hook 'org-mode-hook
            (lambda ()
              (add-hook 'after-save-hook #'my/org-agenda-to-appt-silent nil t)))

  ;; 3. Forzar actualización cada hora
  (run-at-time "00:59" 3600 #'my/org-agenda-to-appt-silent)

  ;; Activar el sistema
  (appt-activate 1)
  (my/org-agenda-to-appt-silent))
