;;; for Japanese environment
(cond ((string-match "21." emacs-version)
       (progn
	 (set-default-coding-systems 'euc-jp)
	 (set-buffer-file-coding-system 'euc-jp-unix)
	 (if (not window-system) 
	     (set-terminal-coding-system 'euc-jp))
	 (set-keyboard-coding-system 'euc-jp)
	 ))

      ((>= emacs-major-version 22)
       (progn
	 (set-default-coding-systems 'utf-8)
	 (set-buffer-file-coding-system 'utf-8)
	 (if (not window-system) 
	     (set-terminal-coding-system 'utf-8))
	 (set-keyboard-coding-system 'utf-8)
	 
	 (if (>= emacs-major-version 24)
	     (setq buffer-file-coding-system 'utf-8)
	   (setq default-buffer-file-coding-system 'utf-8))
       ))
      )

;;; for toolbar, tooltip, menu-bar, scroll-bar, etc
(tool-bar-mode 0)
(tooltip-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
	  
;;; for screen size (fullscreen)
(set-frame-position
 (selected-frame)
 0 0)

;; ;;;; window size を full screen にする
;; (defun maximize-screen (frame)
;;   (select-frame frame)
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;; 			 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;; 			 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
;; 

;;; for emacsclient settings
;; emacsclientからの接続時処理を設定:
;;   ;; <= server-visit-hook は使いにくいので after-make-frame-functions を使うことにした
;; (setq server-visit-hook 
;;       '(lambda ()
;;       (keyboard-translate ?\C-h ?\C-?)
;;         ; font setting
;; 	 (if window-system
;; 	     (cond 
;; 	      ((string-match "^23\." emacs-version)
;; 	       (set-default-font "DejaVu Sans Mono-10")
;; 					;	       (set-default-font "Bitstream Vera Sans Mono-10.5")
;; 					;	       (set-fontset-font (frame-parameter nil 'font)
;; 					;				 'japanese-jisx0208
;; 					;				 '("M+1P+IPAG circle" . "unicode-bmp"))
;; 	       (set-fontset-font (frame-parameter nil 'font)
;; 				 'japanese-jisx0208
;; 				 '("IPAGothic" . "unicode-bmp")))
;; 	      
;; 	      ( t 
;; 		(create-fontset-from-fontset-spec
;; 		 "-*-fixed-medium-r-normal--14-*-*-*-*-*-fontset-osaka14,
;;                   ascii:-*-fixed-medium-r-normal--14-*-iso8859-1,
;;                   japanese-jisx0208:-apple-osaka-medium-r-normal-*-14-*-*-*-*-*-jisx0208.1983-0")
;; 		(set-default-font "fontset-osaka14"))))
;; 	 
;; 	 ))

(add-hook 'after-make-frame-functions 
	  '(lambda (frame)
	     (select-frame frame)             ; 新しいフレームを対象に処理を行う.
	     (keyboard-translate ?\C-h ?\C-?) ; 他にいい方法が思いつかないので, ここで処理.
	     (cond ((window-system frame)     ; もしGUIのフレームなら, 
		    ;; font 設定
		    ;;;; set-frame-font
		    ;;(set-frame-font "DejaVu Sans Mono-10")
		    ;; 
		    ;; <http://d.hatena.ne.jp/kitokitoki/20110502/p2> 
		    ;; <https://github.com/yascentur/Ricty>
		    ;; 横幅が 1:2 になるのは、12pt, 13.5pt, 15pt, 18pt など.
		    ;; "ピクセル値 (px) が偶数でないとき、どのフォントにおいても起こりうる問題です。
		    ;; 一般的な 96 DPI のフォントレンダリングでは、9 pt、10.5 pt、12 pt、13.5 pt、15 pt など、1.5 の倍数を指定すると 1:2 で表示されると思います。"
		    ;; (set-frame-font "Ricty-12")
		    (set-frame-font "Ricty-13.5")

		    ;;;; 
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("IPAGothic" . "unicode-bmp"))
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("MigMix 1P" . "unicode-bmp"))
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("MigMix 2P" . "unicode-bmp"))
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("MigMix 1M" . "unicode-bmp"))
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("MigMix 2M" . "unicode-bmp"))
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("Migu 1P" . "unicode-bmp"))
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("Migu 1C" . "unicode-bmp"))
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("Migu 1M" . "unicode-bmp"))   ; <= 作者の人お勧め
		    ;;(set-fontset-font (frame-parameter nil 'font)
		    ;;		      'japanese-jisx0208
		    ;;		      '("Migu 2M" . "unicode-bmp"))
		    (set-fontset-font (frame-parameter nil 'font)
				      'japanese-jisx0208
				      '("Ricty" . "unicode-bmp"))   ;  <= Inconsolata + Migu 1M

		    ;; ウィンドウサイズの設定
					;(maximize-screen frame)))  ; ウィンドウサイズを最大化.
		    (set-frame-size frame 
				    118 72)))  ; ウィンドウサイズを変更 (最大化するとanything等使用時にフリーズする. compizが悪い？)
	     ))

;;; for goto-line
(global-set-key "\M-g" (lambda (x) (interactive "nLine: ") (goto-line x))) ; n はミニバッファから読み取るの意

;;; for narrow-to-region
(put 'narrow-to-region 'disabled nil)

;;; for abbrev
(global-set-key "\C-x'" 'just-one-space)
;(global-set-key "\M- " 'dabbrev-expand)
;(global-set-key "\M-/" 'expand-abbrev)
(global-set-key "\M- " 'expand-abbrev)
;(eval-after-load "abbrev" '(global-set-key "\M-/" 'expand-abbrev))
(eval-after-load "abbrev" '(global-set-key "\M- " 'expand-abbrev))

;;; for bobcat
; <http://akisute3.hatenablog.com/entry/20120318/1332059326>
; Emacs の C-h は初期状態では help となっているが，これを backspace として使用したいと考える人は多いと思う．
; この方法には，以下の2通りある．
;   * global-set-key で C-h に delete-backward-char を割り当てる
;   * keyboard-translate を使用して C-h に backspace と同じ処理を割り当てる
; 前者は，ミニバッファで使えなかったり，他の elisp で delete-backward-char を乗っ取ったときに BS キーとの整合が取れなくなる場合があるので，できれば後者のほうがいい．
(keyboard-translate ?\C-h ?\C-?)

;;;; obsolete?
; (if (eq window-system 'x) ;if use X-Window, 'x
;         (progn
;           (define-key function-key-map [backspace] [8])
;           (put 'backspace 'ascii-character 8)))
; ;(load "term/bobcat")
; ; bobcat が効かないので 21.3 のころの bobcat の中身を張っとく
; (let ((the-table (make-string 128 0)))
;   (let ((i 0))
;     (while (< i 128)
;       (aset the-table i i)
;       (setq i (1+ i))))
;   ;; Swap ^H and DEL
;   (aset the-table ?\177 ?\^h)
;   (aset the-table ?\^h ?\177)
;   (setq keyboard-translate-table the-table))

;;; for iswitchb
(if (and (>= emacs-major-version 20)
         (< emacs-major-version 23))
    (progn
      (iswitchb-mode)
      (iswitchb-default-keybindings))
  (iswitchb-mode 1))
(setq iswitchb-buffer-ignore
      (append
       '("Completions" "Messages" "Help" "Apropos" "Compile-Log")
       iswitchb-buffer-ignore))

;;; for C-x 3 (truncate-partial-width-windows)
;ウインドウ分割時に画面外に出てしまう文章を折り返す。
(setq truncate-partial-width-windows nil)

;;; for toggle-truncate-lines
(global-set-key "\C-ct" 'toggle-truncate-lines) ; 折り返し表示ON/OFF

;;; for transient-mark-mode
;; <http://www.mew.org/pipermail/mew-dist/2003-September/023693.html>
;; -- XEmacs では、C-SPC ＋カーソルの移動で指定したリージョンがハイライトされます。
;; -- 
;; -- Emacs 20.7 や 21 では、マウスで指定したリージョンにはハイライトされるが、
;; -- カーソルの移動で指定したリージョンはハイライトされないと思っている人が
;; -- 多いようです。
;; -- 
;; -- しかし、それは間違いです。
;; -- 	M-x transient-mark-mode 
;; -- とすると、ハイライトされるようになります。
(transient-mark-mode t)

;;; for kill, yank (= cut, copy, paste)
;; <http://www.emacswiki.org/emacs/CopyAndPaste>
;; 
;;;; Emacs 24 対策
;; FYI: <http://www.gnu.org/software/emacs/manual/html_node/emacs/Clipboard.html>
;; <http://dan-project.blog.so-net.ne.jp/2012-11-25>
;; Emacs 24 で yank の仕様が変更された.
(if (>= emacs-major-version 24)
    (progn
      (setq select-active-regions nil)      ; これは Emacs 23.1 の挙動. 22 の挙動が好ければ t にする (範囲選択するだけでキルリングにコピーするようになる)

      ;; (setq x-select-enable-clipboard nil)  ; これは nil に戻さなくていい. kill-region/kill-ring-save でコピーしたい
      (setq x-select-enable-clipboard t)

      (setq x-select-enable-primary t)
      (setq mouse-drag-copy-region t)
      ))

;;;; for "yank した文字列をハイライト表示したい"
(when (or window-system (eq emacs-major-version '21))
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
      (delete-overlay ol)))
  (defadvice yank-pop (after ys:highlight-string activate)
    (when (eq last-command 'yank)
      (let ((ol (make-overlay (mark t) (point))))
        (overlay-put ol 'face 'highlight)
        (sit-for 0.5)
        (delete-overlay ol)))))

;;;; for "yank した文字列を自動でインデントしたい"
;; <http://www.emacswiki.org/emacs/AutoIndentation>
;; C-u 付きで呼ぶと通常の挙動になる.
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

;;;; C-w/M-w の入れ替え & クリップボード連携
;; clipboard-kill-ring-save/clipboard-kill-region は, cua-mode の矩形制御と相性が悪いので止めにした.
;; 
;; そもそも, 最近は interprogram-cut-function という仕組みで, 
;; 普通の kill-ring-save/kill-region でも X アプリに伝わるようになっている模様.
;; (ここにセットされている関数が呼ばれる. デフォルトは x-select-text)
;; 
;; ただし, x-select-text は
;; x-select-enable-primary や x-select-enable-clipboard という変数が 
;; t でなければ設定してくれない.
;; (正確には, それぞれ PRIMARY/CLIPBOARD に設定するかどうかを制御する. 
;; どちらかというと CLIPBOARD の方が問題)
;; 
;; (defun my-kill-ring-save ()
;;   (interactive)
;;   ;(kill-ring-save (point) (mark))
;;   (clipboard-kill-ring-save (point) (mark))
;;   (exchange-point-and-mark)
;;   (sit-for 0.8)
;;   (exchange-point-and-mark))
;; (defun my-kill-region ()
;;   (interactive)
;;   ;(kill-ring-save (point) (mark))
;;   (clipboard-kill-region (point) (mark))
;;   ;(exchange-point-and-mark)
;;   ;(sit-for 0.8)
;;   ;(exchange-point-and-mark)
;;   )
;; (global-set-key "\C-w" 'my-kill-ring-save)
;; (global-set-key "\M-w" 'my-kill-region)
;; 
(global-set-key "\C-w" 'kill-ring-save)
(global-set-key "\M-w" 'kill-region)


;;; for previous-other-window
(global-set-key "\C-x\C-n" 'other-window)
(global-set-key "\C-x5\C-n" 'other-frame) ; コントロールがもう一つ少ない方が打ちやすい気がする
(global-set-key "\C-x\C-p"
  #'(lambda (n) (interactive "p") (other-window (- n)))) ; p は前置引数があったら数とみなして、なかったら 1を、の意
(global-set-key "\C-x5\C-p"
  #'(lambda (n) (interactive "p") (other-frame (- n))))

;;; for scroll-command
(if (>= emacs-major-version 24)
    (progn
      (global-set-key [up] 'scroll-down-line)
      (global-set-key [down] 'scroll-up-line))
  (progn
    (defun scroll-up-just-one ()
      (interactive)
      (scroll-up 1))
    (defun scroll-down-just-one ()
      (interactive)
      (scroll-down 1))
    (global-set-key [up] 'scroll-down-just-one)
					;  (lambda (n) (interactive "p") (scroll-down n)))
    (global-set-key [down] 'scroll-up-just-one)
					;  (lambda (n) (interactive "p") (scroll-up n)))
    ))

;;; for cua-mode
;; cua モードを有効にする. ただし, キーバインドは使わない.
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;;; ;;;; C-RET を C-SPC に変える
;; <http://my.opera.com/crckyl/blog/index.dml/tag/emacs>
;; cua-mode での C-SPC は cua-set-mark というコマンドになっているので, ここに defadvise すればいい.
;; 
;; (defadvice cua-set-mark (around start-rectangle-mark activate)
;;   (if (and (region-active-p) (eq last-command 'cua-set-mark))
;;       (cua-toggle-rectangle-mark)
;;     ad-do-it))


;;;; TODO: cua-replace-region を無効化する
;; <http://www.archivum.info/help-gnu-emacs@gnu.org/2008-11/01268/Re-cua-mode-and-cua-replace-region.html>
;; (マークした後で少し修正しようとすると全部消されて置き換えになってしまう...)

;;; 
(defun point-to-top ()
  "Put point on top line of window"
  (interactive)
  (move-to-window-line 0))
(defun point-to-bottom ()
  "Put point at begining of last visible line"
  (interactive)
  (move-to-window-line -1))
(global-set-key [?\C-x ?\C-.] 'point-to-bottom)
(global-set-key [?\C-x ?\C-,] 'point-to-top)

;;; for forward-/backward-paragraph
; <http://ergoemacs.org/emacs/emacs_move_by_paragraph.html> : Emacs: Move Cursor by Paragraph or Text Block
; <http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html> : Emacs Lisp: Move Cursor to Beginning of Line or Block
; forward-paragraph/backward-paragraph は, メジャーモードによって挙動がかなり変わるため使いにくいとのこと.
; (例えば, html-mode で試してみればいい)
; <= これは "paragraph" が syntax table に依存して定められているから, らしい.
;    <http://flex.phys.tohoku.ac.jp/texi/emacs-jp/emacs-jp_117.html>
;    "段落の区切りの正確な定義は，変数paragraph-separateと paragraph-startで決められます．
;     paragraph-startの値は正規表現で，段落を開始したり区切ったりする行を表します．
;     paragraph-separateの値は別の正規表現で，これは段落の区切りで，どの段落の一部にもならない行を表します．
;     段落を開始しかつその段落に含まれる行は，どちらの正規表現にもマッチしなくてはなりません．
;     たとえば，普通 paragraph-startの値は"^[ \t\n\f]"で， paragraph-separateは"^[ \t\f]*$"になっています． "
; 
; また, 特別に forward-/backward-paragraph 用のキーバインドを覚えるよりは, C-a/C-e が DWIM 的に動いてくれたほうが使いやすい, とのこと.
; <= とはいえ, このページに書かれているコードは移動後の位置が気に食わない. 個人的には forward-/backward-paragraph と同じ位置に移動してくれたほうが自然な気がする
; 
; (defun xah-forward-block (&optional φn)
;   "Move cursor forward to the beginning of next text block.
; A text block is separated by blank lines.
; In most major modes, this is similar to `forward-paragraph', but this command's behavior is the same regardless of syntax table."
;   (interactive "p")
;   (let ((φn (if (null φn) 1 φn)))
;     (search-forward-regexp "\n[\t\n ]*\n+" nil "NOERROR" φn)))
;  
; (defun xah-backward-block (&optional φn)
;   "Move cursor backward to previous text block.
; See: `xah-forward-block'"
;   (interactive "p")
;   (let ((φn (if (null φn) 1 φn))
;         (ξi 1))
;     (while (<= ξi φn)
;       (if (search-backward-regexp "\n[\t\n ]*\n+" nil "NOERROR")
;           (progn (skip-chars-backward "\n\t "))
;         (progn (goto-char (point-min))
;                (setq ξi φn)))
;       (setq ξi (1+ ξi)))))
;  
; (defun xah-beginning-of-line-or-block (&optional φn)
;   "Move cursor to beginning of line, or beginning of current or previous text block.
;  (a text block is separated by blank lines)"
;   (interactive "p")
;   (let ((φn (if (null φn) 1 φn)))
;     (if (equal φn 1)
;         (if (or (equal (point) (line-beginning-position))
;                 (equal last-command this-command )
;                 ;; (equal last-command 'xah-end-of-line-or-block )
;                 )
;             (xah-backward-block φn)
;           (beginning-of-line))
;       (xah-backward-block φn))))
;  
; (defun xah-end-of-line-or-block (&optional φn)
;   "Move cursor to end of line, or end of current or next text block.
;  (a text block is separated by blank lines)"
;   (interactive "p")
;   (let ((φn (if (null φn) 1 φn)))
;     (if (equal φn 1)
;         (if (or (equal (point) (line-end-position))
;                 (equal last-command this-command )
;                 ;; (equal last-command 'xah-beginning-of-line-or-block )
;                 )
;             (xah-forward-block)
;           (end-of-line))
;       (progn (xah-forward-block φn)))))

(defun my-beginning-of-line-or-block (&optional φn)
  "Move cursor to beginning of line, or beginning of current or previous text block.
 (a text block is separated by blank lines)"
  (interactive "p")
  (let ((φn (if (null φn) 1 φn)))
    (if (or (> φn 1) (equal last-command this-command ))
	; (or (> φn 1) (equal (point) (line-beginning-position))) 
	(let ((paragraph-start "\\|[ \t]*$") ; or "^[ \t\n\f]" ??
	      (paragraph-separate "[ \t]*$")); or "^[ \t\f]*$" ??
	  (backward-paragraph φn))
      (move-beginning-of-line nil)))) ; beginning-of-line だと org-mode などで折りたたんだ状態での移動に違和感がある

(defun my-end-of-line-or-block (&optional φn)
  "Move cursor to end of line, or end of current or next text block.
 (a text block is separated by blank lines)"
  (interactive "p")
  (let ((φn (if (null φn) 1 φn)))
    (if (or (> φn 1) (equal last-command this-command ))
	; (or (> φn 1) (equal (point) (line-end-position))) 
	(let ((paragraph-start "\\|[ \t]*$") ; or "^[ \t\n\f]" ??
	      (paragraph-separate "[ \t]*$")); or "^[ \t\f]*$" ??
	  (forward-paragraph φn)
	  (end-of-line))
      (move-end-of-line nil)))) ; end-of-line だと org-mode などで折りたたんだ状態での移動に違和感がある

(global-set-key "\C-a" 'my-beginning-of-line-or-block)
(global-set-key "\C-e" 'my-end-of-line-or-block)


;;; for dired 
;;;; recursive-copy, delete
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;;;; wdired
;;-- <http://www.emacswiki.org/emacs/WDired>
;;-- 22.1 以降で標準添付.
;;-- C-x C-q でオンに出来る. (下のバーに "Editable" と出ていれば wdired mode)
;;-- C-c C-c で変更を反映.  (C-x C-s でもいい?)
;;-- C-c C-k で変更を破棄.  (まぁ C-x C-k でもいいようだが...)
;; 
;;-- <http://d.hatena.ne.jp/higepon/20061226/1167098839> :  Emacs で wdired と moccur-edit を使っていない人は(ry
;;-- 例えば、拡張子 cpp を cxx に変更したいとすれば M - % で確認置換を起動し、cpp -> cxx と置換すればOKです。
;;-- ファイル名の変更が確定したら C-x C-s （バッファの保存と同じキー操作）とやれば変更が実際に反映されます。
;;-- 保存したくないときはC-x C-k。
(require 'wdired)
;(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)  <= 今は C-x C-q がデフォルト

;;-- dired-filetype-face.el
;; diredの表示をファイルタイプ毎に色分けしてカラフルにする
(require 'dired-filetype-face nil t)

;;;; for dired-x
(require 'dired-x)
;; 'X' でいろいろ(tar で開いたりとか)できるようになる
;; ; デフォルト設定は dired-guess-shell-alist-default
;; ; ユーザーごとの設定はこっち
(setq dired-guess-shell-alist-user
      '(
	;;("\\.tar\\.gz\\'"  "tar ztvf")
        ;;("\\.taz\\'" "tar ztvf")
        ;;("\\.tar\\.bz2\\'" "tar Itvf")
        ("\\.zip\\'" "unzip -O cp932 -l")
        ;("\\.zip\\'" "unzip -l")
        ;;("\\.\\(g\\|\\) z\\'" "zcat")
        ("\\.\\(jpg\\|JPG\\|gif\\|GIF\\)\\'"
         (if (eq system-type 'windows-nt)
             "fiber" "display"))
        ("\\.ps\\'"
         (if (eq system-type 'windows-nt)
             "fiber" "ghostview"))
        ("\\.lzh\\'"
	;"lha e")
	 "lha l")
        ("\\.rar\\'"
	 ;"unrar x")
	 "unrar l")
        ("\\.7z\\'"
	 ;"p7zip -d")
	 "7zr l")
        ("\\.\\(mpg\\|MPG\\|mpeg\\|avi\\|AVI\\|wmv\\|mp3\\|MP3\\|mp4\\|flv\\)\\'"
	 (if (eq system-type 'windows-nt)
	     ; "fiber" "smplayer * >/dev/null &"))
	     "fiber" "smplayer * >/dev/null &"))
        ("\\.html\\|\\.htm"
	 (if (eq system-type 'windows-nt)
	     "www-browser" "x-www-browser"))
        ("\\.swf"
	 (if (eq system-type 'windows-nt)
	     "www-browser" "x-www-browser"))
        ("\\.pdf\\'" "evince * &")
        ("\\.iso\\'" "isoinfo -l -i")
	("\\.\\(ppt\\|pptx\\)\\'" "loimpress * &")
	)
      )

;;;; dired-find-alternate-file
; ;; <http://nishikawasasaki.hatenablog.com/entry/20120222/1329932699>
; ;; dired で RET はもともと dired-find-file にマップされていて、
; ;; ディレクトリを開くと新しいバッファが開きます。
; ;; 一方 a で開くと dired-find-alternate-file がマップされているため
; ;; ディレクトリを開いたバッファに開いた先のディレクトリが表示されます。
;  
; ;; 無効コマンドdired-find-alternate-fileを有効にする
; ;;   (新規バッファを作成しないコマンド)
; ;;   (初めて dired-find-alternate-file を使った際に「今後も使いますか？」と聞かれ、
; ;;   y と答えたため, emacs が自動で init.el に書き込んでくれた設定.
; (put 'dired-find-alternate-file 'disabled nil)
;  
; ;; ファイルなら別バッファで、ディレクトリなら同じバッファで開く
; (defun dired-open-in-accordance-with-situation ()
;   (interactive)
;   (let ((file (dired-get-filename)))
;     (if (file-directory-p file)
;         (dired-find-alternate-file)
;       (dired-find-file))))
;  
; ;; RET 標準の dired-find-file では dired バッファが複数作られるので
; ;; dired-find-alternate-file を代わりに使う
; (define-key dired-mode-map (kbd "RET") 'dired-open-in-accordance-with-situation)
; (define-key dired-mode-map (kbd "a") 'dired-find-file)

;;;; dired-dwim-target
; ;; <http://keens.github.io/blog/2013/10/04/emacs-dired/>
; ;; ウィンドウを分割して左右にdiredバッファを開いているとき、RやCのデフォルトの宛先がもう片方のディレクトリになります。伝わりますかね？
; ;; 
; ;; If non-nil, Dired tries to guess a default target directory.
; ;; This means: if there is a Dired buffer displayed in the next
; ;; window, use its current directory, instead of this Dired buffer's
; ;; current directory.
; ;;  
; ;; The target is used in the prompt for file copy, rename etc.
(setq dired-dwim-target t)

;;;; dired-isearch-filenames
;; diredバッファでC-sした時にファイル名だけにマッチする
(setq dired-isearch-filenames t)


;;; for generic-x
;; <http://www.emacswiki.org/emacs/GenericMode>
;; <at-aka.blogspot.jp/2011/03/emacs-etchosts-etcapache2conf.html>
;; 設定ファイル (/etc/hosts, /etc/apache2.conf) の色付けをする 
;; 
;; generic-x というファイルは、NEWS.20 というファイルに説明がある。従って、少くとも Emacs 20 以降から Emacs の標準ファイルになったと推察できる。
;; NEWS.20 によると、generic-x がサポートするファイルは以下の通り:
;;   * Apache and NCSA httpd configuration files
;;   * Samba configuration files
;;   * fvwm initialization files
;;   * X resource files
;;   * hosts files (.rhosts, /etc/hosts, etc.)
;;   * mailagent .rules files
;;   * JavaScript files
;;   * VRML files
;;   * Java MANIFEST files
;;   * Java property files
;;   * .mailrc files
;;   * Solaris/Sys V prototype files
;;   * Solaris/Sys V pkginfo files
;;   * C shell alias files
;;   * MS-Windows INF files
;;   * MS-Windows INI files
;;   * MS-Windows Registry files
;;   * MS-Windows BAT scripts
;;   * MS-Windows Resource files
;;   * InstallShield scripts

(require 'generic-x)

;;; for uncomment-region
(add-hook 'c-mode-hook
	  '(lambda () (local-set-key "\C-c\C-u" 'uncomment-region)))


;;; for view-mode
;; <http://www.emacswiki.org/emacs/ViewMode>
;; C-x C-q で view-mode
(setq view-read-only t)
(require 'view)

;; <http://d.hatena.ne.jp/khiker/20061027/1161982764>
;; デフォルトで, 以下のようなキーバインドが設定される.
;; / 	正規表現で前を検索
;; \ 	正規表現で後を検索
;; n 	次の検索とマッチしたものへ移動
;; p 	前の検索とマッチしたものへ移動
;; イコール記号 	現在カーソルのある行の行番号をミニバッファに出力
;; 
;; < 	バッファの先頭に移動
;; > 	バッファの最後に移動
;; z 	1ページ分スクロール(PageDown)
;; w 	1ページ分前にスクロール(PageUp)
;; d 	半ページ分スクロール
;; u 	半ページ分前にスクロール
;; C-m	1行下へ
;; y 	1行上へ
;; . 	マークする
;; x 	現在のカーソルのある場所とマークのある場所を交換する
;; q 	view-modeを終了

;; <http://www40.atwiki.jp/cupnes/pages/28.html>
;; 少し less (vi?) っぽくしてみた
(define-key view-mode-map (kbd "j") 'View-scroll-line-forward)
(define-key view-mode-map (kbd "k") 'View-scroll-line-backward)
(define-key view-mode-map (kbd "h") 'backward-char)
(define-key view-mode-map (kbd "l") 'forward-char)
(define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
(define-key view-mode-map (kbd "?") 'View-search-regexp-backward)
(define-key view-mode-map (kbd "G") 'end-of-buffer)
(define-key view-mode-map (kbd "g") 'beginning-of-buffer)
(define-key view-mode-map (kbd "p") 'beginning-of-buffer)
(define-key view-mode-map (kbd "b") 'View-scroll-page-backward)
(define-key view-mode-map (kbd "f") 'View-scroll-page-forward)


;;; for bookmark
;; <http://www.bookshelf.jp/texi/emacs-man/21-3/jp/emacs_12.html#SEC79>
;; (setq bookmark-default-file (locate-user-emacs-file "bookmarks")) ; 保存先のファイル名
(setq bookmark-save-flag 1) ; ブックマーク情報を変更する度に (= 1回変更する度に) ファイルに保存
;; (setq bookmark-search-size 16) ; ブックマーク位置の前後何文字分の内容を保存するか. ブックマークは周辺の文脈情報と一緒に保存されるので、ファイルが少し変更されていたとしても正しい位置をみつけだせる.

;;; for uniquify
; 同名のバッファをわかりやすくする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;; for auto-compression-mode
;; 圧縮ファイルを find-file で自動的に展開
(auto-compression-mode)

;;; for yes/no
;; 削除確認等が yes/no の代わりに y/n で可能
(fset 'yes-or-no-p 'y-or-n-p)

;;; for recentf
;; -> <99-miscs.el> 参照

;;; for ffap (Find File At Point)
;; <www.emacswiki.org/emacs/FindFileAtPoint>
;; <http://www.gnu.org/software/emacs/manual/html_node/emacs/FFAP.html>
;; C-x C-f 時に, カーソル位置のファイルもしくは URL がデフォルトで設定される.
;; また, その他にも以下のようなキーバインドが設定される.
;; 
;;   C-x C-f filename <RET>
;;       Find filename, guessing a default from text around point (find-file-at-point).
;;   C-x C-r
;;       ffap-read-only, analogous to find-file-read-only.
;;   C-x C-v
;;       ffap-alternate-file, analogous to find-alternate-file.
;;   C-x d directory <RET>
;;       Start Dired on directory, defaulting to the directory name at point (dired-at-point).
;;   C-x C-d
;;       ffap-list-directory, analogous to list-directory.
;;   C-x 4 f
;;       ffap-other-window, analogous to find-file-other-window.
;;   C-x 4 r
;;       ffap-read-only-other-window, analogous to find-file-read-only-other-window.
;;   C-x 4 d
;;       ffap-dired-other-window, like dired-other-window.
;;   C-x 5 f
;;       ffap-other-frame, analogous to find-file-other-frame.
;;   C-x 5 r
;;       ffap-read-only-other-frame, analogous to find-file-read-only-other-frame.
;;   C-x 5 d
;;       ffap-dired-other-frame, analogous to dired-other-frame.
;;   M-x ffap-next
;;       Search buffer for next file name or URL, then find that file or URL.
;;   S-Mouse-3
;;       ffap-at-mouse finds the file guessed from text around the position of a mouse click.
;;   C-S-Mouse-3
;;       Display a menu of files and URLs mentioned in current buffer, then find the one you select (ffap-menu). 
;; 
;; <www.emacswiki.org/emacs/FindFileAtPoint>
;; <http://www.bookshelf.jp/soft/meadow_23.html#SEC231>
;; なお, 現在のモードに応じて適切なファイルを開く機能もある.
;; あるいは, 文字列パターンに応じて, 特殊なファイル名補完ルールを設定することもできる.
;; 設定は ffap-alist で行える.
;; 
;; 例: 
;;    lisp mode なら (require 'session) で session.el を開ける 
;;    CcMode and FortranMode header filenames like <stdio.h>.
;;    TeX path search (including BibTeX).
;;    RFC documents like RFC1945.
;; 
;; <= C や C++ なら，インクルードするファイルのあるパスを以下のようにして設定 できます．
;;      (setq ffap-c-path
;;            '("/usr/include" "/usr/local/include"))
;; <= Fortran なら
;;      (setq ffap-fortran-path '("../include" "/usr/include"))
;; <= TeX なら同じように「 ffap-tex-path 」を設定します． 

(ffap-bindings)
(global-set-key "\C-x\C-v" 'find-alternate-file)  ; ffap-alternate-file だけは肌に合わないので直しておく

;;;; RFC2472 で ffap をすると，日本語訳の RFC を表示できる
;; <http://www.bookshelf.jp/soft/meadow_23.html>
;; (setq ffap-rfc-path "http://www.minokasago.org/labo/RFC/rfc%s-jp.html") ; 

;;;; for avoiding wrong path detection
;; <www.emacswiki.org/emacs/FindFileAtPoint>
;; <http://d.hatena.ne.jp/ToMmY/20110916/1316180103>
;; <https://gist.github.com/tomykaira/1222035>
;; / が一部にはいっているものはなんでもファイル名だと判断するので、絶対パスや HTML の閉じタグまでパスだと判断される。
;; このせいで、HTMLファイルをあつかっているときは C-x C-f RET でいまのディレクトリに移動するという操作が非常にリスキーになっていたのだが、修正した。
;; 
;; 予期せぬ判定がおこなわれる時は、だいたい /hoge/piyo のようになっていて、 hoge も piyo も当然存在しないので、 "/" までさかのぼる。
;; "/" が結果として返されたときはだいたいミスっぽいわけで、このときは "/" を報告するのではなく、ミスでしたよ、と nil を返すことにする。
(defadvice ffap-file-at-point (after ffap-file-at-point-after-advice ())
  (if (string= ad-return-value "/")
      (setq ad-return-value nil)))
(ad-activate 'ffap-file-at-point)
;; (ad-deactivate 'ffap-file-at-point) ; 外したい場合

;;;; for my filelist (private)
(defvar ffap-my-filelist-path '())

(defun ffap-my-filelist (name)
  (ffap-locate-file name t ffap-my-filelist-path))
(setq ffap-alist (append ffap-alist '(("" . ffap-my-filelist))))

;; ~/howm 下のファイルはすぐ開けるようにする
;; (add-to-list 'ffap-my-filelist-path (expand-file-name "~/howm"))


;;; ;;; for tramp
;; ;; ~/.ssh/id_dsa があると, 何故か (require 'tramp) 時に何度も passphrase を聞かれる...
;; ;; 何か壊れてるのか??
;; ;; <= <http://lists.gnu.org/archive/html/help-gnu-emacs/2005-02/msg00471.html>
;; ;;    <http://lists.gnu.org/archive/html/help-gnu-emacs/2005-02/msg00475.html>
;; ;;    この事例に似ているような気がするが... こっちは結局どうなったんだ??
;; (require 'tramp)
;; ;; <http://www.gnu.org/software/tramp/#Password-handling>
;; (setq password-cache-expiry nil)	; 一度保存したパスワードは時間制限無しでキャッシュする

;;; for shell-mode
(setq explicit-shell-file-name "/bin/bash")
;(setq explicit-shell-file-name "/bin/zsh")

(require 'shell)
; 同一の入力は一つにまとめる
(setq comint-input-ignoredups t)
; M-p/n で現在の入力に応じて履歴検索
(define-key comint-mode-map [?\M-p] 'comint-previous-matching-input-from-input)
(define-key comint-mode-map [?\M-n] 'comint-next-matching-input-from-input)
(define-key shell-mode-map [?\M-p] 'comint-previous-matching-input-from-input)
(define-key shell-mode-map [?\M-n] 'comint-next-matching-input-from-input) 
; パスワードが見えないように
(add-hook 'comint-output-filter-functions
	  'comint-watch-for-password-prompt)

;;; for ediff mode
(setq ediff-window-setup-function 'ediff-setup-windows-plain)


;;; for outline mode
(setq outline-minor-mode-prefix "\C-c")

(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)

;;;; for outline mode & isearch
(custom-set-variables '(search-invisible nil)) ; isearch で非表示部分は見ない


;;; for eldoc
;; <http://www.emacswiki.org/emacs/ElDoc>
;;   elisp モードにおいて, 関数シンボルにカーソルが触れるとミニバッファに説明が表示されるようになるマイナーモード.
;; <http://d.hatena.ne.jp/rubikitch/20090207/1233936430>
;;   eldocはEmacs Lisp（他言語も一部対応）でカーソル位置の関数の仮引数をエコーエリアに表示してくれるやつ。
;;   標準添付だし、Emacs Lisp書く人ならふつー入れてるよね。
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; 
;; (setq eldoc-echo-area-use-multiline-p t)

;; for integrate emacs kill-ring and X11 cut-buffer.
;(setq x-select-enable-clipboard t)


;;; for customize

;;;; customize の出力先 
;;-- (デフォルトでは .emacs.el に出力する. custom-file という変数を設定しておくと変更できる)
(setq custom-file (locate-user-emacs-file ".emacs.custom.el"))

;;;; customize file があれば load する
(if (file-exists-p (expand-file-name custom-file))
    (load (expand-file-name custom-file) t nil nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; for artist mode
(defun artist-forward-char*4 ()
  (interactive)
  (artist-forward-char 4))
(defun artist-backward-char*4 ()
  (interactive)
  (artist-backward-char 4))
(defun artist-next-line*4 ()
  (interactive)
  (artist-next-line 1)
  (artist-next-line 1)
  (artist-next-line 1)
  (artist-next-line 1))
(defun artist-previous-line*4 ()
  (interactive)
  (artist-previous-line 4))
(add-hook 'artist-mode-init-hook
	  '(lambda ()
	     (local-set-key [?\C-\S-f] 'artist-forward-char*4)
	     (local-set-key [?\C-\S-b] 'artist-backward-char*4)
	     (local-set-key [?\C-\S-n] 'artist-next-line*4)
	     (local-set-key [?\C-\S-p] 'artist-previous-line*4)))

;;; for semantic (temporary commented out)
;; <http://www.gnu.org/software/emacs/manual/html_node/semantic/index.html#Top> : Semantic Manual
;; elisp で書かれたプログラミング言語のパーサー.
;; CEDET プロジェクトの一部??
;; パース結果を使って, imenu や speedbar, whichfunc, hippie-expand 等を強化できる.
; (semantic-mode 1)  ; semantic を有効にする


;;; for imenu
(custom-set-variables '(imenu-max-items 5000))
(custom-set-variables '(imenu-max-item-length 500))

(require 'cl)
(require 'imenu)

;;;; imenu を使用するメジャーモードの選択
;; java-mode と javascript-mode で which-func を使う場合
; (setq which-func-modes (append which-func-modes '(java-mode javascript-mode)))  ; which-func を使用するメジャーモード. t なら利用可能な全てのメジャーモードで使う. デフォルトは t.

;;;; for which-func
;; <http://dev.ariel-networks.com/Members/matsuyama/imenu/>
;; imenu のインデックスを用いて、現在どの関数を編集しているか（Which Function）をモードラインに表示してくれる機能です。
;; which-func という名前は、単に関数のインデックスがよく作られるからそのように名付けられたのですが、一般的には which-func はポイント付近にあるインデックスの項目名を表示する機能と言えます。
(require 'which-func)
(which-func-mode t)

;;;; for semantic 連携
;; <http://d.hatena.ne.jp/whitypig/20100329/1269817326>
;;   <http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html>
;; <http://dev.ariel-networks.com/Members/matsuyama/imenu/>
;; CEDET [4] / Semantic を使うと、標準のインデックスより詳細なインデックスを利用できるようになります [5] 。
;; 
;; <= でも, helm から使うと C-z のチラ見の際に変になるんだよなぁ...
;;    <= なんかちかちか点滅してくれるのが原因か？ そんなのを頑張ってくれなくても...
;;    <= helm-imenu は諦めて, helm-semantic-or-imenu を使うことにする??
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)


;;; for speedbar
;; <http://www.emacswiki.org/emacs/SpeedBar>
(require 'speedbar)

;;;; speedbar の対象にするメジャーモードの設定
;; <http://www.miura-takeshi.com/2010/0121-100438.html>
(add-hook 'speedbar-mode-hook
          '(lambda ()
             (speedbar-add-supported-extension '("howm"))))

;;;; 起動時にオンにする  (<= うるさいので要らないか)
; (when window-system          ; start speedbar if we're using a window system
;   (speedbar t))

;;;; 別フレームではなく, 同じフレーム内に出す設定
(defconst my-speedbar-buffer-name "SPEEDBAR")
; (defconst my-speedbar-buffer-name " SPEEDBAR") ; try this if you get "Wrong type argument: stringp, nil"

(defun my-speedbar-no-separate-frame ()
  (interactive)
  (when (not (buffer-live-p speedbar-buffer))
    (setq speedbar-buffer (get-buffer-create my-speedbar-buffer-name)
	  speedbar-frame (selected-frame)
	  dframe-attached-frame (selected-frame)
	  speedbar-select-frame-method 'attached
	  speedbar-verbosity-level 0
	  speedbar-last-selected-file nil)
    (set-buffer speedbar-buffer)
    (speedbar-mode)
    (speedbar-reconfigure-keymaps)
    (speedbar-update-contents)
    (speedbar-set-timer 1)
    (if (fboundp 'make-local-hook)
	(make-local-hook 'kill-buffer-hook))
    (add-hook 'kill-buffer-hook
	      (lambda () (when (eq (current-buffer) speedbar-buffer)
			   (setq speedbar-frame nil
				 dframe-attached-frame nil
				 speedbar-buffer nil)
			   (speedbar-set-timer nil)))))
  (set-window-buffer (selected-window) 
		     (get-buffer my-speedbar-buffer-name)))

;;-- <http://www.bookshelf.jp/pukiwiki/pukiwiki.php?%A5%C7%A5%A3%A5%EC%A5%AF%A5%C8%A5%EA%A4%F2%CA%CC%A5%A6%A5%A3%A5%F3%A5%C9%A5%A6%A4%C7%B0%EC%CD%F7%A1%BDspeedbar>
; (defun my-speedbar-expand-line ()
;   (interactive)
;   (if (= (point-max) (progn (speedbar-expand-line) (point-max)))
;       (save-current-buffer
;         (speedbar-edit-line))))
; 
; (require 'speedbar)
; ;; "a" で無視ファイル表示/非表示のトグル
; (define-key speedbar-file-key-map "a" 'speedbar-toggle-show-all-files)
; ;; ← や → でもディレクトリを開閉 ;;デフォルト: "=" "+", "-"
; (define-key speedbar-file-key-map [right] 'my-speedbar-expand-line)
; (define-key speedbar-file-key-map "\C-f" 'my-speedbar-expand-line)
; (define-key speedbar-file-key-map [left] 'speedbar-contract-line)
; (define-key speedbar-file-key-map "\C-b" 'speedbar-contract-line)
; ;; BS でも上位ディレクトリへ ;;デフォルト: "U"
; (define-key speedbar-file-key-map [backspace] 'speedbar-up-directory)
; (define-key speedbar-file-key-map "\C-h" 'speedbar-up-directory)
; 
; ;; 起動位置を直接指定する
; (setq speedbar-frame-parameters
;       (append (list '(top . 40)
; 		    '(left . 780)
; 		    '(width . 25))
; 	      speedbar-frame-parameters))
; 
; ;; Speedbar で表示するファイルタイプ
; (setq speedbar-supported-extension-expressions
;       (append '(".el" ".[ch]\\(pp\\|\\+\\+\\)?" ".java" ".tex\\(i\\(nfo\\)?\\)?"
; 		".s?html?" ".xml" ".dtd" ".css" ".js"
; 		".gif" ".jpe?g" ".png")))
; 
; ;; F4 で Speedbar
; (global-set-key [f4] 'speedbar-get-focus)



;;; for auto-insert
(require 'autoinsert)
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory (locate-user-emacs-file "autoinsert-template/"))  ; 注: 最後は'/'で終わらないといけない
(setq auto-insert-alist
      (append '(
                (c-mode . "c-template.c")
		(awk-mode . "awk-template.awk")
                ) auto-insert-alist))
