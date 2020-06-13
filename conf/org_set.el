(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(require 'ox-latex)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-latex-default-class "bxjsarticle")

(add-to-list 'org-latex-classes
             '("koma-article"
               "\\documentclass{scrartcl}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("koma-jarticle"
               "\\documentclass{scrartcl}
               \\usepackage{amsmath}
               \\usepackage{amssymb}
               \\usepackage{xunicode}
               \\usepackage{fixltx2e}
               \\usepackage{zxjatype}
               \\usepackage[hiragino-dx]{zxjafont}
               \\usepackage{xltxtra}
               \\usepackage{graphicx}
               \\usepackage{longtable}
               \\usepackage{float}
               \\usepackage{wrapfig}
               \\usepackage{soul}
               \\usepackage{hyperref}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; tufte-handout class for writing classy handouts and papers
(add-to-list 'org-latex-classes
             '("tufte-handout"
               "\\documentclass[twoside,nobib]{tufte-handout}
                                 [NO-DEFAULT-PACKAGES]
                \\usepackage{zxjatype}
                \\usepackage[hiragino-dx]{zxjafont}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")))
;; tufte-book class
(add-to-list 'org-latex-classes
             '("tufte-book"
               "\\documentclass[twoside,nobib]{tufte-book}
                                [NO-DEFAULT-PACKAGES]
                 \\usepackage{zxjatype}
                 \\usepackage[hiragino-dx]{zxjafont}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))

(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "xelatex -interaction nontopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))
