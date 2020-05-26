(set-face-background 'default "#FFF9E6")
(set-face-foreground 'default "#898989")
(set-cursor-color "#0DA2DD")

(when (eq system-type 'darwin)
  (set-face-attribute 'default nil
  		    :family "Menlo"
  		    :height 250)
  (set-fontset-font
    nil 'japanese-jisx0208
    (font-spec :family "Hiragino Kaku Gothic Pro")))

(when (eq system-type 'gnu/linux)
  (set-face-attribute 'default nil
  		    :family "Ubuntu Mono"
  		    :height 200))

(global-linum-mode t)
(add-to-list 'auto-mode-alist'("\\.md\\'" . markdown-mode))
(setq inhibit-startup-screen t)

;; showing full-pass on title
(setq frame-title-format "%f")

;; deleting initial-scratch-message
(setq initial-scratch-message "")

(setq frame-title-format "%f")

(require 'whitespace)

;; 空白
(set-face-foreground 'whitespace-space nil)
(set-face-background 'whitespace-space "#F9B9AC")
;; ファイル先頭と末尾の空行
(set-face-background 'whitespace-empty "#F9B9AC")
;; タブ
(set-face-foreground 'whitespace-tab nil)
(set-face-background 'whitespace-tab "#F9B9AC")
;; ???
(set-face-background 'whitespace-trailing "#F9B9AC")
(set-face-background 'whitespace-hspace "#F9B9AC")

(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         ;; tabs           ; タブ
                         ;; empty          ; 先頭/末尾の空行
                         ;; SPACES         ; 空白
                         ;; space-mark     ; 表示のマッピング
                         tab-mark))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; タブの表示を変更
(setq whitespace-display-mappings
      '((tab-mark ?\t [?\xBB ?\t])))

;; 発動
(global-whitespace-mode 1)

(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background  "#8DFFDD"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; showing column-number
(column-number-mode t)

;; showing file-size
(size-indication-mode t)
