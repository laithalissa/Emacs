(add-to-list 'load-path "~/.emacs.d/packages/")
;; (add-to-list 'load-path "~/.emacs.d/packages/elpa/")

(iswitchb-mode 1)
;;IRC
(require 'erc)
(require 'erc-match)
(require 'sr-speedbar)
(require 'php-mode)
(require 'move-line)
(require 'natural-commenting)
(require 'ask-to-create-dirs)
(require 'smooth-scroll)
(require 'linum-off)

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
 '(custom-enabled-themes (quote (wheatgrass)))
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring scrolltobottom stamp track)))
 '(global-visual-line-mode t)
 '(linum-format " %d  ")
 '(speedbar-default-position (quote left-right))
 '(speedbar-frame-parameters
   (quote
    ((minibuffer)
     (width . 35)
     (border-width . 0)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 0)
     (height . 50))))
 '(speedbar-indentation-width 4)
 '(sr-speedbar-max-width 35)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-width-console 35)
 '(sr-speedbar-width-x 35))



;;;;;;;;;;;;;;;;;;;;;;
;; Configure Editor ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Enable in-frame speedbar
(global-linum-mode 1)
(sr-speedbar-open)

;; (if window-system
;;   (set-frame-size (selected-frame) 160 80)
;; )

(with-current-buffer sr-speedbar-buffer-name
  (setq window-size-fixed 'width))

(setq default-frame-alist '(
                (width . 150)
                (height . 50) ))

(add-to-list 'linum-disabled-modes-list '(speedbar-mode))

;; disable line numbers in the speedbar frame. 
(add-to-list 'linum-disabled-modes-list '(sr-speedbar-mode))

;; Nice line wrapping
(visual-line-mode 1)

;; To disable audible system bell for stuff like scrolling
(setq visible-bell t)

;; Smooth scroll settings
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil)            ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ;; scroll window under mouse
(setq scroll-step 1)                                ;; keyboard scroll one line at a time



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


;;;;;;;;;;;;;;;;;;
;; Key Bindings ;;
;;;;;;;;;;;;;;;;;;

;; Set Easy Line Moving
(if (window-system)
    (progn
      (global-set-key (kbd "C-s-<up>")     'move-line-up)
      (global-set-key (kbd "C-s-<down>")   'move-line-down))
  (progn
    (global-set-key (kbd "C-<ESC>-<up>")   'move-line-up)
    (global-set-key (kbd "C-<ESC>-<down>") 'move-line-down))
)

;; Set undo (for some reason it's unset??)
(global-set-key (kbd "C-/")     'undo)

;; Set Natual Commenting 
(global-set-key (kbd "C-'")     'comment-or-uncomment-line-or-region)

;; Next and previous buffer
(global-set-key (kbd "C-c p")   'windmove-up)
(global-set-key (kbd "C-c n")   'windmove-down)
(global-set-key (kbd "C-c f")   'windmove-right)
(global-set-key (kbd "C-c b")   'windmove-left)

(global-set-key (kbd "M-g")     'goto-line)    ; M-g  'goto-line
(global-set-key (kbd "C-c C-e") 'eval-buffer)
(global-set-key (kbd "C-c s")   'speedbar)


;;;;;;;;;;;;;;;;
;;Resizing windows

(global-set-key (kbd "M-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-C-<down>") 'shrink-window)
(global-set-key (kbd "M-C-<up>") 'enlarge-window)
(global-set-key (kbd "C-x '") 'comment-or-uncomment-line-or-region)


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
       erc-prompt-for-password "moocow") ; OPN doesn't require passwords
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
