
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
	 
	 (setq default-buffer-file-coding-system 'utf-8)
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

;; ;;;; emacsclientからの接続時処理
;; ;; <= server-visit-hook は使いにくいので after-make-frame-functions を使うことにした
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
		    (set-frame-font "DejaVu Sans Mono-10")
		    (set-fontset-font (frame-parameter nil 'font)
				      'japanese-jisx0208
				      '("IPAGothic" . "unicode-bmp"))
	    ;; ウィンドウサイズの設定
		    ;(maximize-screen frame)))  ; ウィンドウサイズを最大化.
		    (set-frame-size frame 
			     118 72)))  ; ウィンドウサイズを変更 (最大化するとanything等使用時にフリーズする. compizが悪い？)
	      ))


;;; ;;; for font-lock (<= 最近はデフォルトでオンになっている模様. まぁ当たり前か...)
;; (if window-system
;;     (progn
;; ;      (setq font-lock-support-mode 'lazy-lock-mode)
;;       (global-font-lock-mode t)
;; ;      (setq font-lock-support-mode 'fast-lock-mode)
;;       (setq fast-lock-cache-directories '("~/.emacs-flc"))
;;        ))

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
(if (eq window-system 'x) ;if use X-Window, 'x
        (progn
          (define-key function-key-map [backspace] [8])
          (put 'backspace 'ascii-character 8)))
;(load "term/bobcat")
; bobcat が効かないので 21.3 のころの bobcat の中身を張っとく
(let ((the-table (make-string 128 0)))
  (let ((i 0))
    (while (< i 128)
      (aset the-table i i)
      (setq i (1+ i))))
  ;; Swap ^H and DEL
  (aset the-table ?\177 ?\^h)
  (aset the-table ?\^h ?\177)
  (setq keyboard-translate-table the-table))

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

;;; for C-x 3
;ウインドウ分割時に画面外に出てしまう文章を折り返す。
(setq truncate-partial-width-windows nil)

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
;;;; FYI: <http://www.gnu.org/software/emacs/manual/html_node/emacs/Clipboard.html>
;;;;
;;;;<http://dan-project.blog.so-net.ne.jp/2012-11-25>
;;;;Emacs 24 で yank の仕様が変更された.
(if (>= emacs-major-version 24)
    (progn
      (setq select-active-regions nil)      ; これは Emacs 23.1 の挙動. 22 の挙動が好ければ t にする (範囲選択するだけで着るリングにコピーするようになる)
      (setq x-select-enable-clipboard nil)
      (setq x-select-enable-primary t)
      (setq mouse-drag-copy-region t)))

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

;;;; 
(defun my-kill-ring-save ()
  (interactive)
  ;(kill-ring-save (point) (mark))
  (clipboard-kill-ring-save (point) (mark))
  (exchange-point-and-mark)
  (sit-for 0.8)
  (exchange-point-and-mark))
(defun my-kill-region ()
  (interactive)
  ;(kill-ring-save (point) (mark))
  (clipboard-kill-region (point) (mark))
  ;(exchange-point-and-mark)
  ;(sit-for 0.8)
  ;(exchange-point-and-mark)
  )
(global-set-key "\C-w" 'my-kill-ring-save)
(global-set-key "\M-w" 'my-kill-region)


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
	     "fiber" "gmplayer * >/dev/null &"))
        ("\\.html\\|\\.htm"
	 (if (eq system-type 'windows-nt)
	     "www-browser" "x-www-browser"))
        ("\\.pdf\\'" "evince * &")
        ("\\.iso\\'" "isoinfo -l -i")
	)
      )

;;; for uncomment-region
(add-hook 'c-mode-hook
	  '(lambda () (local-set-key "\C-c\C-u" 'uncomment-region)))

;;; for view-mode
;; <http://www.emacswiki.org/emacs/ViewMode>
;; C-x C-q で view-mode
(setq view-read-only t)

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

;;; for recentf-mode
; <http://d.hatena.ne.jp/tomoya/20110217/1297928222>
; 開いたファイルは、recentf-save-file に設定されているファイル (デフォルトでは ~/.recentf) に記録される
; 保存のタイミングは、Emacs の終了時か、recentf-mode をオフにしたときなので、強制終了した場合は、残念ながら保存されません。
(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))
; Emacs には操作していない時間に、何か裏で作業をさせるためのアイドルタイマーという機能があります。これを利用すると、ぼーっと考えている時間を利用して、自動的にあれこれ保存させることが出来るというわけです。
; recentf-auto-cleanup は、ファイルに保存する前に .recentf に保存するための情報を整理してくれます。これもアイドルタイマーを利用してくれます。
; 実際に自動保存の部分は (run-with-idle-timer 30 t 'recentf-save-list) という記述となっています。run-with-idle-timer 関数に「時間」と「2度目も実行するかどうか」、そして実行したい関数を指定します。


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
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; for integrate emacs kill-ring and X11 cut-buffer.
;(setq x-select-enable-clipboard t)


;;; for customize

;;;; customize の出力先 
;;-- (デフォルトでは .emacs.el に出力する. custom-file という変数を設定しておくと変更できる)
(setq custom-file "~/.emacs.d/.emacs.custom.el")

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

;;; for speedbar
;;-- <http://www.emacswiki.org/emacs/SpeedBar>
(require 'speedbar)

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
(load "autoinsert") 
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/emacs/template/")
(setq auto-insert-alist
      (append '(
                (c-mode . "c-template.c")
		(awk-mode . "awk-template.awk")
                ) auto-insert-alist))
