;; filename: kerboscript-mode.el
;; 
;; date:     2014-08-23
;; by:       frosch03

(defun kerboscript-indent-line ()
  "Indent current line as kerboscript code"
  (interactive)
  (beginning-of-line)
  (if (bobp)
      (indent-line-to 0)
    (let ((not-indented t) cur-indent)
        (if (looking-at "^[ \t]*}.")
            (progn
              (save-excursion
                (forward-line -1)
                (setq cur-indent (- (current-indentation) default-tab-width)))
              (if (< cur-indent 0)
                  (setq cur-indent 0)))
        (save-excursion 
          (while not-indented
            (forward-line -1)
            (if (looking-at "^[ \t]*}.")
                (progn
                  (setq cur-indent (current-indentation))
                  (setq not-indented nil))
              (if (looking-at "^[ \t]*\\(if.*{\\|until.*{\\|else.*{\\|for.*{\\|when.*then.*{\\|on.*{\\)")
                  (progn
                    (setq cur-indent (+ (current-indentation) default-tab-width))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))))))
      (if cur-indent
          (indent-line-to cur-indent)
        (indent-line-to 0)))))

(defvar kerboscript-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "RET") 'newline-and-indent)
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for kerboscript major mode")


(setq kos-kwdList
  '("to" "set" "if" "until" "lock" "unlock" "print" "on" "toggle" "wait" "when" "identifier" "stage" "clearscreen" "add" "remove" "log" "break" "preserve" "declare" "switch" "copy" "rename" "delete" "edit" "run" "list" "reboot" "shutdown" "for" "unset" "batch" "deploy")
)

(setq kerboscript-keywords
  `(
    ( ,(regexp-opt kos-kwdList 'words) . font-lock-keyword-face)
    ( ,(regexp-opt '("Pi") 'words)     . font-lock-constant-face)
    )
)

(defun kerboscript-complete-symbol ()
  "Perform keyword completion on word before cursor."
  (interactive)
  (let ((posEnd (point))
        (meat (thing-at-point 'symbol))
        maxMatchResult)

    ;; when nil, set it to empty string, so user can see all lang's keywords.
    ;; if not done, try-completion on nil result lisp error.
    (when (not meat) (setq meat ""))
    (setq maxMatchResult (try-completion meat xyz-kwdList))

    (cond ((eq maxMatchResult t))
          ((null maxMatchResult)
           (message "Can't find completion for %s" meat)
           (ding))
          ((not (string= meat maxMatchResult))
           (delete-region (- posEnd (length meat)) posEnd)
           (insert maxMatchResult))
          (t (message "Making completion list...")
             (with-output-to-temp-buffer "*Completions*"
               (display-completion-list 
                (all-completions meat kos-kwdList)
                meat))
             (message "Making completion list...%s" "done")))
    )
  )
(define-derived-mode kerboscript-mode prog-mode "KerboScript script"
  "KerboScript mode is a major mode for editing kOS files"
  
  (setq font-lock-defaults '(kerboscript-keywords t t))
  (setq mode-name "kerboscript-mode")

  ;; when there's an override, use it
  ;; otherwise it gets the default value
  (setq tab-width 2)
  (set (make-local-variable 'indent-line-function) 'kerboscript-indent-line)    
  (set (make-local-variable 'font-lock-keywords-case-fold-search) t)
  ;; (setq font-lock-keywords-case-fold-search t)
  ;; (put 'kerboscript-mode 'font-lock-keywords-case-fold-search t)
  (modify-syntax-entry ?\/ ". 12b" kerboscript-mode-syntax-table)
  (modify-syntax-entry ?\n "> b" kerboscript-mode-syntax-table)
  )

(provide 'kerboscript-mode)
