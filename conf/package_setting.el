(defvar my-favorite-package-list
  '(twittering-mode
    multi-term
    mpv
    eww-lnum
    magit
    markdown-mode
    undo-tree
    smartparens
    neotree
    elscreen
    auto-complete-c-headers
    org-plus-contrib
    pdf-tools
    use-package
    dired-k)
  "packages to be installed")

(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)
(package-refresh-contents)
(unless package-archive-contents (package-refresh-contents))
(dolist (pkg my-favorite-package-list)
  (unless (package-installed-p pkg)
    (package-install pkg)))
;; (pdf-tools-install)
