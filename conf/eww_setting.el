(use-package eww
  :commands (eww)
  :config
  (setq eww-search-prefix "http://www.google.co.jp/search?q=")
  (defadvice linum-on(around my-linum-eww-on() activate)
    (unless (eq major-mode 'eww-mode) ad-do-it)))

(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

(defun view-github-grass (account)
  (interactive "sYour GitHub account: ")
  (eww-browse-url (format "https://grass-graph.moshimo.works/images/%s.png" account)))

(defun search-at-qiita (word)
  (interactive "sKeyword: ")
  (eww-browse-url (format "https://qiita.com/search?q=%s" word)))
