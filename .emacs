(add-to-list 'load-path "~/.emacs.d/packages/")
;; (add-to-list 'load-path "~/.emacs.d/packages/elpa/")

(require 'sr-speedbar)
(require 'php-mode)
(require 'move-line)
(require 'natural-commenting)
(require 'ask-to-create-dirs)
(require 'smooth-scroll)
(require 'linum-off)
(require 'erc)
(require 'erc-match)
(require 'copy-line)
(require 'align-with-spaces)
(require 'multiple-cursors)
(require 'laith-keybindings)

;; The following dependencies are listed in my keybindings file
;(require 'move-line)
;(require 'copy-line)
;(require 'natural-commenting)

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.5)
 '(ac-candidate-limit 6)
 '(ac-delay 0.5)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring scrolltobottom stamp track)))
 '(linum-format " %d  ")
 '(magit-repo-dirs nil)
 '(scroll-bar-mode nil)
 '(shell-file-name "/bin/zsh")
 '(speedbar-default-position (quote left-right))
 '(speedbar-show-unknown-files t)
 '(tool-bar-mode nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Grab the correct Path ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(when (memq window-system '(mac ns))
;  (exec-path-from-shell-initialize))

;; Show emacs where ispell is
(setq ispell-program-name "/usr/local/Cellar/ispell/3.3.02/bin/ispell")

;;;;;;;;;;;;;;;;;;;;;;
;; Configure Editor ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Speedbar is too skinny by default
;(setq sr-speedbar-width 20)

;; Check if speedbar exists firs otherwith you get an annoying error message
;; ( if ( not (sr-speedbar-exist-p) )
;;     (sr-speedbar-open)
;; )

;; Emacs window size
(setq default-frame-alist '((width  . 160) (height . 75)))

;; Keep linum disabled on speedbar
(add-to-list 'linum-disabled-modes-list '(speedbar-mode))

;; disable line numbers in the speedbar frame. 
(add-to-list 'linum-disabled-modes-list '(sr-speedbar-mode))

;; Nice line wrapping
(visual-line-mode 1)

;; To disable audible system bell for stuff like scrolling
(setq visible-bell t)

;; Smooth scroll settings 
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; two lines at a time
(setq mouse-wheel-progressive-speed nil)            ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ;; scroll window under mouse
(setq scroll-step 1)                                ;; keyboard scroll one line at a time

;; For C-v and M-v gets annoying sometime
;(smooth-scroll-mode                   1)
;(setq smooth-scroll/vscroll-step-size 1)

(global-linum-mode       1)
(global-visual-line-mode 1)
(iswitchb-mode           1)
(column-number-mode      1)

;;;;;;;;;;;;;;;;;;
;; Autocomplete ;;
;;;;;;;;;;;;;;;;;;

;; ; Jedi / Autocomplete
(autoload 'jedi:setup "jedi" nil t)
(require 'auto-complete)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

(global-auto-complete-mode t)
(add-to-list 'ac-modes 'python-mode)

;;;;;;;;;;;;;;;;;
;;     IRC     ;;
;;;;;;;;;;;;;;;;;

(setq erc-echo-notices-in-minibuffer-flag t)
(setq erc-input-line-position -2)
(setq erc-keywords '("laithmaker" "laith"))

(setq erc-server "irc.freenode.net" 
       erc-port 6667 
       erc-nick "laithmaker"
       erc-user-full-name "laithmaker"
       erc-email-userid "laithmaker"    ; for when ident is not activated
;       erc-prompt-for-password "") ; OPN doesn't require passwords
)

;; Fix auto-complete working with linum-mode 
(ac-linum-workaround)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-completion-face ((t (:foreground "controlShadowColor")))))

;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

; 'sr-speedbar-select-window)

;; Set title of frame
(setq frame-title-format
      '("%S" (buffer-file-name "%f"
                   (dired-directory dired-directory "%b"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Experimental section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-c s") '(lambda() (interactive) 
				  (if ( sr-speedbar-exist-p )
				      (sr-speedbar-select-window)
				    (progn (sr-speedbar-open) (sr-speedbar-select-window))
				    ))
)

;; JS Lint
(defun jslint-thisfile ()
  (interactive)
  (compile (format "jsl -process %s" (buffer-file-name))))

;; (add-hook 'javascript-mode-hook
;;   '(lambda ()
;;   (global-set-key (kbd "<f8>") 'jslint-thisfile)))


(add-hook 'js-mode-hook 
	  (lambda () 
	    (local-set-key (kbd "<f8>") 'jslint-thisfile )
	    ) 
)
;(global-set-key (kbd "<f8>") 'jslint-thisfile)

;;Minibuffer autocomplete

(define-global-minor-mode global-auto-complete-mode
  auto-complete-mode auto-complete-mode-maybe
  :group 'auto-complete)

;; Window numbering

(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))

;; desktop save
;; Automatically save and restore sessions
(setq desktop-dirname             "~/.emacs.d/desktop/"
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop )

(defun my-desktop ()
  "Load the desktop and enable autosaving"
  (interactive)
  (let ((desktop-load-locked-desktop "ask"))
    (desktop-read)
    (desktop-save-mode 1)))

;; Use M-x my-desktop to get going




;; Multiple curser mode
(global-set-key (kbd "C-c C-s") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;cursor
(setq-default cursor-type 'bar) 
