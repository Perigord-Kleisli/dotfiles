
(setq user-full-name "Trouble Truffle"
      user-mail-address "perigordtruffle7318@gmail.com")

(setq centaur-tabs-style "slant")
(setq centaur-tabs-set-close-button nil)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-set-bar 'under)
(setq x-underline-at-descent-line t)

(setq doom-theme 'doom-dracula)
(setq org-directory "~/Org/")

(set-face-background 'vertical-border "DarkSlateGrey")
(set-face-foreground 'vertical-border (face-background 'vertical-border))

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))
;; (setq doom-font (font-spec :family "Hasklig" :size 14 ))
;;
(setq display-line-numbers-type `relative)
(setq confirm-kill-emacs `nil)
(setq auto-save-default t
      make-backup-files t)

(global-whitespace-mode)

(setq evil-collection-setup-minibuffer t)
(setq select-enable-clipboard nil)

(map! :desc "Toggle Neotree"
      :n "SPC o M-p" #'neotree-toggle)
(map! :desc "Buffer Groups"
      :n "g C-t" #'centaur-tabs--groups-menu)
(map! :desc "Kill Buffer"
      :n "g C-x C-t" #'centaur-tabs--kill-this-buffer-dont-ask)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#636363")))))

(let
    ((ligatures `((?-  . ,(regexp-opt '("-|" "-~" "---" "-<<" "-<" "--" "->" "->>" "-->")))
                   (?/  . ,(regexp-opt '("/**" "/*" "///" "/=" "/==" "/>" "//")))
                   (?*  . ,(regexp-opt '("*>" "***" "*/")))
                   (?<  . ,(regexp-opt '("<-" "<<-" "<=>" "<=" "<|" "<||" "<|||::=" "<|>" "<:" "<>" "<-<"
                                         "<<<" "<==" "<<=" "<=<" "<==>" "<-|" "<<" "<~>" "<=|" "<~~" "<~"
                                         "<$>" "<$" "<+>" "<+" "</>" "</" "<*" "<*>" "<->" "<!--")))
                   (?:  . ,(regexp-opt '(":>" ":<" ":::" "::" ":?" ":?>" ":=")))
                   (?=  . ,(regexp-opt '("=>>" "==>" "=/=" "=!=" "=>" "===" "=:=" "==")))
                   (?!  . ,(regexp-opt '("!==" "!!" "!=")))
                   (?>  . ,(regexp-opt '(">]" ">:" ">>-" ">>=" ">=>" ">>>" ">-" ">=")))
                   (?&  . ,(regexp-opt '("&&&" "&&")))
                   (?|  . ,(regexp-opt '("|||>" "||>" "|>" "|]" "|}" "|=>" "|->" "|=" "||-" "|-" "||=" "||")))
                   (?.  . ,(regexp-opt '(".." ".?" ".=" ".-" "..<" "...")))
                   (?+  . ,(regexp-opt '("+++" "+>" "++")))
                   (?\[ . ,(regexp-opt '("[||]" "[<" "[|")))
                   (?\{ . ,(regexp-opt '("{|")))
                   (?\? . ,(regexp-opt '("??" "?." "?=" "?:")))
                   (?#  . ,(regexp-opt '("####" "###" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" "##")))
                   (?\; . ,(regexp-opt '(";;")))
                   (?_  . ,(regexp-opt '("_|_" "__")))
                   (?\\ . ,(regexp-opt '("\\" "\\/")))
                   (?~  . ,(regexp-opt '("~~" "~~>" "~>" "~=" "~-" "~@")))
                   (?$  . ,(regexp-opt '("$>")))
                   (?^  . ,(regexp-opt '("^=")))
                   (?\] . ,(regexp-opt '("]#"))))))
  (dolist (char-regexp ligatures)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9])))

;; (use-package! wakatime-mode
;; :hook (after-init . global-wakatime-mode))

(setq epg-gpg-program "gpg2")
;; use org-bullets-mode for utf8 symbols as org bullets
(set-frame-parameter (selected-frame) 'alpha '(95 . 90))
(add-to-list 'default-frame-alist '(alpha . (95 . 90)))

;(require 'gnu-apl-mode)
(require 'company)
(setq company-idle-delay 0.5
      company-minimum-prefix-length 2)
(setq company-show-quick-access t)

(setq haskell-mode-stylish-haskell-path "hlint")

(use-package lsp-haskell
 :ensure t
 :config
 (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
)

(setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(setq org-latex-compiler "xelatex")
(setq org-latex-pdf-process
      (list (concat "latexmk -"
                    org-latex-compiler 
                    " -recorder -synctex=1 -bibtex-cond %b")))
(setq org-latex-listings t)
(setq org-latex-default-packages-alist
      '(("" "graphicx" t)
        ("" "grffile" t)
        ("" "longtable" nil)
        ("" "wrapfig" nil)
        ("" "rotating" nil)
        ("normalem" "ulem" t)
        ("" "amsmath" t)
        ("" "textcomp" t)
        ("" "amssymb" t)
        ("" "capt-of" nil)
        ("" "hyperref" nil)))


(setq org-latex-classes
    '(("article"
       "\\RequirePackage{fix-cm}
        \\PassOptionsToPackage{svgnames}{xcolor}
        \\documentclass[11pt]{article}
        \\usepackage{fontspec}
        \\setmainfont{ETBembo}
        \\usepackage{sectsty}
        \\allsectionsfont{\\sffamily}
        \\usepackage{enumitem}
        \\setlist[description]{style=unboxed,font=\\sffamily\\bfseries}
        \\usepackage{listings}
        \\lstset{frame=single,aboveskip=1em,
          framesep=.5em,backgroundcolor=\\color{AliceBlue},
          rulecolor=\\color{LightSteelBlue},framerule=1pt}
        \\usepackage{xcolor}
        \\newcommand\\basicdefault[1]{\\scriptsize\\color{Black}\\ttfamily#1}
        \\lstset{basicstyle=\\basicdefault{\\spaceskip1em}}
        \\lstset{literate=
                 {§}{{\\S}}1
                 {©}{{\\raisebox{.125ex}{\\copyright}\\enspace}}1
                 {«}{{\\guillemotleft}}1
                 {»}{{\\guillemotright}}1
                 {Á}{{\\'A}}1
                 {Ä}{{\\\"A}}1
                 {É}{{\\'E}}1
                 {Í}{{\\'I}}1
                 {Ó}{{\\'O}}1
                 {Ö}{{\\\"O}}1
                 {Ú}{{\\'U}}1
                 {Ü}{{\\\"U}}1
                 {ß}{{\\ss}}2
                 {à}{{\\`a}}1
                 {á}{{\\'a}}1
                 {ä}{{\\\"a}}1
                 {é}{{\\'e}}1
                 {í}{{\\'i}}1
                 {ó}{{\\'o}}1
                 {ö}{{\\\"o}}1
                 {ú}{{\\'u}}1
                 {ü}{{\\\"u}}1
                 {¹}{{\\textsuperscript1}}1
                  {²}{{\\textsuperscript2}}1
                  {³}{{\\textsuperscript3}}1
                 {ı}{{\\i}}1
                 {—}{{---}}1
                 {’}{{'}}1
                 {…}{{\\dots}}1
                    {⮠}{{$\\hookleftarrow$}}1
                 {␣}{{\\textvisiblespace}}1,
                 keywordstyle=\\color{DarkGreen}\\bfseries,
                 identifierstyle=\\color{DarkRed},
                 commentstyle=\\color{Gray}\\upshape,
                 stringstyle=\\color{DarkBlue}\\upshape,
                 emphstyle=\\color{Chocolate}\\upshape,
                 showstringspaces=false,
                 columns=fullflexible,
                 keepspaces=true}
        \\usepackage[a4paper,margin=1in,left=1.5in]{geometry}
        \\usepackage{parskip}
        \\makeatletter
        \\renewcommand{\\maketitle}{%
          \\begingroup\\parindent0pt
          \\sffamily
          \\Huge{\\bfseries\\@title}\\par\\bigskip
          \\LARGE{\\bfseries\\@author}\\par\\medskip
          \\normalsize\\@date\\par\\bigskip
          \\endgroup\\@afterindentfalse\\@afterheading}
        \\makeatother
        [DEFAULT-PACKAGES]
        \\hypersetup{linkcolor=Blue,urlcolor=DarkBlue,
          citecolor=DarkRed,colorlinks=true}
        \\AtBeginDocument{\\renewcommand{\\UrlFont}{\\ttfamily}}
        [PACKAGES]
        [EXTRA]"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
        ("\\paragraph{%s}" . "\\paragraph*{%s}")
        ("\\subparagraph{%s}" . "\\subparagraph*{%s}")

        ("report" "\\documentclass[11pt]{report}")
        ("\\part{%s}" . "\\part*{%s}")
        ("\\chapter{%s}" . "\\chapter*{%s}")
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")

        ("book" "\\documentclass[11pt]{book}")
        ("\\part{%s}" . "\\part*{%s}")
        ("\\chapter{%s}" . "\\chapter*{%s}")
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(add-hook! 'haskell-mode-hook
        (use-package dante)
        :ensure t
        :after haskell-mode
        :commands 'dante-mode
        :init
        (add-hook! 'haskell-mode-hook 'flycheck-mode)
        (add-hook! 'haskell-mode-hook 'dante-mode))
        
)
(setq haskell-process-type 'ghci)
(add-hook! 'haskell-mode-hook (dante-mode))
(add-hook! 'haskell-mode-hook
        (map! :desc "run Repl"
              :n "<f2>" (cmd! (shell-command "cabal repl")))
)
(setq! evil-ex-substitute-global t)
(defvar +ligatures-extra-symbols
  '("/=" "!="))

(map! :desc "unhighlight"
      :n "C-l" #'evil-ex-nohighlight)
(map! :desc "Run"
      :n "<f2>" (cmd! (shell-command buffer-file-name )))
(require 'ob-haskell)
(add-hook! `c-or-c++-mode
        (map! :desc "Make")
        :n "<f2>" #'+make/run)


;(setq! default-input-method "APL-Z")
(setq lsp-auto-guess-root t)
(rainbow-delimiters-mode)
(rainbow-mode)
(minimap-mode)
(global-prettify-symbols-mode)
(global-auto-composition-mode t)




