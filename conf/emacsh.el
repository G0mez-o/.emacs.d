(setq eshell-prompt-function
      (lambda ()
        (concat "[~"
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
