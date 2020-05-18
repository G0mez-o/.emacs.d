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
(setq org-latex-pdf-process '("lualatex %b" "lualatex %b"))
