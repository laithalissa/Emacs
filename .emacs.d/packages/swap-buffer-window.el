;; move buffer to other window
;; after c-x 3 to split screen this lets you move buffers between sides.
;; altered code from:
;; http://stackoverflow.com/questions/1774832/how-to-swap-the-buffers-in-2-windows-emacs
(provide 'swap-buffer-window)

(defun swap-buffer-window ()
  "Put the buffer from the selected window in next window, and vice versa"
  (interactive)
  (let* ((this (selected-window))
     (other (next-window))
     (this-buffer (window-buffer this)))
    (set-window-buffer other this-buffer)
    (tabbar-close-tab) ;;close current tab
    (other-window 1) ;;swap cursor to new buffer
    )
  )
