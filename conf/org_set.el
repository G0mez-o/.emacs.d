(require 'org)
(require 'ox-latex)
(require 'ox-bibtex)

(setq org-latex-classes '(("ltjsarticle"
            "\\documentclass{ltjsarticle}
\\usepackage{graphicx}
\\usepackage{color}
\\usepackage{atbegshi}
\\usepackage[unicode=true,bookmarks=true]{hyperref}
\\usepackage{bookmark}
\\usepackage{url}
\\usepackage{caption}
\\renewcommand{\\figurename}{Fig. }
\\renewcommand{\\tablename}{Table. }

[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
               ))

(setq org-latex-default-class "ltjsarticle")
(setq org-latex-pdf-process '("lualatex %b" "lualatex %b" "pbibtex %b" "lualatex %b" "lualatex %b" "lualatex %b"))

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  )
(add-hook 'org-mode-hook 'org-mode-reftex-setup)
(setq reftex-external-file-finders
       '(("tex" . "kpsewhich -format=.tex %f")
	 ("bib" . "kpsewhich -format=.bib %f")))

(defun define-bibfile (filename)
  (interactive
   (list
    (read-file-name "bibfile-name: ")))
  (setq reftex-default-bibliography `(,(format "%s" filename)))
)

(defun biblio-write (bib bst)
  (interactive
   (list
    (read-file-name "used-bibfile-name: ")
    (read-string "used-bstfile-name: ")))
  (insert (format "#+BIBLIOGRAPHY: %s %s option:-a limit:t" bib bst))
  )

(org-babel-do-load-languages 'org-babel-load-languages
    '(
        (shell . t)
        (python . t)
        (ruby . t)
        (emacs-lisp . t)
	(C . t)
	(org . t)
    )
)
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

(define-key org-mode-map (kbd "C-c C-v /") 'org-toggle-inline-images)

(add-to-list 'org-src-lang-modes '("html" . web))

(defun org-babel-execute:html (body params) body)

(defun org-http-inline-image-enable ()
  (advice-add 'org-display-inline-images :override #'my-org-display-inline-images))

(defun org-http-inline-image-disable ()
  (advice-remove 'org-display-inline-images #'my-org-display-inline-images))

(defun my-org-display-inline-images (&optional include-linked refresh beg end)
  "Display inline images.
An inline image is a link which follows either of these
conventions:
  1. Its path is a file with an extension matching return value
     from `image-file-name-regexp' and it has no contents.
  2. Its description consists in a single link of the previous
     type.  In this case, that link must be a well-formed plain
     or angle link, i.e., it must have an explicit \"file\" type.
Equip each image with the key-map `image-map'.
When optional argument INCLUDE-LINKED is non-nil, also links with
a text description part will be inlined.  This can be nice for
a quick look at those images, but it does not reflect what
exported files will look like.
When optional argument REFRESH is non-nil, refresh existing
images between BEG and END.  This will create new image displays
only if necessary.
BEG and END define the considered part.  They default to the
buffer boundaries with possible narrowing."
  (interactive "P")
  (when (display-graphic-p)
    (unless refresh
      (org-remove-inline-images)
      (when (fboundp 'clear-image-cache) (clear-image-cache)))
    (let ((end (or end (point-max))))
      (org-with-point-at (or beg (point-min))
	(let* ((case-fold-search t)
	       (file-extension-re (image-file-name-regexp))
	       (link-abbrevs (mapcar #'car
				     (append org-link-abbrev-alist-local
					     org-link-abbrev-alist)))
	       ;; Check absolute, relative file names and explicit
	       ;; "file:" links.  Also check link abbreviations since
	       ;; some might expand to "file" links.
	       (file-types-re
		(format "\\(?:\\(\\]\\[<?\\)\\|\\(?:\\[\\[\\)\\)\\(file%s:\\|attachment:\\|https?:\\|[./~]\\)"
			(if (not link-abbrevs) ""
			  (concat "\\|" (regexp-opt link-abbrevs))))))
	  (while (re-search-forward file-types-re end t)
	    (let* ((link (org-element-lineage
			  (save-match-data (org-element-context))
			  '(link) t))
                   (has-description-p (org-element-property :contents-begin link))
		   (on-description-p (match-beginning 1))
		   (inner-start (match-beginning 2))
                   (inner-head (match-string 2))
                   (use-link (and link (or (not has-description-p) include-linked)))
                   (linktype (cond
                              (use-link (org-element-property :type link))
                              (on-description-p (substring inner-head 0 -1)))) ;;chop last : or ./~
                   (linktype-is-http (or (equal "http" linktype) (equal "https" linktype)))
		   (path
		    (cond
		     ;; No link at point; no inline image.
		     ((not link) nil)
		     ;; File link without a description.  Also handle
		     ;; INCLUDE-LINKED here since it should have
		     ;; precedence over the next case.  I.e., if link
		     ;; contains filenames in both the path and the
		     ;; description, prioritize the path only when
		     ;; INCLUDE-LINKED is non-nil.
		     (use-link
		      (and (or (equal "file" linktype)
                               (equal "attachment" linktype)
                               linktype-is-http)
			   (org-element-property :path link)))
		     ;; Link with a description.  Check if description
		     ;; is a filename.  Even if Org doesn't have syntax
		     ;; for those -- clickable image -- constructs, fake
		     ;; them, as in `org-export-insert-image-links'.
		     ((not on-description-p) nil)
		     (t
		      (org-with-point-at inner-start
			(and (looking-at
			      (if (char-equal ?< (char-after inner-start))
				  org-link-angle-re
				org-link-plain-re))
			     ;; File name must fill the whole
			     ;; description.
			     (= (org-element-property :contents-end link)
				(match-end 0))
			     (match-string 2)))))))
	      (when (and path (string-match-p file-extension-re path))
		(let ((file (cond
                             ((equal "attachment" linktype)
                              (require 'org-attach)
                              (ignore-errors (org-attach-expand path)))
                             (linktype-is-http
                              (concat linktype ":" path))
                             (t
                              (expand-file-name path)))))
		  (when (and file (or linktype-is-http (file-exists-p file)))
		    (let ((width
			   ;; Apply `org-image-actual-width' specifications.
			   (cond
			    ((eq org-image-actual-width t) nil)
			    ((listp org-image-actual-width)
			     (or
			      ;; First try to find a width among
			      ;; attributes associated to the paragraph
			      ;; containing link.
			      (pcase (org-element-lineage link '(paragraph))
				(`nil nil)
				(p
				 (let* ((case-fold-search t)
					(end (org-element-property :post-affiliated p))
					(re "^[ \t]*#\\+attr_.*?: +.*?:width +\\(\\S-+\\)"))
				   (when (org-with-point-at
					     (org-element-property :begin p)
					   (re-search-forward re end t))
				     (string-to-number (match-string 1))))))
			      ;; Otherwise, fall-back to provided number.
			      (car org-image-actual-width)))
			    ((numberp org-image-actual-width)
			     org-image-actual-width)
			    (t nil)))
			  (old (get-char-property-and-overlay
				(org-element-property :begin link)
				'org-image-overlay)))
		      (if (and (car-safe old) refresh)
			  (image-refresh (overlay-get (cdr old) 'display))
			(let ((image (ignore-errors (create-image (if linktype-is-http (my-org-retrieve-image-data-from-url file) file)
						   (and (image-type-available-p 'imagemagick)
							width 'imagemagick)
						   linktype-is-http
						   :width width))))
			  (when image
			    (let ((ov (make-overlay
				       (org-element-property :begin link)
				       (progn
					 (goto-char
					  (org-element-property :end link))
					 (skip-chars-backward " \t")
					 (point)))))
			      (overlay-put ov 'display image)
			      (overlay-put ov 'face 'default)
			      (overlay-put ov 'org-image-overlay t)
			      (overlay-put
			       ov 'modification-hooks
			       (list 'org-display-inline-remove-overlay))
			      (overlay-put ov 'keymap image-map)
			      (push ov org-inline-image-overlays))))))))))))))))

(defun my-org-retrieve-image-data-from-url (url)
  (let* ((buf (url-retrieve-synchronously url))
         (res (if buf (with-current-buffer buf (buffer-string))))
         (sep (if res (string-match "\n\n" res)))
         (data (if sep (substring res (+ 2 sep)))))
    (if buf (kill-buffer buf))
    data))



;; (org-http-inline-image-enable)

;; (require 'ox-taskjuggler)

;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "WAIT(w)" "NOTE(n)"  "|" "DONE(d)" "SOMEDAY(s)" "CANCEL(c)")))
