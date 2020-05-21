(defvar *EmacsAA* "□□□□□□                                \n□                                    \n□       □□□□  □□    □□□    □□□□  □□□□\n□       □□  □□  □  □   □  □□  □  □   \n□□□□□□  □   □   □      □  □      □   \n□       □   □   □  □□□□□  □       □□ \n□       □   □   □  □   □  □         □\n□       □   □   □  □  □□  □□  □  □  □\n□□□□□□  □   □   □  □□□□□   □□□□  □□□□\n\n\n")
(defvar *message* (concat "My Emacs Git Status\n" "------------------------------------\n" (shell-command-to-string "cd ~/.emacs.d && git fetch && git status") "\n------------------------------------\n"))
;; (setq initial-scratch-message *message*)
(setq initial-scratch-message (concat *EmacsAA* *message*))
