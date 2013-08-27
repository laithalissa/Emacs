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
 '(custom-enabled-themes (quote (wheatgrass)))
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring scrolltobottom stamp track)))
 '(linum-format " %d  ")
 '(speedbar-default-position (quote left-right))
 '(sr-speedbar-right-side nil)
 ;; Remove scroll bars because... well... ew!
 '(scroll-bar-mode nil)
 ;; Remove the toolbar to make emacs look more lightweight
 '(tool-bar-mode nil))

(setq sr-speedbar-width 20)

;;;;;;;;;;;;;;;;;;;;;;
;; Configure Editor ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Enable in-frame speedbar
(global-linum-mode       1)
(global-visual-line-mode 1)
(iswitchb-mode           1)
(column-number-mode      1)

;; Check if speedbar exists firs otherwith you get an annoying error message
(if (not 'sr-speedbar-exist-p)
    (sr-speedbar-open))

;Emacs window size
(setq default-frame-alist '(
                (width  . 160)
                (height . 75) ))

(add-to-list 'linum-disabled-modes-list '(speedbar-mode))

;; disable line numbers in the speedbar frame. 
(add-to-list 'linum-disabled-modes-list '(sr-speedbar-mode))

;; Nice line wrapping
(visual-line-mode 1)

;; To disable audible system bell for stuff like scrolling
(setq visible-bell t)

;; Smooth scroll settings 
(smooth-scroll-mode                   1)
(setq smooth-scroll/vscroll-step-size 1)
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


