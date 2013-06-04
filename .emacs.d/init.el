;;; for ELPA
;;=========================================
(if (>= emacs-major-version 24)
    (progn
      (require 'package)
      (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
      (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
      (package-initialize)))


;;; for load-path
(setq load-path (cons (expand-file-name "~/.emacs.d/elisp") load-path))


;;; for init-loader
;;=========================================
;; <http://tech.kayac.com/archive/divide-dot-emacs.html>
;; 指定したディレクトリ内のelファイルを読み込んでくれるelisp.
;; ファイル名を見て環境（meadowやcarbon-emacs、windowシステムかどうかなど）に合わせて読み込んでくれたり、 
;; エラーのあるファイルはスルーしてくれたりして、単純に.emacsから設定ファイルを読み込むより便利です。
;; 
;;  * ファイル名がmeadowで始まるファイルはmeadowだけで読み込む
;;  * ファイル名がcarbon-emacsで始まるファイルはcarbon-emacsだけで読み込む
;;  * ファイル名がnwで始まるファイルは非ウィンドウシステムでのみ読み込む

;; 設定ファイルは ~/.emacs.d/inits 以下に配置 (init-loader.el によって自動的に読み込まれる)
;; (なお, 以下の設定は ~/.emacs.d/init.el に書いておいてもいい模様)
(if (>= emacs-major-version 24)
    (progn
      (require 'init-loader)
      (init-loader-load "~/.emacs.d/inits") ; デフォルト値は init-loader-directory 変数の値 (= ~/.emacs.d/inits)
      ))

;; エラーが起きたときにどのファイルにエラーがあるか分かるようにする
;; <http://d.hatena.ne.jp/kitokitoki/20101205/p1>
(defun init-loader-re-load (re dir &optional sort)
  (let ((load-path (cons dir load-path)))
    (dolist (el (init-loader--re-load-files re dir sort))
      (condition-case e
          (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
            (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
        (error
         ;; (init-loader-error-log (error-message-string e)) ；削除
         (init-loader-error-log (format "%s. %s" (locate-library el) (error-message-string e))) ;追加
         )))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (< emacs-major-version 24)
    (progn
      (setq init-file "~/.emacs.d/inits/00-util.el")
      (load init-file)))
