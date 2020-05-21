(use-package pdf-tools
  :ensure t
  :config
  ;; initialise
  ;; (pdf-tools-install)
  )
;; (use-package pdf-annot)
(use-package pdf-history)
(use-package pdf-info)
(use-package pdf-isearch)
(use-package pdf-links)
(use-package pdf-misc)
(use-package pdf-occur)
(use-package pdf-outline)
(use-package pdf-sync)
(use-package tablist-filter)
(use-package tablist)
(add-to-list 'auto-mode-alist (cons "\\.pdf$" 'pdf-view-mode))

(use-package linum)
(global-linum-mode)
(defcustom linum-disabled-modes-list '(doc-view-mode pdf-view-mode)
  "* List of modes disabled when global linum mode is on"
  :type '(repeat (sexp :tag "Major mode"))
  :tag " Major modes where linum is disabled: "
  :group 'linum
  )
(defcustom linum-disable-starred-buffers 't
  "* Disable buffers that have stars in them like *Gnu Emacs*"
  :type 'boolean
  :group 'linum)
(defun linum-on ()
  "* When linum is running globally, disable line number in modes defined in `linum-disabled-modes-list'. Changed by linum-off. Also turns off numbering in starred modes like *scratch*"
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list)
          (and linum-disable-starred-buffers (string-match "*" (buffer-name)))
          )
    (linum-mode 1)))
(provide 'setup-linum)

(add-hook 'pdf-view-mode-hook
  (lambda ()
    (pdf-misc-size-indication-minor-mode)
    (pdf-links-minor-mode)
    (pdf-isearch-minor-mode)
  )
)
(pdf-tools-install)
