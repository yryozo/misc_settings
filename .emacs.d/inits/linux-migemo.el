;;; for migemo
; 24.3 対応のため, ELPA 経由で以下の github 上のものを取得
;   <https://github.com/emacs-jp/migemo>
; (注意: 実際の検索処理はネイティブコードに丸投げなので, 
;        別途 cmigemo または通常の migemo を apt-get しておくこと. 
;        以下は cmigemo 用の設定)
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

;; Set your installed path
;(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)

;; 以下は昔の設定
					; (setq load-path (cons "/usr/share/emacs/site-lisp/migemo" load-path))
					; (load "migemo.el")
					; 
;; for C/Migemo
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
;; (setq migemo-dictionary "somewhere/migemo/euc-jp/migemo-dict")
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)


;;; for helm-migemo
;;;   for helm-migemo-mode
; <http://qiita.com/ballforest/items/4db3d66df16d84a027d0>
; <https://github.com/emacs-helm/helm/wiki#use-migemo-in-helm>
; (you have to install migemo.el and ensure it is configured properly)
; helm-migemo-mode will activate migemo support in the following features:
;     kill ring
;     (m)occur
;     buffers
;     helm-find-files (One space after a current path is needed to get candidates via migemo.)
;     Files in current directory
;     file name history (C-c h in helm-find-files)
;     recentf
;     minibuffer history
;     bookmarks
;     filtered bookmarks

; (helm-migemo-mode 1)   ; yasnippet とかで使えるようになったら ON にするか

;;;   for helm-migemo
; <https://github.com/emacs-helm/helm/wiki#use-migemo-in-helm>
; deprecated らしい. どこかのタイミングで helm-migemo-mode に乗り換えないと. #TODO
;   "NOTE: You will find in MELPA helm-migemo.el, this package is deprecated and not supported by helm, please do not use it. "
(require 'helm-migemo)
(add-to-list 'helm-c-source-recentf '(migemo))      ; migemo 対応
;(add-to-list 'helm-c-source-buffers-list '(migemo)) ; migemo 対応
(add-to-list 'helm-c-source-bookmarks '(migemo))

(add-to-list 'helm-source-yasnippet '(migemo))      ; migemo 対応
