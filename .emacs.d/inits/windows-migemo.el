;;; for migemo
; 24.3 対応のため, ELPA 経由で以下の github 上のものを取得
;   <https://github.com/emacs-jp/migemo>
; (注意: 実際の検索処理はネイティブコードに丸投げなので, 
;        別途 cmigemo または通常の migemo を apt-get しておくこと. 
;        以下は cmigemo 用の設定)
(require 'migemo)
(setq migemo-command "c:/Users/.../AppData/Roaming/.emacs.d/migemo/cmigemo.exe")  ;; FIXME (... に実際のユーザー名を入れるなどして、正しいパスに修正すること)
(setq migemo-options '("-q" "--emacs"))

;; Set your installed path
(setq migemo-dictionary "c:/Users/.../AppData/Roaming/.emacs.d/migemo/dict/utf-8/migemo-dict")   ;; FIXME (... に実際のユーザー名を入れるなどして、正しいパスに修正すること)

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)


;;; for helm-migemo
(require 'helm-migemo)
(add-to-list 'helm-c-source-recentf '(migemo))      ; migemo 対応
(add-to-list 'helm-c-source-bookmarks '(migemo))
(add-to-list 'helm-c-source-yasnippet '(migemo))      ; migemo 対応
