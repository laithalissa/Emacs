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
 '(linum-format " %d  ")
 '(smooth-scroll-mode t)
 '(smooth-scroll/vscroll-step-size 1)
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
 '(sr-speedbar-right-side nil)
;; Remove scroll bars because... well... ew!
 '(scroll-bar-mode nil)
;; Remove the toolbar to make emacs look more lightweight
 '(tool-bar-mode nil))

;(defvar sr-speedbar-width nil
 ; "Initial width of speedbar-window.")
;(setq sr-speedbar-width 10)
(setq sr-speedbar-width 20)

;;;;;;;;;;;;;;;;;;;;;;
;; Configure Editor ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Enable in-frame speedbar
(global-linum-mode       1)
(global-visual-line-mode 1)
(iswitchb-mode           1)
(sr-speedbar-open)

;(with-current-buffer sr-speedbar-buffer-name
;  (setq window-size-fixed 'width))

;Emacs window size
(setq default-frame-alist '(
                (width  . 160)
                (height . 60) ))

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
       erc-prompt-for-password "moocow") ; OPN doesn't require passwords
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "grey10"))))
 '(scroll-bar ((t (:width normal)))))

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

;; Copy Line
(global-set-key "\C-c\C-k" 'copy-line)

;; Set Natual Commenting 
(global-set-key (kbd "C-'")     'comment-or-uncomment-line-or-region)
(global-set-key (kbd "C-x '")   'comment-or-uncomment-line-or-region)

;; Goto line number
(global-set-key (kbd "M-g")     'goto-line)

;; Eval buffer
(global-set-key (kbd "C-c C-e") 'eval-buffer)

;; Toggle Speedbar
(global-set-key (kbd "C-c s")   'speedbar)

;; Up/Down/Left/Right control for buffers
(global-set-key (kbd "C-c p")   'windmove-up)
(global-set-key (kbd "C-c n")   'windmove-down)
(global-set-key (kbd "C-c f")   'windmove-right)
(global-set-key (kbd "C-c b")   'windmove-left)

;;Resizing windows
(global-set-key (kbd "M-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-C-<down>") 'shrink-window)
(global-set-key (kbd "M-C-<up>") 'enlarge-window)

