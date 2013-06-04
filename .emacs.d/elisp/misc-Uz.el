;;; misc-Uz.el --- my own miscellaneous function
;;
;; Copyright (C) 1997 Usuda Hiroshi

;; Author: Usuda Hiroshi <usuda-hiroshi@d4.dion.ne.jp>(http://www.d4.dion.ne.jp/~usuda/)
;; Keywords: list
;; Version: 1.0.45
;; Last-Modify : Fri Dec 28 11:12:29 2001

;;; Commentary:

;;	■ なんだこれは
;;
;;	私のプログラムでコンスタントに使うへぼいライブラリ。いずれこんなへ
;;	なちょこライブラリは不必要にすべきであるけれど、今のところはその気
;;	はない。恥ずかしいので中身はあまりみないでほしい。(コメントで使っ
;;	ている英語もかなり怪しいし、GNU Coding は全く無視している)
;;
;;	2000.11 関数名に U- を付けてお行儀よくしました。てへ
;;
;;

;;; Code:

;--------------------------------------------------------------------------------
;
;	解説：破壊的リスト操作関数群
;
;	(setq A '(A B C) )
;
;	(U-del A 0)			(nth 0 A)を削除
;	(U-del A 3)			(nth 3 A)を削除
;	(U-del A -1)		リストの最後を削除
;
;	(U-mod A 0 'a)		(nth 0 A)を'a にする
;	(U-mod A 3 'a)		(nth 3 A)を'a にする
;	(U-mod A -1 'a)		リストの最後を'a にする
;
;	(U-ins A 0 'a)		(nth 0 A)を'a を追加
;	(U-ins A 3 'a)		(nth 3 A)を'a を追加
;	(U-ins A -1 'a)		リストの最後に'a を追加
;
;	先頭のセルは常に渡したセルと同じです。
;	つまり、渡したリストと帰ったリストは、常に eq なのだ。
;
;	添字はマイナスでリストの後ろからを返す事が出来る。



;
;●	動作：破壊的にリストの要素を削除
;
; Emacs : (nthcdr -1 '(nil))	-> nil
;XEmacs : (nthcdr -1 '(nil))	-> Error arg must natnump

(defmacro U-del (S i)(`
	(let ((R (U-delq (, S) (, i))))(if R nil (setq (, S) nil)) (, S))
	))

(defun U-delq (L I)
	(let ((len (length L)))(cond 
	((eq I 0)							;最初の場合は一つずつシフト
		(let ((n 0))
			(while (> len n)(setcar (nthcdr n L) (nth (1+ n) L))(setq n (1+ n)))
			;(setcdr (nthcdr (- len 2) L) nil));for XEmacs
			(if (> len 1)(setcdr (nthcdr (- len 2) L) nil)))
		)
	((> 0 I)							; マイナス は 最後 ー１
		(if (< -1 (+ len I))(U-del L (+ len I)))
		)
	(t									; プラス   は 最初   ０
		;(setcdr (nthcdr (1- I) L) (nthcdr (1+ I) L));for XEmacs
		(if (> len 0)(setcdr (nthcdr (1- I) L) (nthcdr (1+ I) L)))
		)
	)(if (and (eq len 1)(or (eq I 0)(eq I -1)))nil L)))

	;(setq A '(0 1 2 3 4 5))
	;(U-del A -1)


;
;●	動作：破壊的にリストの要素を変更
;
(defmacro U-mod (S i r)(`(progn
	(if (and (or (eq 0 (, i))(eq -1 (, i)))(eq 1 (length (, S))))(setq (, S) (list (, r)))
	(U-modq (, S) (, i) (, r))
	))))

(defun U-modq (L i r)
	; 要素が足りないときには、ｎｉｌで補う
	(while (>= i (length L))
		(setcdr (nthcdr (1- (length L)) L) (cons nil nil))
		)
	; 挿入する場所によって動作が変わる
	(let ((LEN (length L)))(cond
		((< (+ LEN i) 0)	nil)			; マイナス指定が超過
		(t
			(setcar (nthcdr (if (<= 0 i)i(+ LEN i)) L) r))
	))L)

	;(setq A '(0 1 2 3 4 5))
	;(setq A '(1 1 1))
	;(U-mod A 0 t)

	;(setq A '(0))
	;(U-del A -1)

;
;●	動作：破壊的にリストの要素を挿入
;

(defmacro U-ins (S i r)(`(progn
	(if (eq nil (, S))(setq (, S) (list nil)))
	(U-insq (, S) (, i) (, r))
	)))


(defun U-insq (L i r)
	; 要素が足りないときには、ｎｉｌで補う
	(while (> i (length L))
		(setcdr (nthcdr (1- (length L)) L) (cons nil nil))
		)
	; 挿入する場所によって動作が変わる
	(let* ((LEN (length L)))(cond
		((< (+ LEN i) -1)	nil)										; マイナス指定が超過
		((or (equal i 0)(equal (+ LEN i) -1))							; i = ゼロ
			(let ((n LEN))												; リストをシフト
				(setcdr (nthcdr (1- LEN) L)(list nil))	;add
				(while (< 0 n)(setcar (nthcdr n L) (nth (1- n) L))(setq n (1- n)))
				(setcar L r)
			))
		(t
			(setcdr (nthcdr (1- (if (< 0 i)i(+ LEN i 1))) L)
				(nconc (list r) (nthcdr (if (< 0 i)i(+ LEN i 1)) L))))
	))L)

	;(setq A '(0 1 2 3 4 5))
	;(U-ins A -10 'f)

;-------------------------------------------------------------------------------------------------
;
;●リスト y から x と equal であるものを除いた物を返す
;
;(U-del1 'a '(c c a a b b z x a a c c))

(defun U-del1 (x y)
	(cond	((null y)				nil)
			((not(equal x (car y)))	(cons (car y)(U-del1 x (cdr y))))
			(t						(U-del1 x (cdr y)))))

;●リスト y から リスト x に含まれる要素を除いた物を返す
;
;(U-del2 '(a b c) '(c c a a b b z x a a c c))

(defun U-del2 (list1 list2)
	(cond	((null (car list1))	list2)
			(t					(U-del2 (cdr list1) (U-del1 (car list1) list2)))))

;●リスト y から、car が x であるものを取り除く。
;
;(U-del3 'a '((c d f)(a f d)(d f)(a s)))

(defun U-del3 (x y)
	(cond	((null y)				nil)
			((not(equal x (car-safe (car y))))	(cons (car y)(U-del3 x (cdr y))))
			(t								(U-del3 x (cdr y)))))

;●リスト y から、car が x であるものを取り除く。
;
;(U-del4 'f '((c . f)(a . d)(d . f)(a . s)))

(defun U-del4 (x y)
	(cond	((null y)				nil)
			((not(equal x (cdr (car y))))	(cons (car y)(U-del4 x (cdr y))))
			(t								(U-del4 x (cdr y)))))

;●list 中から elem と equal である添字を返す。なければ nil
;
;(U-htn '(a b c d e f (a d)) '(a d))

(defun	U-htn (list elem)
	(let ((RET nil)(I 0)(LEN (length list)))(while (> LEN I)(if (equal elem (nth I list))(progn(setq RET I)(setq I LEN))(setq I (1+ I))))RET)
	)

;●リストの最後の数字に1を足す(足した結果の数値を返す)
(defmacro U-add-end (LIST &optional A)
	(` (setcar (nthcdr (1- (length (, LIST))) (, LIST)) (+ (, (if A A 1))(nth (1- (length (, LIST)))(, LIST)))))				;リストの最後を＋1する
	)

;●リストの要素で equal であるものを１つにする
;
;(U-list-itii '(a b f c s d a b c d s))
(defun U-list-itii (QQ)
	(let (AA)
	(U-list-lla QQ '(progn (setq AA (U-del1 TMP AA))(setq AA (append AA (list TMP)))))
	(setq AA (nreverse AA))
	AA
	))

;●後ろから処理して行く
;
;(U-list-lla '(a b c d e f) '(insert (prin1-to-string TMP)))
(defun U-list-lla (LIST DO)
	(let* ((I (length LIST)))(while (> I 0)(let ((TMP (nth (1- I) LIST)))
		(eval DO)
	(setq I (1- I)))))
	)

;●リストＬからシンボルＳかシンボルSを先頭にするリストを検索して返す
(defun U-list-find1(L S)
	(if (member S L)S
		(catch 'F (mapcar (lambda(a)(if (eq S (car-safe a))(throw 'F a))) L)nil)
	))

(defun U-symbol-not-nilp(a)
	(if a (symbolp a))
	)

;-------------------------------------------------------------------------------
;
;	解説 :	雑多な関数
;


;●Emacs21では、ミニバッファで(erase-buffer)すると、プロンプトがプロパティread-onlyなのでエラーになる。困った事だ。
(defun U-minibuffer-replace(S)
	(goto-char (point-min))
	(while (get-text-property (point) 'read-only)(forward-char 1))
	(kill-line)
	(insert S)
	)

;●メニューバーを消去した
;
(defun U-no-menubar-keymap()
	(let ((a (make-keymap)))
	(define-key a [menu-bar files]		'undefined)		;global-map の定義を上書きする
	(define-key a [menu-bar tools]		'undefined)
	(define-key a [menu-bar edit]		'undefined)
	(define-key a [menu-bar search]		'undefined)
	(define-key a [menu-bar help-menu]	'undefined)
	(define-key a [menu-bar options]	'undefined)
	(define-key a [menu-bar buffer]		'undefined)
	(define-key a [menu-bar mule]		'undefined)
	a))

;
;●なんだっけ？
;

(defun U-nth-match (num list line)
	(substring line (nth (* num 2) list)(nth (+(* num 2)1)list))
	)

(defun U-match-nth (num)
	(cons (nth (* num 2) (match-data))(nth (1+ (* num 2)) (match-data)))
	)

;
;●幾つかのシンボルを、再読み込み可能な状態で、ファイルにセーブします
;
;
(defun U-save-symbol (FILE &rest LIST)
	(switch-to-buffer (get-buffer-create "* tmp *"))
		(let ((I 0)(LEN (length LIST)))(while (< I LEN)(let ((TMP (nth I LIST)))
			(if TMP(insert (concat "(setq " (prin1-to-string TMP) (if (boundp TMP)(concat " '"(prin1-to-string (eval TMP)))" nil") ")\n")))
		(setq I (1+ I)))))
	(write-file FILE)
	(kill-buffer (current-buffer))	; save cause change buffer name.
	)

;●文字列をＮ文字にする
;
;	(U-expand-string "asd" 2)
;	(U-expand-string "ああ" 3)
;
(defun U-expand-string (STR N &optional A)
	(let ((LEN (string-width STR)))
	(if (> LEN N)(substring STR 0 (- N (- (string-bytes STR) (string-width STR))))
	(concat (if A nil STR) (make-string (- N LEN) ? )(if A STR))
	)))

;●カラム数を返す
;
;(string-bytes "aあ")  -> 4
;(length "aあ")  -> 2
;(U-string-column "aあ") ->3

(defun U-string-column(STR)
	(+(length STR)(/(-(string-bytes STR)(length STR))2))
	)


;●カラム数で部分文字列を取り出す
(defun U-substring-byte(SRC A B)
	(let* (
		(STR (substring SRC 0 A))
		(NUM (/(-(string-bytes STR)(length STR))2))	;漢字の個数
		)
	(substring SRC (- A NUM) B)
	))


;●場所から行に変換
;
;	(U-point-to-line (1- (point-max)))
(defun U-point-to-line (point &optional start)
	(count-lines (if start start 1) (1+ point))
	)


;●文字列置き換え(正規表現可能)
;
;(U-string-replace "ab" "b" "abbabAAaa")
(defun U-string-replace (FROM TO STR)
	(let ((I 0))(while (setq I (string-match FROM STR I))
		(setq I (+ I (length TO)))
		(setq STR (replace-match TO t t STR))
		)STR))


;●文字が含まれるかどうか
;
;(U-string-find-ch "ABC" ?B)
(defun U-string-find-ch (FROM CH)
	(let* ((N 0)(I 0)(LEN (length FROM)))(while (< I LEN)(if (eq CH (elt FROM I))(setq N (1+ N)))(setq I (1+ I)))N)
	)

;●マップから、該当する関数を呼び出すキーの表示文字列を返す
;
;(U-map-to-keystr 'narrow-to-page global-map)
;(U-map-to-keystr 'Ufm-return Ufm-map)
(defun U-map-to-keystr (FUN MAP)
	(let ((NUM (car-safe (where-is-internal FUN MAP))))
		(mapconcat 'U-event-string NUM " ")
	))

;●ベクタの中のイベントを見易い文字列に変換する
;
;	(U-vector-to-keystr [(control)(tab)])
(defun U-vector-to-keystr (VECT)
	(mapconcat 'U-event-string VECT " ")
	)

;●イベントを見易い文字列に変換する
;
;	(U-event-string 255)
;	(U-event-string Ic-recursive-key)
;	(U-event-string (read-event))
;	(U-event-string 'S-f9)
(defun U-event-string (NUM)
	(cond 
		;文字列
		((stringp NUM)
			(let ((STACK)(I 0)(LEN (length Ic-recursive-key)))
			(while (< I LEN)(setq STACK (concat STACK (U-event-string (elt Ic-recursive-key I))))(setq I (1+ I)))
			STACK))
		;
		((symbolp NUM)(prin1-to-string NUM))
		((listp   NUM)(prin1-to-string NUM))
		;数値
		(t (let (	(MOD	(event-modifiers	NUM))
			(BAS	(event-basic-type	NUM))
			)
			(setq BAS (if (numberp BAS)(char-to-string BAS)(prin1-to-string BAS)))
			(if (equal " " BAS)(setq BAS "SPC"))
			(concat (mapconcat (function (lambda (A)(cond
				((eq 'meta A)"M-")
				((eq 'alt A)"A-")
				((eq 'control A)"C-")
				((eq 'hyper A)"H-")
				((eq 'super A)"s-")
				((eq 'shift A)(if (eq (length BAS)1)(progn(setq BAS (upcase BAS))nil)"S-"))
				))) MOD "") BAS)
		))))

;●ｆｏｒ文
;
;(defmacro U-for (I X Y &rest BODY)
;	"for文"
	;(for i 1 3 (insert (prin1-to-string i)))
;	(let ((TMP (make-symbol "MAX")))
;		(` (let (((, I) (, X))((, TMP) (, Y)))
;			(while (<= (, I) (, TMP)) (,@ BODY) (inc (, I)))
;		))))

;●＋＋
;
;(defmacro U-inc
	;(setq A 1)
	;(inc A)
;	(var)(list 'setq var (list '1+ var)))

;-------------------------------------------------------------------------------
;
;	解説 : 色んなEmacsが世界には存在するのだ
;
;		幾つかの関数は、いつからサポートされてんだか良く判らないからね。
;		これでちゃんと動くんだろうか？？
;
;(symbol-function 'functionp)

; functionp
(condition-case nil (functionp 'functionp)(error
	(defun functionp (SYM)(condition-case nil (symbol-function SYM)(error)))
	))

; string width
(if (functionp 'string-width)()
	(defun string-width (STR) (length STR))
	)

; (split-string "	A B CD EFG DFS ")
(if (functionp 'split-string)()
	(defun split-string (string &optional separators)
		(let ((STACK))
		(while (setq I(string-match (concat "[^"(if separators separators " \t\n")"]+") string))
		(setq STACK (append STACK (list (match-string 0 string))))
		(setq string (replace-match "" nil nil string))
		)STACK))
	)
; facep
(if (functionp 'facep)()
	(defun facep (FACE) (memq FACE (face-list)))
	)

; decode-coding-string
(if (functionp 'decode-coding-string)()
	(defun decode-coding-string(STRING CODING-SYSTEM &optional NOCOPY)STRING)
	)

; encode-coding-string
(if (functionp 'encode-coding-string)()
	(defun encode-coding-string(STRING CODING-SYSTEM &optional NOCOPY)STRING)
	)

; windows95 かな？
(defun U-win32p()
	(or (eq window-system 'w32)(eq window-system 'mswindows))
;	(or (string-match "win32"(version))(string-match "windows"(version)))
	)

(provide 'misc-Uz)

;;;misc-Uz.el ends here
