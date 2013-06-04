;;; boiled-canna.el
;;; Copyright 1996, 1997, 1998 Kaoru Nakajima

;;; 本プログラムはフリー・プログラムです。あなたは、Free Software
;;; Foundation が公表した GNU 一般公有使用許諾の「バージョン２」或はそれ
;;; 以降の各バージョンの中からいずれかを選択し、そのバージョンが定める条項に
;;; 従って本プログラムを再配布または変更することができます。

;;; 本プログラムは有用とは思いますが、配布にあたっては、市場性及び特定目的
;;; 適合性についての暗黙の保証を含めて、いかなる保証も行いません。詳細に
;;; ついては GNU 一般公有使用許諾書をお読み下さい。

;;; あなたは、本プログラムと一緒に GNU 一般公有使用許諾の写しを受け取って
;;; いるはずです。そうでない場合は、Free Software Fundation, Inc., 675 Mass
;;; Ave, Cambridge, MA 02139, USA へ手紙を書いて下さい。

;;; 作者への連絡は以下へお願いします。
;;; E-mail: knak@ceres.dti.ne.jp

;;;
;;;  boiled-canna 使用上の注意
;;;
;;;   mule-2.3 + X11R6 + Canna3.2 で開発したので
;;;   それ以外の環境で動かないかも知れません
;;;   mule-2.3(19.30) では問題無く動きます。
;;;
;;;   なお、nemacs では、絶対動きません。将来も対応はしないでしょう。
;;;   mule-1.x も、危ないかも知れない
;;;   何せよ canna-rk-trans-region が無い emacs では動きません
;;;
;;;   minor mode 化後の対応状況
;;;
;;;    emacs-20.2+canna
;;;    emacs-20.3+canna
;;;    mule(based emacs-19.34)
;;;
;;;   誰か以下の emacs で確認してくんないかなぁ
;;;   Linux で mule を make するのが面倒臭くていけねぇや
;;;
;;;    mule(based emacs-19.28)
;;;    mule(based emacs-19.30)
;;;    xemacs-20.x
;;;
;;;
;;;   canna 対応である事が大前提
;;;   その上で canna を初期化してから
;;;   このファイルをロードする事
;;;
;;;
;;;  boiled-canna の機能および方針
;;;
;;;   0. boiled-egg の操作感をなるべく再現する
;;;   1. 記号も変換対象にする
;;;   2. 漢字変換中に C-g したら変換前の状態に戻すようにする
;;;   3. 変換確定直後なら再変換できるようにする
;;;   4. boiled-egg の rRkh-trans とか rhkR-trans には対応しない
;;;   5. canna の字種変換は使えるようにする
;;;   6. 漢字/字種変換中に文字を入力したら確定して fence-mode から抜ける
;;;   7. C-g でローマ字に戻す時に読みの変更が反映されるようにする
;;;   8. region を指定する事によって変換範囲を指定可能とする
;;;
;;;
;;;  boiled-canna の key bind
;;;
;;;   基本的には以下の通り
;;;     非fence-mode C-j         ==> 変換
;;;       fence-mode C-g         ==> 変換前の状態
;;;       fence-mode [!-~]       ==> 変換確定 + 文字入力
;;;   後の key は canna の key bind がそのまま利用できる
;;;

;;; 3.9.3 1998.10.8
;;;   o boiled-canna-rK-trans-key に [\henkan] のような
;;;     vector を登録された時でも再変換がかかるように条件判定を変更
;;;
;;; 3.9.2 1998.10.7
;;;   o boiled-canna-rK-trans-key の追加
;;;   o boiled-canna-preload-hook の追加
;;;   o C-j で、変換したくない人は boiled-canna をロードする前に
;;;     (add-hook 'boiled-canna-preload-hook
;;;       (function (lambda () (setq boiled-canna-rK-trans-key "\C-\\"))))
;;;     とかやれば良い
;;;
;;; 3.9.1 1998.10.6
;;;   o boiled-canna-select-mode-map と boiled-canna-face-mode-map を
;;;     使うのを止めて従来通り canna-mode-map と canna-minibuffer-mode-map を
;;;     使うように変更した
;;;
;;; 3.9.0 1998.10.1
;;;   o minor mode 化
;;;   o beta test 中
;;;
;;; 3.6 1998.9.22
;;;   o mew-1.93/patches/canna-19.34 を当てた
;;;     canna.el でも使えるようにする対処
;;;     boiled-canna-minibuffer-henkan-kakutei-and-self-insert で
;;;     canna:*minibuffer-local-map-backup* が無かった時の処理追加
;;;
;;; 3.5 1998.9.1
;;;   o canna 3.5 だと何故か boiled-canna-cancel 中の
;;;     (canna-do-function canna-func-kill-to-end-of-line)
;;;     で頭の１文字残るのでその対処
;;;
;;; 3.4 1997.12.11
;;;   o boiled-canna-minibuffer-henkan-kakutei-and-self-insert の修正
;;;     変換候補一覧表示中以外の minibuffer で
;;;     (M-x canna-touroku-region の読みの入力)
;;;     キーが入力されずに無限ループに入ったかのような動作をすることへの対処
;;;   o 読みを修正した後に変換キャンセルでローマ字に変更が反映されるようにした
;;;     (デグレードを起こしていた機能がやっと使えるようになった とも言う)
;;;
;;; 3.3 1997.11.28
;;;   o boiled-canna-minibuffer-henkan-kakutei-and-self-insert の追加
;;;     変換候補一覧表示中に数字以外の文字を入力した時に
;;;     fence-mode で入力されるバグの対処
;;;
;;; 3.2 1997.11.06
;;;   o char-category ⇒ char-charset に変換
;;;
;;; 3.1 1997.11.01
;;;   o 変換中のキャンセルでローマ字が戻るように修正
;;;     boiled-canna-cancel-or-kakutei-romaji の boiled-canna-undo を
;;;     パラメータ無しにしたら直った
;;;   o 20.2 と 19.34 での動作実績は取った
;;;     19.28 と XEmacs 20.x はどうなるか不明です
;;;
;;; 3.0 1997.10.29
;;;   o emacs-20.2 + canna への対応
;;;   o canna-undo が使えなくなったので、再変換処理を自分で実装した
;;;   o string-to-char-list ⇒ string-to-list へ変更
;;;   o string-memq ⇒ memq へ変更 
;;;   o char-category ⇒ char-charset へ変更
;;;     これに伴いちょっとデグレード:
;;;     全角文字の変換処理が[あ-んア-ン０-９]になった
;;;   o 変換中のキャンセルでローマ字が戻らなくなった。オイオイ
;;;
;;; 2.4	1996.06.27
;;;     半角SPC を変換するバグ対処
;;;	半角アルファベットを変換する場合に
;;;	boiled-canna:stop-char に指定した文字列を変換対象としない
;;;
;;; 2.3 1996.04.16
;;;	各関数への説明の付与
;;;	quote していた部分を function に変更
;;;
;;; 2.2 1995.11.16
;;;	undo 後の挙動不審の為、boiled-canna-undo を追加した
;;;
;;; 2.1 1995.11.03
;;;	処理の軽量化
;;;
;;; 2.0 1995.11.02
;;;	fence-mode にいる時でも、
;;;	mode-line-canna-mode が "[ あ ]" になっていたら
;;;	文字を入力できるようにする
;;;
;;;	読みに変更があり、かつ、 C-g した時に
;;;	その変更を吸収したローマ字を戻すようにする
;;;
;;;	上記変更に伴い、C-h / C-? / delete への
;;;	C-g 機能の割り当ては取り止めた
;;;	加えて、再変換時の C-g は
;;;	boiled-egg と同様に、ローマ字が戻るようになった
;;;	そんなつもりは無かったけど、まぁ良しとしよう (^^;
;;;
;;; 1.4 1995.10.30
;;;	C-h / C-? / delete に C-g の機能を割り当てる
;;;
;;;	~/.canna に (global-set-key "\C-j" 'next) が無くても
;;;	fence-mode 中では次候補となるようにした
;;;
;;; 1.3 1995.10.24
;;;	undo の区切り変更
;;;	たいした事はやってないけど
;;;	変換中に入力された文字は
;;;	次のインタプリタループに処理させるように変更した
;;;
;;; 1.2 1995.10.23
;;;	fence-mode にいる時に文字(\000-\040以外)が入力されたら
;;;	変換中の文字列を確定して、fence-mode を抜け
;;;	入力された文字を buffer に入れるようにする
;;;
;;;	やっぱり、変換中の C-g は一発で変換中止にする
;;;
;;; 1.1 1995.10.22
;;;	C-g の動作を boiled-egg に合わせて canna の機能を一部無効にするべきか
;;;	boiled-egg に合わせずに canna の機能を全て使えるようにするべきか
;;;	判断できないので、双方のインタフェースを入れて
;;;	ユーザが判断できるようにする
;;;
;;; 1.0 1995.10.19
;;;	undo / 再変換 が変なわけ判明
;;;	字種変換中に C-g が押された時に
;;;	canna:quit-canna-mode を行い
;;;	canna:*region-start* と canna:*region-end* を
;;;	破壊していた為
;;;
;;; 0.9 1995.10.16
;;;	確定直後に変換キーを押すと再変換する様にする
;;;
;;; 0.8 1995.10.14
;;;	変換中に C-g を押した時に、変換前の状態に戻す
;;;	undo / 再変換 が変かも知れない
;;;
;;; 0.7 1995.06.11
;;;	{\ca+|\ck+|[\cS\cA\cH\cK]+} (<-- mule で対応している正規表現)
;;;	上で示される文字列を変換する機能を付加する

(require 'canna)
(canna)

(defvar boiled-canna-rK-trans-key "\C-j")
(run-hooks 'boiled-canna-preload-hook)

(global-set-key "\C-o" 'open-line)
(global-set-key "\C-\\" 'canna-toggle-japanese-mode)

(defvar boiled-canna-toggle-buffer nil
  "boiled-canna を toggle するレベルを設定する.
非nil の時、buffer 単位.
nil の時、全ての buffer 単位")

(defvar boiled-canna-mode nil)
(or (assq 'boiled-canna-mode minor-mode-alist)
    (setq minor-mode-alist
	  (cons '(boiled-canna-mode " BC") minor-mode-alist)))

(defvar boiled-canna-mode-map (make-sparse-keymap))
(define-key boiled-canna-mode-map boiled-canna-rK-trans-key
  'boiled-canna-rK-trans)
(or (assq 'boiled-canna-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
;	  (append minor-mode-map-alist
;		  (list (cons 'boiled-canna-mode boiled-canna-mode-map)))))
	  (cons (cons 'boiled-canna-mode boiled-canna-mode-map)
		minor-mode-map-alist)))

;(defvar boiled-canna-fence-mode nil)
;(defvar boiled-canna-fence-mode-map (make-sparse-keymap))
;(define-key boiled-canna-fence-mode-map "\C-g" 'boiled-canna-keyboard-quit)
;(define-key boiled-canna-fence-mode-map boiled-canna-rK-trans-key
;  'boiled-canna-next)
;(define-key boiled-canna-fence-mode-map "\C-m" 'boiled-canna-func-kakutei)
(define-key canna-mode-map "\C-g" 'boiled-canna-keyboard-quit)
(let ((ch (1+ ?\ ))) ; "?\ "
  (while (< ch 127)
;    (define-key boiled-canna-fence-mode-map (char-to-string ch)
(define-key canna-mode-map (char-to-string ch)
      'boiled-canna-kakutei-self-insert)
    (setq ch (1+ ch))))
;(or (assq 'boiled-canna-fence-mode minor-mode-map-alist)
;    (setq minor-mode-map-alist
;	  (cons (cons 'boiled-canna-fence-mode boiled-canna-fence-mode-map)
;		minor-mode-map-alist)))

;(defvar boiled-canna-select-mode nil)
;(defvar boiled-canna-select-mode-map (make-sparse-keymap))
;(define-key boiled-canna-select-mode-map "\C-g"
;  (lookup-key canna-minibuffer-mode-map "\C-g"))
;(define-key boiled-canna-select-mode-map "\C-m"
;  (lookup-key canna-minibuffer-mode-map "\C-m"))
;(define-key boiled-canna-select-mode-map boiled-canna-rK-trans-key
;  (lookup-key canna-minibuffer-mode-map boiled-canna-rK-trans-key))
(let ((ch (1+ ?\ )))
  (while (< ch 127)
    (if (or (< ch ?1) (< ?9 ch))
;	(define-key boiled-canna-select-mode-map (char-to-string ch)
	(define-key canna-minibuffer-mode-map (char-to-string ch)
	  'boiled-canna-minibuffer-henkan-kakutei-and-self-insert))
    (setq ch (1+ ch))))
;(or (assq 'boiled-canna-select-mode minor-mode-map-alist)
;    (setq minor-mode-map-alist
;	  (cons (cons 'boiled-canna-select-mode
;		      boiled-canna-select-mode-map)
;		minor-mode-map-alist)))

;(defun boiled-canna-post-command-hook ()
;  (setq boiled-canna-select-mode
;	(or (and canna:*fence-mode* canna:*select-mode*)
;	    (equal (current-local-map) canna-minibuffer-mode-map))))
;(add-hook 'post-command-hook 'boiled-canna-post-command-hook)

(defvar boiled-canna:yomi nil
  "boiled-canna が読みの変更を識別する為の変数

変換対象文字列が設定されるので、ユーザがこの変数を変更してはいけません")

(defvar boiled-canna:stop-char "(){}" ; boiled-egg は (){} を変換対象にしない
  "半角アルファベットを変換する時に変換対象としない文字を文字列として指定する")

(defvar boiled-canna:skip-char nil)

;;; 再変換用の定義
;; この定義が無いと再変換された時に平仮名に戻るだけ
(setq canna-undo-hook
      (function (lambda ()
		  (message "再変換します....")
		  (canna-do-function canna-func-henkan))))
;; なんで add-hook できないんだぁ
;(setq canna-undo-hook nil)
;(add-hook 'canna-undo-hook
;	  (function (lambda ()
;		      (message "再変換します...")
;		      (canna-do-function canna-func-henkan))))



(defun boiled-canna-mode (&optional arg)
  "boiled-canna-mode の起動または停止.
正の引数を伴った場合には強制的にONにする."
  (interactive "P")
  (if (and boiled-canna-toggle-buffer
	   (not (local-variable-p 'boiled-canna-mode)))
      (make-local-variable 'boiled-canna-mode))
  (setq boiled-canna-mode
	(if (null arg) (not boiled-canna-mode)
	  (> (prefix-numeric-value arg) 0)))
  (force-mode-line-update t)
  (if boiled-canna-mode
      (progn
;	(if (not (local-variable-p 'boiled-canna-fence-mode))
;	    (make-local-variable 'boiled-canna-fence-mode))
;	(if (boundp canna:*select-mode*)
;	    (if (not (local-variable-p 'boiled-canna-select-mode))
;		(make-local-variable 'boiled-canna-select-mode)))
	(if (null boiled-canna:skip-char)
	    (boiled-canna:set-skip-char boiled-canna:stop-char))
	(run-hooks 'boiled-canna-mode-hook))))


;;; エントリールーチン
(defun boiled-canna ()
  "boiled-canna の起動"
  (interactive)
  (boiled-canna-mode 1))

(if (eq emacs-major-version 20)
    (defun boiled-canna-char-charset (ch)
      (char-charset ch))
  (defun boiled-canna-char-charset (ch)
    (cond ((equal (char-category ch) "a") 'ascii)
	  ((equal (char-category ch) "k") 'katakana-jisx0201)
	  ((string-match "[SAHK]j" (char-category ch))
	   'japanese-jisx0208)
	  (t nil) )))

(if (null (fboundp 'string-to-list))
    (defun string-to-list (str)
      (string-to-char-list str)) )

;;;
;;; 半角アルファベットを変換する時に
;;; region を作る為に skip する文字列を生成する
;;;
(defun boiled-canna:set-skip-char (stop-char)
  (setq boiled-canna:skip-char
	(let ((i (1+ ?\ ))
	      (chars))
	  (while (< i ?\177)
;	    (if (not (string-memq
;		      (char-to-string i)
;		      (mapcar 'char-to-string
;			      (string-to-char-list stop-char)
;			      (string-to-list stop-char) )))
	    (if (not (memq i (string-to-list stop-char))) ; modified 97.10.23
		(progn
		  (cond ((or (eq i ?\\) (eq i ?-) (eq i ?^))
			 (setq chars (concat chars "\\"))))
		  (setq chars (concat chars (char-to-string i)))))
	    (setq i (1+ i)))
	  chars)))

;;;
;;; canna の次候補 機能の入口関数
;;;
(defun boiled-canna-next ()
  (interactive)
  (canna-do-function canna-func-next)
  (canna:display-candidates 0))


(defun boiled-canna-rK-trans ()
  "漢字変換を開始する (非 fence-mode から fence-mode への mode 遷移)

ポイント以前の文字列を変換対象として漢字変換を行う。
ポイント直前の文字種により以下に示す範囲を変換対象とする。

	ポイント直前の文字種	変換範囲

	半角ｶﾀｶﾅ		行頭方向へ半角ｶﾀｶﾅが続く範囲
	半角文字(ｶﾀｶﾅ以外)	行頭方向へ半角文字(ｶﾀｶﾅ以外)が続く範囲
	全角{ひらがな|		行頭方向へ全角{ひらがな|
	     カタカナ|		               カタカナ|
	     数字|記号}		               数字|記号}が続く範囲

ただし、上述の範囲の中に region が含まれる場合には、region が変換範囲となる。
また、変換確定直後の場合、確定した文字列を再度変換対象とする。

\\{canna-mode-map}
変換中に \\[boiled-canna-keyboard-quit] を入力した場合、
変換を中止しローマ字に戻す。
この時、読みに変更があれば、その変更を反映したローマ字にする。

さらに、変換中に半角{アルファベット|数字|記号}を入力した場合には、
変換を確定し、入力された文字列を buffer に挿入する。


以下は おまけ です。
boiled-canna の fence-mode でのキーバインドを付けてみました。
詳細は canna のドキュメントを参照して下さい。
基本的に canna のデフォルトキーバインドに従っているつもりです。

変換モード	モードライン表示
漢字変換モード	[漢字]

			key		binding
			---		-------

			SPC		次候補
			C-a		先頭文節へ
			C-b		１文節戻る
			C-c		対象文節のみ読み修正
			C-e		最終文節へ
			C-f		１文節進む
			C-g		変換中止
			C-h		読み修正
			TAB		文節縮め
			LFD		次候補
			C-k		読み修正
			C-l		小文字変換
			RET		変換確定
			C-n		次候補
			C-o		文節伸ばし
			C-p		前候補
			C-u		大文字変換
			C-w		候補一覧表示
			! .. ~		変換確定後入力


字種変換モード	[字種]

			key		binding
			---		-------

			SPC		漢字変換
			C-a		先頭文節へ
			C-b		１文節戻る
			C-c		対象文節のみ読み修正
			C-e		最終文節へ
			C-f		１文節進む
			C-g		読み修正
			C-h		読み修正
			TAB		文節縮め
			LFD		次文字種
			C-l		小文字変換
			RET		変換確定
			C-n		次文字種
			C-o		文節伸ばし
			C-p		前文字種
			C-u		大文字変換
			! .. ~		変換確定


読み修正モード	[ あ ]

			key		binding
			---		-------

			SPC		漢字変換
			C-a		読みの先頭へ
			C-b		１文字戻る
			C-d		１文字削除
			C-e		読みの終端へ
			C-f		１文字進む
			C-g		変換中止
			LFD		字種変換
			C-k		ポイント以降の読み削除
			C-l		小文字変換
			RET		変換確定
			C-n		字種変換
			C-p		字種変換
			C-q		quoted-insert
			C-u		大文字変換
			! .. ~		読み入力"
  (interactive)

  ;; 以前の変換対象文字列を破棄する
  ;; ここで破棄する事により
  ;; 再変換時に keyboard-quit した場合に
  ;; ローマ字に戻るようになる
  (if canna:*fence-mode*
      (boiled-canna-next)

    (setq boiled-canna:yomi nil)

    (if (and ;(eq last-command 'boiled-canna-func-kakutei)
	     ;(eq last-command-char
		 ;(string-to-char boiled-canna-rK-trans-key)))
	     (eq last-command 'canna-functional-insert-command)
	     (or (and (vectorp boiled-canna-rK-trans-key)
		      (equal (vector last-command-char)
			     boiled-canna-rK-trans-key))
		 (equal last-command-char
			(string-to-char boiled-canna-rK-trans-key))))
		 
	;; 変換確定直後なら再変換する
	(progn
;	  (message "再変換します...")
	  (boiled-canna-undo)
	  (setq unread-command-events (list last-command-event)) )

      (cond ((and (eq (boiled-canna-char-charset (preceding-char)) 'ascii))
	     ;; カーソル上の文字が半角{アルファベット|数字|記号}の場合
	     ;; カーソル上の文字が
	     ;; 半角{アルファベット|数字|記号}の間を
	     ;; 変換対象とする
	     (boiled-canna:henkan-function:alpha
	      (function canna-rk-trans-region)))

	    ((eq (boiled-canna-char-charset (preceding-char))
		 'katakana-jisx0201)
	     ;; カーソル上の文字が半角カタカナの場合
	     (boiled-canna:henkan-function
	      (function canna-henkan-region)
	      (function (lambda (ch)
		;; カーソル上の文字が
		;; 半角カタカナの間を
		;; 変換対象とする
                (eq (boiled-canna-char-charset ch) 'katakana-jisx0201) ))))

	    ((and (eq (boiled-canna-char-charset (preceding-char))
		      'japanese-jisx0208)
		  (not (string-match "[亜-瑤]"
				     (char-to-string (preceding-char)))))
	     ;; カーソル上の文字が全角{ひらがな|カタカナ|記号|数字}の場合
	     (boiled-canna:henkan-function
	      (function canna-henkan-region)
	      (function (lambda (ch)
	        ;; カーソル上の文字が
	        ;; 全角{ひらがな|カタカナ|記号|数字}の間を
	        ;; 変換対象とする
	        (and (eq (boiled-canna-char-charset ch)
			 'japanese-jisx0208)
		     (not (string-match
			   "[亜-瑤]"
			   (char-to-string (preceding-char))))) )) ))))))

(defun boiled-canna:henkan-function (function condition)
  "変換対象文字列を検出し、漢字変換する

変換対象となる範囲を設定し、FUNCTION を呼ぶ
変換対象は現在の point から CONDITION が成立している間戻った所までとなる
ただし、検出した範囲の中にマークが含まれていたら region を変換範囲とする"
  (let* ((end (point))
	 (start (progn
		  (let* ((mark-position (marker-position (mark-marker)))
			 (pos (if mark-position mark-position 1))
			 (mark-check (not (< pos (point))) ))
		    (while (and (or mark-check (< pos (point)))
				(eval (list condition (preceding-char))))
		      (backward-char)))
		  (point)) ))
    ;; 変換対象文字列の保存
    (setq boiled-canna:yomi (buffer-substring start end))

    (if (not (string= boiled-canna:yomi ""))
	;; boiled-canna から fence-mode に入った印
	(setq boiled-canna-fence-mode t))
    ;; 変換
    (eval (list function start end))))

(defun boiled-canna:henkan-function:alpha (function)
  "半角アルファベットを変換する時に変換対象文字列を検出し、漢字変換する

変換対象となる範囲を設定し、FUNCTION を呼ぶ
(変換対象外文字列を指定するには boiled-canna:stop-char を用いる)
ただし、検出した範囲の中にマークが含まれていたら region を変換範囲とする"
  (let* ((end (point))
	 (gap (boiled-canna:skip-char-backward)))
    (goto-char end)
    (if (not (= gap 0))
	(progn
	  (setq boiled-canna:yomi (buffer-substring (+ end gap) end))
          (if (not (string= boiled-canna:yomi ""))
              (setq boiled-canna-fence-mode t))
	  (eval (list function (+ end gap) end)))) ))

(defun boiled-canna:skip-char-backward ()
  (let* ((mark-position (if (markerp (mark-marker))
			    (marker-position (mark-marker))
			  nil))
	 (pos (if mark-position mark-position 1)))
    (skip-chars-backward boiled-canna:skip-char
			 (if (< pos (point)) pos nil))))


(defun boiled-canna-keyboard-quit (arg)
  "変換中止関数

変換前の文字列を戻すようにする
ただし、読み(ローマ字)に変更があった場合
変更を吸収したローマ字を戻す"
  (interactive "*p")
  (let ((mode-string (canna-query-mode)))
    (cond ((and (not canna:*japanese-mode*)
		(or (equal mode-string "[漢字]")
		    (equal mode-string "[ あ ]") ))
	   ;; boiled-canna で fence-mode に入った場合と
	   ;; 漢字変換中と、字種変換の結果 入力モードになった時は
	   ;; 変換前の文字列に戻す
	   ;; 読みが変更されていた場合には
	   ;; その変分を吸収した文字列を戻す
	   (boiled-canna-cancel-or-kakutei-romaji))
	      
	  (t
	   ;; その他の場合
	   ;; 字種変換中の動作もこの部分に含まれる
	   ;; 字種変換中には再変換できるように
	   ;; 入力モードにする、つまり、字種変換を止めるだけ
	   (canna-functional-insert-command arg)) )
    (setq boiled-canna-fence-mode nil) ))


(defun boiled-canna-cancel-or-kakutei-romaji ()
  "ローマ字確定関数

変換を中止し変換対象文字列を返す
ただし、読みに変更があった場合には
その変更を吸収した形のローマ字を返す"
  (if (or (and boiled-canna:yomi
	       (not (equal (boiled-canna-char-charset
			    (car (string-to-list boiled-canna:yomi)))
			   'ascii)))
	  (string= (boiled-canna-romaji) boiled-canna:yomi))
      ;; 変換対象文字列がローマ字でないか、もしくは、
      ;; 変換対象文字列とローマ字変換した結果が一致したら
      ;; 変換を中止し変換前の文字列を戻す
      (progn
	(boiled-canna-cancel)
	(if (and (boundp 'emacs-major-version)
		 (>= emacs-major-version 20))
	    (boiled-canna-undo)
	  (boiled-canna-undo 0)) )
    ;; 読みに変更があった場合
    ;; ローマ字変換を確定する
    ;; 再変換時はここに落ちる
    (boiled-canna-kakutei)))

;; simple.el から持って来た
;; minibuffer に "Undo!" を出力するのを止めるだけ
(defun boiled-canna-undo (&optional arg)
  "Undo some previous changes.
Repeat this command to undo more changes.
A numeric argument serves as a repeat count."
  (interactive "*p")
  ;; If we don't get all the way thru, make last-command indicate that
  ;; for the following command.
  (setq this-command t)
  (let ((modified (buffer-modified-p))
	(recent-save (recent-auto-save-p)))
    (or (and (eq last-command 'undo)
	     (and (string-match "XEmacs" emacs-version)
		  (eq (current-buffer) last-undo-buffer)) ) ; XEmacs
	(progn (undo-start)
	       (undo-more 1)))
    (undo-more (or arg 1))
    ;; Don't specify a position in the undo record for the undo command.
    ;; Instead, undoing this should move point to where the change is.
    (let ((tail buffer-undo-list)
	  done)
      (while (and tail (not done) (not (null (car tail))))
	(if (integerp (car tail))
	    (progn
	      (setq done t)
	      (setq buffer-undo-list (delq (car tail) buffer-undo-list))))
	(setq tail (cdr tail))))
    (and modified (not (buffer-modified-p))
	 (delete-auto-save-file-if-necessary recent-save)))
  ;; If we do get all the way thru, make this-command indicate that.
  (setq this-command 'undo))

(defun boiled-canna-romaji ()
  "ローマ字変換関数

boiled-canna-cancel-or-kakutei-romaji から呼ばれる事を前提とする
よって、他の関数から呼ばれた場合の動作は保証できない
(boiled-canna-cancel-or-kakutei-romaji 以外から呼ばれた時は
ローマ字変換できる保証がない為)"
  (canna-do-function canna-func-beginning-of-line)
  (if (not (equal (canna-query-mode) "[漢字]"))
      (canna-do-function canna-func-henkan))
  (while (not (= canna-henkan-length canna-henkan-revlen))
    ;; canna-henkan-length と canna-henkan-revlen が
    ;; 同一長になるまで文節を伸ばす事により
    ;; 変換中の文字列を全て
    ;; その後の対象文字列とする事ができる
    (canna-do-function canna-func-extend))
  (canna-do-function canna-func-romaji)
  (canna-do-function canna-func-hankaku)
  canna-henkan-string)

;;; 変換強制終了(変換文字列破棄)関数
(defun boiled-canna-cancel ()
  "変換強制終了(変換文字列破棄)関数"
  (canna-do-function canna-func-beginning-of-line)
  (if (not (equal (canna-query-mode) "[漢字]"))
      (canna-do-function canna-func-henkan))
  (canna-do-function canna-func-kill-to-end-of-line)
      
  (if canna-henkan-string
      ;; canna 3.5 だと何故か
      ;; (canna-do-function canna-func-kill-to-end-of-line)
      ;; で頭の１文字残るのでその対処
      (canna-do-function canna-func-delete_previous))
  (canna-do-function canna-func-quit)
  (canna:display-candidates 0))


;; 候補一覧を表示している時にキーを押したら動かす関数
(defun boiled-canna-minibuffer-henkan-kakutei-and-self-insert (arg)
  (interactive "*p")
  (if (equal (canna-query-mode) "[一覧]")
      (progn
	(canna-do-function canna-func-kakutei)
	(select-window canna:*previous-window*)
	(canna:display-candidates (length canna-kakutei-string))
	(boiled-canna-kakutei-self-insert arg)
	(setq boiled-canna-fence-mode nil))
    (if (and (boundp 'canna:*minibuffer-local-map-backup*)
	     canna:*minibuffer-local-map-backup*)
	(use-local-map canna:*minibuffer-local-map-backup*)
      (setq canna:*select-mode* nil))
    (set-window-buffer (minibuffer-window) canna:*saved-minibuffer*)
    (select-window canna:*previous-window*)
    (canna:functional-insert-command2 last-command-char arg)
    (setq boiled-canna-fence-mode nil) ))

(defun boiled-canna-func-kakutei (arg)
  (interactive "*p")
  (if (or canna:*japanese-mode*
	  (equal (canna-query-mode) "[ あ ]"))
      ;; 入力中
      (canna-functional-insert-command arg)

    ;; 漢字変換中
    (boiled-canna-kakutei)
    (setq boiled-canna-fence-mode nil) ))

;; この関数は canna.el を参考にした
(defun boiled-canna-kakutei-self-insert (arg)
  "文字を入力する

変換中に入力された場合には変換中の文字列を確定し
入力された文字列を buffer に挿入する"
  (interactive "*p")

  (if (or canna:*japanese-mode*
	  (equal (canna-query-mode) "[ あ ]"))
      ;; 入力中
      (canna-functional-insert-command arg)

    ;; 漢字変換中
    (boiled-canna-kakutei)
    (setq boiled-canna-fence-mode nil)
    ;; キー入力を次のインタプリタループに処理させる
    (setq unread-command-events (list last-command-event))) )

;; この関数は canna.el を参考にした
(defun boiled-canna-kakutei ()
  "変換を確定する"
  (let ((res)
	(kakutei canna-henkan-string))
    (while (not canna-empty-info)
      (setq res (canna-do-function canna-func-kakutei)))
    ;; 変換中の文字列から空白を削除して確定文字列を作る
    (setq canna-kakutei-string (boiled-canna-delete-space kakutei))
    (canna:display-candidates (length canna-kakutei-string))
    (mode-line-canna-mode-update canna:*alpha-mode-string*))
  (setq boiled-canna-fence-mode nil))

(defun boiled-canna-delete-space (str)
  "空白削除関数

canna-henkan-string から空白を削除する"
  (let ((res)
	(chr (string-to-list str)))
    (while chr
      (if (not (eq (car chr) ?\ ))
	  (setq res (concat res (char-to-string (car chr)))))
      (setq chr (cdr chr)))
    res))

(provide 'boiled-canna)
