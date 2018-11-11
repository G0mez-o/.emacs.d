(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (wombat)))
 '(font-use-system-font t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote bottom)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 128 :width normal)))))
(global-linum-mode t)
(add-to-list 'auto-mode-alist'("\\.md\\'" . markdown-mode))
(setq inhibit-startup-screen t)

;; showing full-pass on title
(setq frame-title-format "%f")

;; deleting initial-scratch-message
(setq initial-scratch-message "")

;; active window move
(global-set-key (kbd "<C-left>")  'windmove-left)
(global-set-key (kbd "<C-down>")  'windmove-down)
(global-set-key (kbd "<C-up>")    'windmove-up)
(global-set-key (kbd "<C-right>") 'windmove-right)

;; comment-out
;; selected region
(global-set-key (kbd "C-c o") 'comment-region)

;;release-comment-out
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

(setq completion-ignore-case t)

(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background  "#98FB98"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(blink-cursor-mode 0)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-coding-systems 'utf-8)(set-terminal-coding-system 'euc-jp)
(set-keyboard-coding-system 'euc-jp)
