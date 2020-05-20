(setq eshell-prompt-function
      (lambda ()
        (concat "[Gomez-Shun"
                (eshell/pwd)
                (if (= (user-uid) 0) "]\n# " "]\n$ "))))
(setq eshell-command-aliases-list
      (append
       (list
        (list "ll" "ls -ltr")
        (list "la" "ls -a")
        (list "o" "xdg-open")
        (list "emacs" "find-file $1")
        (list "m" "find-file $1")
        (list "mc" "find-file $1")
        (list "d" "dired .")
        (list "l" "eshell/less $1")
        (list "cd" "cd $1 && la"))))

(defun eshell-cd-default-directory ()
  (interactive)
  (let ((dir default-directory))
    (eshell)
    (cd dir)
    (eshell-interactive-print (concat "cd " dir "\n"))
    (eshell-emit-prompt)))

(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map "\C-a" 'eshell-bol)
               (define-key eshell-mode-map "\C-p" 'eshell-previous-matching-input-from-input)
               (define-key eshell-mode-map "\C-n" 'eshell-next-matching-input-from-input))))

(setq eshell-prompt-regexp "^[^#$]*[$#] ")
