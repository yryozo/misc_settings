(defun helm-candidates-from-my-template (fpath)
  "Create helm candidates' strings from a file splitted by form feed"
  (with-temp-buffer 
    (insert-file-contents fpath nil nil nil t)
    ;; process it ...
    ;; (goto-char 0) ; move to begining of file's content (in case it was open)
    ;; ... do something here
    ;; (write-file fpath) ;; write back to the file
    
    ;; split the buffer by form feed
    (split-string 
     (buffer-string) ; return the buffer's contents as a string
     "\f\n")
    )
  )

(defvar helm-my-template-file (locate-user-emacs-file "my_template"))

(defvar helm-c-source-from-my-template
  '((name . "Code dictionary")
    (candidates . (lambda () (helm-candidates-from-my-template helm-my-template-file)))
    (action ("Insert" . yas-expand-snippet))
					;(action ("Insert" . insert))
    (multiline)
    (migemo)))
					;(helm-other-buffer '(helm-c-source-from-my-template) "*helm my completion*")

(defun helm-my-text-completion ()
  (interactive)
  (helm-other-buffer '(helm-c-source-yasnippet
					;helm-c-source-code-dictionary
		       helm-c-source-from-my-template
		       )
		     "*helm my completion*"))

; 作ったコマンドをショートカットキーに登録
;(define-key my-mode-map (kbd "C-c y") 'helm-my-text-completion)
(global-set-key (kbd "C-c y") 'helm-my-text-completion)
