;; (require 'eww)
;; ;; (setq eww-search-prefix "https://www.google.co.jp/search?q=")
;; (defun duckduckgo (search-string)
;;   "Search Duck Duck Go for SEARCH-STRING.

;; Use kd=-1 to turn off redirecting - seems to be required in order
;; for result links to work in DDG."
;;   (interactive "sDuckDuckGo for: ")
;;   (let ((url-format "https://duckduckgo.com/html/?q=%s&kd=-1"))
;;     (eww (format url-format (url-hexify-string search-string)))))

(use-package eww
  :commands (eww)
  :config
  (setq eww-search-prefix "http://www.google.co.jp/search?q=")
  (defadvice linum-on(around my-linum-eww-on() activate)
    (unless (eq major-mode 'eww-mode) ad-do-it)))
