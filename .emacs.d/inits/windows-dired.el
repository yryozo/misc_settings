;;; 日本語ファイル名の表示
; Windows ではファイル名が Shift-JIS なので、設定しておく必要がある.
; <http://hiro2.jp/2006-06-14-3.html>
(setq default-file-name-coding-system 'japanese-shift-jis-dos)

;;; dired からの Windows アプリケーションの起動
;;;; w32-browser
; <http://www.emacswiki.org/emacs/DiredPlus#w32-browser>
(require 'w32-browser)

(define-key dired-mode-map (kbd "M-RET") 'dired-w32-browser)
(define-key dired-mode-map [mouse-2] 'dired-w32-browser)
(define-key dired-mode-map (kbd "C-RET") 'dired-w32explore)


;;;; w32-shell-execute
; (defun dired-custom-execute-file (&optional arg)
;   (interactive "P")
;   (mapcar #'(lambda (file)
;  	      (w32-shell-execute "open" (convert-standard-filename file)))
;  	  (dired-get-marked-files nil arg)))
;  
; (defun dired-custom-dired-mode-hook ()
;   (define-key dired-mode-map "X" 'dired-custom-execute-file))
; (add-hook 'dired-mode-hook 'dired-custom-dired-mode-hook)
