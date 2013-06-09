;; Note -- Tested On:
;;    GNU Emacs 24.1.1 (x86_64-apple-darwin, NS apple-appkit-1038.36)

;; ===================================================
;; Some Very General Stuff from Customization Menu
;; ===================================================
(custom-set-variables
 '(font-lock-verbose t)
 '(gud-gdb-command-name "gdb --annotate=1")

 ;; I don't care about the startup screen. Wastes LITERALLY seconds.
 '(inhibit-startup-screen t)

 '(initial-scratch-message nil)
 '(large-file-warning-threshold nil)

 ;; Large Number ==> Don't try to compensate for scrolling through buffer fast
 '(scroll-conservatively 1000)
)

;; ===================================================
;; General Text-Formatting Stuff
;; ===================================================
;; Only Affects X11 Window Emacs (i.e. not "emacs -nw" mode )
(set-frame-font "-outline-Courier New-normal-normal-normal-mono-12-*-*-*-c-*-iso8859-1")
;; Word Wrapping in Text mode
(add-hook 'text-mode-hook 'visual-line-mode)
;; Word Wrapping in LaTeX Mode
(add-hook 'latex-mode-hook 'visual-line-mode)

;; Font lock stuff
;; ---------------
;; Turn on font-lock
(global-font-lock-mode 1)
;; Change global comment color to red
(custom-set-faces
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(font-lock-keyword-face ((t (:foreground "magenta" :bold t)))) )


;; ===================================================
;; Some Better LaTeX Colors for Terminal Version of Emacs
;; ===================================================
(define-derived-mode latex-term-mode latex-mode
   (setq mode-name "Terminal-LaTeX")
   ;; Custom Faces for LaTeX-Mode
   ;; -------------------------------------------
   ;; Definition of LaTeX Keyword Face
   (make-face 'latex-keyword-face )
   (set-face-attribute 'latex-keyword-face nil :foreground "blue" :bold t)
   ;; Definition of LaTeX Builtin Face
   (make-face 'latex-builtin-face)
   (set-face-attribute 'latex-builtin-face nil :foreground "magenta" :bold nil)
   ;; Constant Face
   (make-face 'latex-constant-face)
   (set-face-attribute 'latex-constant-face nil :foreground "cyan" :bold nil)
   ;; Function-Name Face
   (make-face 'latex-function-name-face)
   ;(set-face-attribute 'latex-function-name-face nil :foreground "blue" :bold nil :background "white")
   (set-face-attribute 'latex-function-name-face nil :foreground "black" :bold t )

   ;; Keyword Color (e.g. \section{} )
   (set (make-local-variable 'font-lock-keyword-face) 'latex-keyword-face)
   ;; Builtin Color (e.g. package names)
   (set (make-local-variable 'font-lock-builtin-face) 'latex-builtin-face)
   ;; Constant (e.g. label names)
   (set (make-local-variable 'font-lock-constant-face) 'latex-constant-face)
   ;; Function-Name Name (e.g. section names)
   (set (make-local-variable 'font-lock-function-name-face) 'latex-function-name-face)
)

;; Add Hook with Conditional
;; -------------------------
(add-hook 'latex-mode-hook 
;(add-hook 'tex-mode-hook 
  '(lambda () 
     (if (not window-system) (latex-term-mode))
   )
)


;; =======================================================================
;; Custom LaTeX Mode for X11 Version of Emacs -- Better-Looking Colors!
;; =======================================================================

;; ------------------------------------------------------
;; Define Mode -- Use Colors Better for X11 Window
;; ------------------------------------------------------
;(define-derived-mode latex-window-mode tex-mode
(define-derived-mode latex-window-mode latex-mode
   (setq mode-name "Windowed-LaTeX")

   ;; New Face Definitions
   ;; ------------------------------
   ;; Keywords -- e.g. \section{}
   (make-face 'lw-keyword-face )
   (set-face-attribute 'lw-keyword-face nil :foreground "blue" :bold t)
   ;; Comments
   (make-face 'lw-comment-face )
   (set-face-attribute 'lw-comment-face nil :foreground "firebrick1" :bold nil)
   ;; Builtin -- e.g. package names
   (make-face 'lw-builtin-face )
   ;(set-face-attribute 'lw-builtin-face nil :foreground "navy" :background "white" :bold t)
   (set-face-attribute 'lw-builtin-face nil :foreground "magenta" :bold nil)
   ;; String -- Also Sets Propertis of Text inside Math Expressions
   (make-face 'lw-string-face )
   (set-face-attribute 'lw-string-face nil :foreground "ForestGreen" :bold nil)
   ;; Function-Name -- e.g. Text inside of \section{} definitions
   (make-face 'lw-function-name-face )
   (set-face-attribute 'lw-function-name-face nil :foreground "dark orange" :bold t)

   ;; Set New Fact Definitions
   ;; ------------------------
   ;; Setting as Local Variables Keeps Definitions from Affecting Other Buffers
   (set (make-local-variable 'font-lock-keyword-face) 'lw-keyword-face)
   (set (make-local-variable 'font-lock-comment-face) 'lw-comment-face)
   (set (make-local-variable 'font-lock-builtin-face) 'lw-builtin-face)
   (set (make-local-variable 'font-lock-string-face) 'lw-string-face)
   (set (make-local-variable 'tex-math-face) 'lw-string-face)
   (set (make-local-variable 'font-lock-function-name-face) 'lw-function-name-face)
)

;; -----------------------------------------------------------------
;; Run Mode for TeX Files -- But Only if Window != Terminal
;; -----------------------------------------------------------------
;; latex-window-mode
(add-hook 'latex-mode-hook 
   '(lambda () 
      (cond (window-system (latex-window-mode)))
    )
)
