;;; Replacement functions to unbreak `erc-hide-list' for ERC 5.3

(defun erc-display-buffer-list (buffer)
  "Sanitize a 'buffer' name or list, and convert to a buffer-name list."
  (cond ((bufferp buffer) (list buffer))
        ((listp buffer) buffer)
        ((processp buffer) (list (process-buffer buffer)))
        ((eq 'all buffer)
         ;; Hmm, or all of the same session server?
         (erc-buffer-list nil erc-server-process))
        ((and (eq 'active buffer) (erc-active-buffer))
         (list (erc-active-buffer)))
        ((erc-server-buffer-live-p)
         (list (process-buffer erc-server-process)))
        (t (list (current-buffer)))))

(defun erc-display-message (parsed type buffer msg &rest args)
  "Display MSG in BUFFER.

ARGS, PARSED, and TYPE are used to format MSG sensibly.

See also `erc-format-message' and `erc-display-line'."
  (let ((string (if (symbolp msg)
                    (apply 'erc-format-message msg args)
                  msg)))
    (setq string
          (cond
           ((null type)
            string)
           ((listp type)
            (mapc (lambda (type)
                    (setq string
                          (erc-display-message-highlight type string)))
                  type)
            string)
           ((symbolp type)
            (erc-display-message-highlight type string))))

    (if (not (erc-response-p parsed))
        (erc-display-line string buffer)
      (erc-put-text-property 0 (length string) 'erc-parsed parsed string)
      (erc-put-text-property 0 (length string) 'rear-sticky t string)
      (dolist (buf (erc-display-buffer-list buffer))
        (unless (member (erc-response.command parsed)
                        (with-current-buffer buf
                          erc-hide-list))
          (erc-display-line string buffer))))))
