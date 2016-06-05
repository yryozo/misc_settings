;;; for helm
;;;   for helm-filelist
;; <http://d.hatena.ne.jp/rubikitch/20100915/anything>
;; <http://d.hatena.ne.jp/higepon/20120219/1329636071>
;; <http://d.hatena.ne.jp/yuheiomori0718/20120207/1328620261>
;; helm-source-locate のようなもの. ただし, 複数クエリでのマッチが出来る.
;; 
;; 辞書を作るために, 予め make-filelist.rb を回しておく必要がある.
;; 探索範囲は ~/.make-filelist.rb でカスタマイズ可能. 
;;   (あるいは, make-filelist.rb にコマンドライン引数を渡すと, そこだけが探索される
;;    $ ruby make-filelist.rb ~ /etc > ~/partial.filelist   )
;; 
;; make-filelist.rb は cron で定期的に回しておくとよい. 以下は 11:30 に実行する設定
;; (root でやれ, と書かれてたりするが, 自分が開けるファイルでないと意味が無いから自分でいいだろう)
;;   30 11 * * * ruby ~/.emacs.d/bin/make-filelist.rb > /tmp/all.filelist
;; 
;; <http://d.hatena.ne.jp/mtym/20130322/p1>
;; helm 版は公式にはないが, ここのページで公開されている.
(require 'helm-filelist)
; (setq helm-filelist-file-name "/tmp/all.filelist")  ; 使用する filelist ファイル
; (setq helm-filelist-candidate-number-limit 200)     ; 表示する候補数
; (setq helm-filelist-grep-command "LANG=C grep")     ; 使用する grep コマンド
(setq helm-filelist-case-fold-search nil)           ; 大文字／小文字を無視するかどうか? t や 'smart だと無視する. nil だと無視しない (現状だと無視しないと遅すぎるな...)

;; 何か, defvar ではなく defun で定義されているので, 中身を取り出しておく (defvar でいいと思うんだがなぁ...)
(setq helm-c-source-filelist (helm-source-filelist))

