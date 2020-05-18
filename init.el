(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-use-system-font t)
 '(package-selected-packages
   (quote
    (twittering-mode multi-term mpv eww-lnum magit markdown-mode undo-tree smartparens neotree elscreen auto-complete-c-headers)))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote bottom)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;;ロードパスを自動で追加する関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "conf")
(load "display_set")
(load "org_set")

(setq ac-comphist-file "~/.emacs.d/cache/auto-complete/ac-comphist.dat")

(setq auto-save-list-file-prefix "~/.emacs.d/cache/")

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

;; release-comment-out
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

(setq completion-ignore-case t)

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

(setq delete-auto-save-files t)

(auto-image-file-mode t)

(setq backup-inhibited t)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ

(require 'smartparens)
(smartparens-global-mode t)

(require 'auto-complete-c-headers)
(add-hook 'c++-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))
(add-hook 'c-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))

;; elscreen（上部タブ）
(require 'elscreen)
(elscreen-start)
(global-set-key (kbd "\C-z \C-c") 'elscreen-create)
(global-set-key "\C-l" 'elscreen-next)
(global-set-key "\C-q" 'elscreen-previous)
(global-set-key (kbd "\C-z \C-d") 'elscreen-kill)
(set-face-attribute 'elscreen-tab-background-face nil
                    :background "grey10"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-control-face nil
                    :background "grey20"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-current-screen-face nil
                    :background "grey20"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-other-screen-face nil
                    :background "grey30"
                    :foreground "grey60")
;;; [X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; [<->]を表示しない
(setq elscreen-tab-display-control nil)
 ;;; タブに表示させる内容を決定
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
         (lambda ()
           (format "Dired(%s)" dired-directory)))
        ("^Info-mode$" .
         (lambda ()
           (format "Info(%s)" (file-name-nondirectory Info-current-file))))
        ("^mew-draft-mode$" . 
         (lambda ()
           (format "Mew(%s)" (buffer-name (current-buffer)))))
        ("^mew-" . "Mew")
        ("^irchat-" . "IRChat")
        ("^liece-" . "Liece")
        ("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
        ("compilation" . "compile")
        ("-telnet" . "telnet")
        ("dict" . "OnlineDict")
        ("*WL:Message*" . "Wanderlust")))

;; neotree をインストールする
(unless (package-installed-p 'neotree)
  (package-refresh-contents) (package-install 'neotree))

;; neotree（サイドバー）
(require 'neotree)
(global-set-key "\C-o" 'neotree-toggle)

(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)
(defun toggle-truncate-lines ())
(setq inferior-lisp-program "clisp")
;; ~/.emacs.d/slimeをload-pathに追加

;; SLIMEのロード
;; (require 'slime)
;; (slime-setup '(slime-repl slime-fancy slime-banner)) 

(add-hook 'c++-mode-hook
          '(lambda()
             ;; (c-set-style "gnu")
             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
	     (c-set-offset 'substatement-open '0)
             )) 
(setq auto-save-default nil)
(setq make-backup-files nil)

(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)

;; (setq markdown-command "pandoc")

(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

(add-to-list 'auto-mode-alist '("\\.urdf" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xacro" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.launch" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml" . yaml-mode))

(setenv "LANG" "en_US.UTF-8")
(global-set-key (kbd "C-x g") 'magit-status)

(add-hook 'c++-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'c-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'scheme-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'xml-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

(define-key
  global-map
  (kbd "C-#") 'hs-toggle-hiding)

(require 'eww)
(setq eww-search-prefix "https://www.google.co.jp/search?q=")
