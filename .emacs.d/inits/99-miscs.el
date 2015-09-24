;;; (諸注意等, Tips 等)
;;;; 非標準パッケージの初期化について
;; require は第三引数で t を渡すと, 失敗してもエラーにならず, nil を返すだけになる.
;; 実際にパッケージがある場合にだけ初期化処理をしたい, といった場合に有効.
;;  
;;   例: (when (require 'php-mode nil t) 
;; 	   ... ) 

;;;; 外部プログラムに依存するパッケージの初期化について
;; executable-find で外部プログラムの有無を調べることが可能.
;;  
;;   例: (when (executable-find "git") 
;; 	   (require 'egg nil t))          ;; git があるときだけ egg を読み込む


;;; for auto-install (旧称 install-elisp)
; ;; <http://www.emacswiki.org/emacs/AutoInstall>
; ;; <http://d.hatena.ne.jp/keyword/install-elisp>
; ;;   簡単なelispインストーラ。探したけどなぜか存在しなかったのでid:rubikitchが作成した。
; ;;   ダウンロード、~/.emacs.dへの保存、バイトコンパイル、現在のEmacsセッションへのロードを自動化する。
; ;;   install-elisp.elをインストールすることでインターネット上にあるelispを「M-x install-elisp elispのURL」でダウンロードする。
; ;;   ダウンロード後、本当にインストールする場合は「C-c C-c」を押すと保存～ロードを自動でやってくれる。
; ;; 
; ;;   現在、install-elisp.elの後継バージョンとしてauto-install.elが作成されている。現メンテナは id:rubikitch である。
; ;;   auto-install.elは非同期化や複数のファイルにまたがるパッケージのインストールなどがサポートされている。
; ;;   (auto-install-compatibility-setup) を.emacsに入れておけばinstall-elisp.elとの互換性を保つことができる。
; ;; 
; ;; 使い方:
; ;;   * M-x install-elisp (= auto-install-from-url)
; ;;   * M-x install-elisp-from-emacswiki (= auto-install-from-emacswiki)
; ;;   * M-x install-elisp-from-gist (= auto-install-from-gist)
; ;;   * M-x auto-install-batch  
; ;;     <http://www.emacswiki.org/emacs/AutoInstall#toc9>
; ;;     複数ファイルからなる elisp 用. 特定の elisp にのみ対応 (anything, icicles, 等).
; ;;  
; ;;   Type “C-c C-c” to continue the install process.
; ;;   Type “C-c C-d” to view differences from the old version. This does nothing if you have no older version.
; ;;   Type “C-c C-q” to abort the install process.
;  
; (require 'auto-install)
;  
; ;; EmacsWiki からパッケージ名を取得する
; (auto-install-update-emacswiki-package-name t)
;  
; ;; install-elisp.el と互換の挙動にする
; (auto-install-compatibility-setup)
;  
; ;;;; インストール先のディレクトリの設定
; ;; (setq auto-install-directory "~/.emacs.d/auto-install/")   ; デフォルト設定のまま
; (add-to-list 'load-path auto-install-directory)
;  
; ;;;; プロキシの設定
; ;; wget を使うようにする設定 (http_proxy 環境変数で proxy を超えられるようになる. デフォルトで t)
; ;; (setq auto-install-use-wget t)
;  
; ;; wget を使わない場合は url-proxy-services をセットすればいい模様?
; ;; (setq url-proxy-services '(("http" . "localhost:8339")))


;;; for color-theme
;;;; for solarized theme
(if (< emacs-major-version 24)
    (progn
      (when (require 'color-theme)
	(color-theme-initialize)
	;; color-theme-solorized.el
	(when (require 'color-theme-solarized)
					;(color-theme-solarized-light)
	  (color-theme-solarized-dark)
	  ))))
(if (>= emacs-major-version 24)
    (load-theme 'solarized t))

;;;; for zenburn theme
;; (if (< emacs-major-version 24)
;;     (progn
;;       (require 'color-theme-zenburn)
;;       (color-theme-zenburn)))
;; (if (>= emacs-major-version 24)
;;     (load-theme 'zenburn t))

  ;; 以下は古い設定
  ;(require 'color-theme)
  ;(color-theme-andreas)


;;; for elscreen
(require 'elscreen)
(elscreen-start)
; (load "elscreen" "ElScreen" t)
(global-set-key "\C-z\C-z" 'suspend-emacs)
(setq 
;;  elscreen-default-buffer-name "*scratch*"
;;  elscreen-prefix-key ""
;;  elscreen-display-screen-number t ; If non nil, show the number of the current screen in mode line
;;  elscreen-buffer-to-nickname-alist 
;; ;         The pairs of buffer-name and corresponding screen nickname,
;; ;         which are listed by 'elscreen-display-screen-name-list'
;; ;         only when major-mode cannot determine its screen nickname.
;; ; 	The default value is:
;;  '(("^wl-" . "Wanderlust")
;;    ("^mew-" . "Mew")
;;    ("^irchat-" . "IRChat")
;;    ("^liece-" . "Liece")
;;    ("^dired-mode$" . "Dired")
;;    ("^Info-mode$" . "Info")
;;    ("^lookup-" . "Lookup"))

;;  elscreen-mode-to-nickname-alist
;; ;         The pairs of major-mode and corresponding screen nickname,
;; ;         which are listed by 'elscreen-display-screen-name-list'.
;; ;         The default value is:
;;  '(("[Ss]hell" . "shell")
;;    ("compilation" . "compile")
;;    ("-telnet" . "telnet")
;;    ("dict" . "OnlineDict")
;;    ("*WL:Message*" . "Wanderlust"))

 elscreen-display-tab nil ;(only for GNU Emacs 21)
;;  elscreen-tab-width 16 ;(only for GNU Emacs 21)

;;  elscreen-tab-display-create-screen t ;(only for GNU Emacs 21)
;; ;         If non nil, display the tab (labeled with [!]) to create
;; ;         screen at the most left side of the tab line.  The default
;; ;         value is `t'.

;;  elscreen-tab-display-kill-screen t ;(only for GNU Emacs 21)
;; ;         If non nil, display the icon ([X]) to kill corresponding
;; ;         screen.  The default value is `t'.
)
;(load "elscreen-w3m")  ; 細かいところがまだ不十分


;;; ;; for w3m
; (push "/usr/local/share/emacs/site-lisp/w3m/" load-path)
; (add-to-list 'exec-path "/usr/local/bin")
;; (unless (string-match "[:^]/usr/local/bin/?[:$]" (getenv "PATH"))
;;   (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH"))))
;; (autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
;; (autoload 'w3m-find-file "w3m" "w3m interface function for local file." t)
;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; (autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)
;; (autoload 'w3m-weather "w3m-weather" "Display weather report." t)
;; (autoload 'w3m-antenna "w3m-antenna" "Report change of WEB sites." t)

;(require 'w3m-load)
;(setq browse-url-browser-function 'w3m-browse-url)
;(global-set-key "\C-xm" 'browse-url-at-point)
;(add-hook 'w3m-mode-hook
;	  (lambda () (local-set-key [up] 'scroll-down-just-one)))
;(add-hook 'w3m-mode-hook
;	  (lambda () (local-set-key [down] 'scroll-up-just-one)))
;;for wget
;(autoload 'wget "wget" "wget interface for Emacs." t)
;(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)
;(load "w3m-wget")

;;;; for w3m-session
;(require 'w3m-session)
;(setq w3m-session-file "~/.emacs.d/w3m-session")
;(setq w3m-session-save-always t)
;(setq w3m-session-load-always nil)
;(setq w3m-session-show-titles t)
;(setq w3m-session-duplicate-tabs 'ask) ;  'never, 'always, 'ask

;;; for shell-toggle
;;;; for original shell-toggle
(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing." t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd \" command." t) 
(global-set-key "\M-s" 'shell-toggle)

;;;; ;; for patched shell-toggle (ansi-term)
;; (load-library "shell-toggle-patched.el")
;; (autoload 'shell-toggle "shell-toggle"
;;   "Toggles between the *shell* buffer and whatever buffer you are editing." t)
;; (autoload 'shell-toggle-cd "shell-toggle"
;;   "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
;; (global-set-key "\M-s" 'shell-toggle)
;; (setenv "SHELL" "bash")

;;;; C-z は elscreen 用
(add-hook 'term-mode-hook '(lambda ()
                             (define-key term-raw-map "\C-z"
                               (lookup-key (current-global-map) "\C-z"))))

;;;; ;; ansi-term の 「C-c を C-x のエイリアスにする」という設定はやめる
;(term-set-escape-char ?\C-x)


;;;; 最近の dired-mode では \M-s が別のコマンドに割り当てられているので, 明示的に上書き
(add-hook 'dired-mode-hook
	  '(lambda () (local-set-key "\M-s" 'shell-toggle)))


;;; for sdic
;;;; sdic-mode 用の設定
(autoload 'sdic-describe-word
  "sdic" "英単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point
  "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word-at-point)

;;;; 英和検索で使用する辞書
(setq sdic-eiwa-dictionary-list
      '(
        (sdicf-client
         "~/dict/eijirou.sdic")
       ))
;;;; 和英検索で使用する辞書
(setq sdic-waei-dictionary-list
      '(
        (sdicf-client
         "~/dict/waeijirou.sdic")
        ))

;;;; 見出し語のフォント
;(setq sdic-face-style 'bold) ; これがデフォルト
;;;; 見出し語の色
(setq sdic-face-color "Blue")

;;;; 
(setq strategy "array")
;(add-to-list 'exec-path "~/bin") ; for array, mkary


;;; for session management (session.el, recentf, etc)
;;;   for session.el
;; <http://www.emacswiki.org/emacs/EmacsSession>
;; 変数の中身やレジスタの中身, カーソルの位置などを記憶しておいて, 次の Emacs 起動時に復元してくれる
;; (C-x C-fの履歴, M-x grepの履歴, kill-ring, 検索／置換の履歴, 各ファイルにおけるカーソル位置, など)
;; 情報は ~/.session に保存される.
;; 
;;   Session restores various variables (e.g., input histories) from your last session. 
;;   It also provides a menu containing recently changed/visited files and restores the places (e.g., point) of such a file when you revisit it.
;; 
;; (ミニバッファの履歴が復元されるのは, 元々 minibuffer-history という変数で履歴が管理されているため
;;  <= より正確には, minibuffer-history-variable という変数が指すシンボル名の変数で管理されている)
;; 
;; <http://d.hatena.ne.jp/whitypig/20110331/1301521329>
;; <http://maruta.be/intfloat_staff/101>
(when (require 'session nil t)
  (setq session-save-file-coding-system 'utf-8-unix)
  ; (setq session-save-file (expand-file-name "~/.emacs.d/.session")) ; 保存対象のファイル名
  ; (setq session-initialize '(session places))  ; 復元対象. デフォルトは t で「全て復元」の意.
  (setq session-globals-max-size 1024)  ; 
  (setq session-globals-max-string (* 1024 1024))  ; これが小さいと保存件数を大きくしても意味が無い
  (setq session-globals-include '((kill-ring 1024)             ;; kill-ring の保存件数
                                  (session-file-alist 1024)    ;; カーソル位置を保存する件数
                                  (file-name-history 1024)     ;; ミニバッファに入力されたファイル履歴の一覧を保存する件数 (recentf とは別)
				  ))
  (add-hook 'after-init-hook 'session-initialize)
  ;; Save session info every 30 minutes
  (setq my-timer-for-session-save-session (run-at-time t 1800 'session-save-session)))

;; <http://elim.hatenablog.com/entry/2012/11/07/022233> : anything-browse-kill-ring と session.el 
;; Anything と session.el を一緒に使うなら, 以下を .emacs に追加すること.
(setq session-save-print-spec '(t nil nil))

;;;   for recentf-mode
; <http://d.hatena.ne.jp/tomoya/20110217/1297928222>
; 開いたファイルは, recentf-save-file に設定されているファイル (デフォルトでは ~/.recentf) に記録される
; 保存のタイミングは、Emacs の終了時か、recentf-mode をオフにしたときなので、強制終了した場合は、残念ながら保存されません。
(custom-set-variables '(recentf-save-file (locate-user-emacs-file ".recentf")))  ; 履歴の保存先
(require 'recentf)
(setq recentf-max-saved-items 200000)
; (setq recentf-max-menu-items 20) ; メニューでの表示件数. メニューはほとんど見ないから関係ないけど...
(setq recentf-exclude '(".recentf"))
(setq recentf-auto-cleanup 10)
(setq recentf-auto-save-timer
      (run-with-idle-timer 30 t 'recentf-save-list))
(recentf-mode 1)
; Emacs には操作していない時間に、何か裏で作業をさせるためのアイドルタイマーという機能があります。これを利用すると、ぼーっと考えている時間を利用して、自動的にあれこれ保存させることが出来るというわけです。
; recentf-auto-cleanup は、ファイルに保存する前に .recentf に保存するための情報を整理してくれます。これもアイドルタイマーを利用してくれます。
; 実際に自動保存の部分は (run-with-idle-timer 30 t 'recentf-save-list) という記述となっています。run-with-idle-timer 関数に「時間」と「2度目も実行するかどうか」、そして実行したい関数を指定します。

;;;   for recentf-ext
;; <http://d.hatena.ne.jp/rubikitch/20091224/recentf>
;; * ファイルを使うってことは、べつにfind-fileに限らない。switch-to-bufferでファイルバッファにアクセスすることも含まれるだろう。
;;   ってなことで、前者はバッファを表示した時点でファイルを使ったとみなすことにする。
;; * ディレクトリだってファイルの一種なのでディレクトリだけ差別するのは不公平だ。だからdiredバッファもrecentfで扱うようにしてみた。
(require 'recentf-ext)

;;;   ミニバッファの履歴を無制限で記録
(setq history-length t) ; ミニバッファの履歴を無制限で記録

;;;   undo の履歴数を増やしておく
;; とりあえず倍にしておく
(setq undo-limit 160000)
(setq undo-strong-limit 240000)


;;; for ffap
;;;   for ffap-
;; <http://www.emacswiki.org/emacs/ffap-.el>
;; dired-mode では ffap を使わないようにする
(require 'ffap-)

;;;   for スペースを含むパス
;; <http://www.bookshelf.jp/soft/meadow_23.html>
;;  「 C:/Program Files/」のようにスペースを含むパスが書いてあると ffap が認識してくれ ないことがあります． 
;;  リージョンで選択することで強制的に認識させることができます． 
;;  (ffap で認識されなかったら，リージョンでパスを選択し，C-x C-fとします)

(defun my-find-file-at-point-or-region (&optional arg)
  "Find filename at point or selected by region.
   This function is useful, when filename contain spaces, and so
   can't be fully found by `find-file-at-point'. In this case user
   should manually select full filename and invoke this command.
   Also maps UNIX filenames to Window$ filenames."
  (interactive "P")
  (let ((filename
	 (if (and transient-mark-mode mark-active)
	     (buffer-substring-no-properties (mark) (point))
	   (ffap-string-at-point))))
    (and (eq system-type 'windows-nt)
	 filename
	 (string-match "^/dos/\\([A-Za-z]\\)\\(.*\\)" filename)
	 (setq filename
	       (concat (match-string 1 filename)
		       ":" (match-string 2 filename))))
    (or (and filename (file-exists-p filename))
	(setq filename (ffap-guesser)))
    (if (and filename (file-directory-p filename))
	(setq filename (file-name-as-directory filename)))
    (find-file-at-point (ffap-prompter filename))))

(define-key global-map "\C-x\C-f" 'my-find-file-at-point-or-region)

;;;   for linenumber ("filename:line" 型の書式) に対応する
;; <http://www.emacswiki.org/emacs/FindFileAtPoint>
;; こちらはプロンプトも聞かずに即座にジャンプする. 
;; C-x C-f とはちょっと違う使い勝手だけどめちゃくちゃスムーズではある.
;; 
;; <= (ffap-file-at-point) を (ffap-prompter) に置き換えると C-x C-f の上位互換っぽくなる.
;; 
;; (defun my-find-file-at-point-with-line ()
;;   "Opens the file at point and goes to line-number."
;;   (interactive)
;;   (let ((fname (ffap-file-at-point)))
;;     (if fname
;;  	(let ((line
;;  	       (save-excursion
;;  		 (goto-char (cadr ffap-string-at-point-region))
;;  		 (and (re-search-backward ":\\([0-9]+\\)"
;;  					  (line-beginning-position) t)
;;  		      (string-to-int (match-string 1))))))
;;  	  ;; (message "file:%s,line:%s" fname line)
;;  	  (when (and (tramp-tramp-file-p default-directory)
;;  		     (= ?/ (aref fname 0)))
;;  	    ;; if fname is an absolute path in remote machine, it will not return a tramp path,fix it here.
;;  	    (let ((pos (position ?: default-directory)))
;;  	      (if (not pos) (error "failed find first tramp indentifier ':'"))
;;  	      (setf pos (position ?: default-directory :start (1+ pos)))
;;  	      (if (not pos) (error "failed find second tramp indentifier ':'"))
;;  	      (setf fname (concat (substring default-directory 0 (1+ pos)) fname))))
;;  	  (message "fname:%s" fname)
;;  	  (find-file-existing fname)
;;  	  (when line (goto-line line)))
;;       (error "File does not exist."))))

;; <http://stackoverflow.com/questions/3139970/open-a-file-at-line-with-filenameline-syntax>
;; 以下のような実装方法もある模様
;; 
;; (defun find-file-at-point-with-line (&optional filename)
;;   "Opens file at point and moves point to line specified next to file name."
;;   (interactive)
;;   (let* ((filename (or filename (ffap-prompter)))
;;  	 (line-number
;;  	  (and (or (looking-at ".* line \\(\[0-9\]+\\)")
;;  		   (looking-at ".*:\\(\[0-9\]+\\):"))
;;  	       (string-to-number (match-string-no-properties 1)))))
;;     (message "%s --> %s" filename line-number)
;;     (cond ((ffap-url-p filename)
;;  	   (let (current-prefix-arg)
;;  	     (funcall ffap-url-fetcher filename)))
;;  	  ((and line-number
;;  		(file-exists-p filename))
;;  	   (progn (find-file-other-window filename)
;;  		  (goto-line line-number)))
;;  	  ((and ffap-pass-wildcards-to-dired
;;  		ffap-dired-wildcards
;;  		(string-match ffap-dired-wildcards filename))
;;  	   (funcall ffap-directory-finder filename))
;;  	  ((and ffap-dired-wildcards
;;  		(string-match ffap-dired-wildcards filename)
;;  		find-file-wildcards
;;  		;; Check if it's find-file that supports wildcards arg
;;  		(memq ffap-file-finder '(find-file find-alternate-file)))
;;  	   (funcall ffap-file-finder (expand-file-name filename) t))
;;  	  ((or (not ffap-newfile-prompt)
;;  	       (file-exists-p filename)
;;  	       (y-or-n-p "File does not exist, create buffer? "))
;;  	   (funcall ffap-file-finder
;;  		    ;; expand-file-name fixes "~/~/.emacs" bug sent by CHUCKR.
;;  		    (expand-file-name filename)))
;;  	  ;; User does not want to find a non-existent file:
;;  	  ((signal 'file-error (list "Opening file buffer"
;;  				     "no such file or directory"
;;  				     filename))))))

;;; for mic-paren
(require 'mic-paren)
(paren-activate)

;;; for gtags
(autoload 'gtags-mode "gtags" "" t)

;;; for cscope
; <https://github.com/dkogan/xcscope.el>
; 前と変わった? 前は apt のパッケージになってるやつを使ってたが, ELPA から入れたやつは改良版らしい.
;   "This is a continuation of the xcscope.el (by Darryl Okahata) that ships in the CVS tree of cscope itself. 
;    The code in the cscope tree is stable, so this tree expands on the original source, fixing various bugs and adding features."
(require 'xcscope)
(cscope-setup)

;;; for c-eldoc
;; <http://www.emacswiki.org/cgi-bin/wiki/CEldocMode>
;; <http://github.com/nflath/c-eldoc>
;; C 言語用の eldoc
(require 'c-eldoc)

(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
(add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)

;; ;; もし表示のディレイを短くしたいなら以下のような設定も可 (eldoc-idle-delay を設定)
;; (add-hook 'c++-mode-hook
;; 	  (lambda ()
;; 	    (set (make-local-variable 'eldoc-idle-delay) 0.20)
;; 	    (c-turn-on-eldoc-mode)))

;; プリプロセスで使用するコマンド
;; (setq c-eldoc-cpp-command "/usr/bin/cpp ")

;; プリプロセス時に暗黙的に設定する include path.
;; 
;; add in your commonly used packages/include directories here, for
;; example, SDL or OpenGL. this shouldn't slow down cpp, even if
;; you've got a lot of them
;; (setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../ ")

;;;; 「Function doesn't exist...」 と表示される場合
;; <http://hwada.hatenablog.com/entry/20100505/1273065205>
;; プリプロセスに失敗しているのかもしれません。
;; *ソースファイル名-preprocessed*バッファにコマンドの出力結果が出ているので、ここから原因を探せるかもしれません。
;; 自分はcppコマンドが見つからないよ、というメッセージを見てはじめてcppが必要なことに気づきました……。

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


;;; for dired
;;;   for bf-mode
;; -- diredでファイルの内容を表示
;(require 'bf-mode)
;;;;; list up file extensions which should be excepted
;(setq bf-mode-except-exts
;      (append '("\\.dump$" "\\.data$" "\\.mp3$" "\\.lnk$")
;              bf-mode-except-exts))
;;;;; list up file extensions which should be forced browsing
;(setq bf-mode-force-browse-exts
;      (append '("\\.txt$" "\\.and.more...")
;              bf-mode-force-browse-exts))
;;;;; browsable file size maximum
;(setq bf-mode-browsing-size 100) ;; 100 killo bytes
;;;;; browsing htmls with w3m (needs emacs-w3m.el and w3m)
;(setq bf-mode-html-with-w3m t)
;;;;; browsing archive file (contents listing) verbosely
;(setq bf-mode-archive-list-verbose t)
;;;;; browing directory (file listing) verbosely
;(setq bf-mode-directory-list-verbose t)
;;;;; start bf-mode immediately after starting dired
;(setq bf-mode-enable-at-starting-dired t)
;;;;; quitting dired directly from bf-mode
;(setq bf-mode-directly-quit t)  ; q で終了. b で toggle は変わらず


;;;   for dired-sorter
(load "sorter")

;;; for rd-mode
(autoload 'rd-mode "rd-mode" nil t)
(require 'rd-mode)

;;; for howm
(setq howm-compatible-to-ver1dot3 t) ;; 1.3.* どおりの挙動を望むなら.  (require 'howm) より前に!
(push (expand-file-name "/usr/share/emacs/site-lisp/howm") load-path)
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(global-set-key "\C-c,g" 'howm-list-grep)
(global-set-key "\C-c,a" 'howm-list-all)
(global-set-key "\C-c,c" 'howm-create)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))
;(define-key global-map [katakana] 'howm-menu) ; [カタカナ] キーでメニュー
;(setq howm-file-name-format "%Y/%m/%Y_%m_%d.howm") ; 1 日 1 ファイル
(setq howm-keyword-case-fold-search t) ; <<< で大文字小文字を区別しない
(setq howm-list-title t) ; 一覧時にタイトルを表示
(setq howm-menu-refresh-after-save nil) ; save 時にメニューを自動更新せず
(setq howm-refresh-after-save nil) ; save 時に下線を引き直さない
(setq howm-menu-expiry-hours 2) ; メニューを 2 時間キャッシュ
(add-to-list 'auto-mode-alist '("\\.howm$" . rd-mode)) ; メモは rd-mode に
;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))
;; howm高速化
(setq howm-view-use-grep t)

;;; for dabbrev-ja
;; <http://www.bookshelf.jp/soft/meadow_34.html#SEC504>
;; 日本語を入力して動的略語展開を実行しても，それなりの結果が得られます． 
;; (漢字との区切りなどを認識します)
(load "dabbrev-ja")


;;; for git-gutter
(require 'git-gutter)

;; git管理下のファイルについてすべて git-gutter-modeを有効にする場合
(global-git-gutter-mode t)
;; 特定の mode 時にのみ git-gutter-modeをにする場合 
;; inactivate git-gutter-mode in asm-mode and image-mode
;(setq git-gutter:disabled-modes '(asm-mode image-mode))

;; 特定の mode 時にのみ git-gutter-modeを有効にする場合 
;(add-hook 'cperl-mode-hook 'git-gutter-mode)
;(add-hook 'js2-mode-hook   'git-gutter-mode)
;(add-hook 'php-mode-hook   'git-gutter-mode)
;(add-hook 'ruby-mode-hook  'git-gutter-mode)


; key-bind settings
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
;; Revert current hunk
;(global-set-key (kbd "C-x r") 'git-gutter:revert-hunk)  ; <= 矩形処理と被る...

;更新頻度を少し下げる 
;; (window の更新時には git diff しない)
(setq git-gutter:update-hooks '(after-save-hook after-revert-hook))
;; 2 seconds
(setq git-gutter:update-threshold 2)

;;;; ;; for console mode (emacs -nw)
;(setq git-gutter:separator-sign "|")
;(set-face-foreground 'git-gutter:separator "yellow")

; 
;(setq git-gutter:modified-sign "  ") ;; two space
;(setq git-gutter:added-sign "++")    ;; multiple character is OK
;(setq git-gutter:deleted-sign "--")

;(set-face-background 'git-gutter:modified "purple") ;; background color
;(set-face-foreground 'git-gutter:added "green")
;(set-face-foreground 'git-gutter:deleted "red")

;(setq git-gutter:window-width 2)
;(setq git-gutter:modified-sign "☁")
;(setq git-gutter:added-sign "☀")
;(setq git-gutter:deleted-sign "☂")


;;; for outline
;;;   for outline
;;;; ;;; for outline-magic
;; (add-hook 'outline-mode-hook 
;;           (lambda () 
;;             (require 'outline-cycle)))
;; (add-hook 'outline-minor-mode-hook 
;;           (lambda () 
;;             (require 'outline-magic)
;;             (define-key outline-minor-mode-map (kbd "TAB") 'outline-cycle)))
;; 
;; (setq outline-cycle-emulate-tab t)

;;;   for outshine
;;;; 注意事項
;; 現は, デフォルトの状態では, elisp mode だけは ";;[;]+ " がヘッドラインになるように設定されている.
;; たし, 本文中に一つでも通常のヘッドライン (";; =+ " 等) にひっかかる物があれば特別扱いされなくなるので注意.

;;;; for rd-mode with outshine
;(custom-set-variables
; '(outshine-outline-regexp-outcommented-p nil))  ; RD-mode にはコメント書式はないので, outline-regexp は変えなくていい
(setq comment-start "")   ; RD-mode にはコメント書式はないので, padding は追加しなくていい (FIXME 他にも影響するので...)
(setq comment-padding 0)  ; RD-mode にはコメント書式はないので, padding は追加しなくていい (FIXME 他にも影響するので...)
(custom-set-variables
 '(outshine-regexp-base-char "="))
; <https://github.com/tj64/outshine/issues/8>
; とりあえず, 今のバージョンでは以下の流れで outline-regexp が決定されている.
;   outshine-regexp-base-char -> outshine-default-outline-regexp-base -> outshine-outline-regexp-base -> outshine-normalized-outline-regexp-base
; 大元の outshine-regexp-base-char を変更

;;;; for outshine
(require 'outshine)
(add-hook  'outline-minor-mode-hook 'outshine-hook-function)

;;;; キーバインドの変更 (C-<arrow> を移動に)
(define-key outline-minor-mode-map (kbd "C-<left>") 'outline-promote) 
(define-key outline-minor-mode-map (kbd "C-<right>") 'outline-demote) 
(define-key outline-minor-mode-map (kbd "C-<up>") 'outline-move-subtree-up) 
(define-key outline-minor-mode-map (kbd "C-<down>") 'outline-move-subtree-down) 

;;;; org-mode 用
; (add-hook 'org-mode-hook
;           (lambda ()
;             ;; Redefine arrow keys, since promoting/demoting and moving
;             ;; subtrees up and down are less frequent tasks then
;             ;; navigation and visibility cycling
;             (when (require 'outshine nil 'NOERROR)
;               (org-defkey org-mode-map
;                           (kbd "M-<left>") 'outline-hide-more)
;               (org-defkey org-mode-map
;                           (kbd "M-<right>") 'outline-show-more)
;               (org-defkey org-mode-map
;                           (kbd "M-<up>") 'outline-previous-visible-heading)
;               (org-defkey org-mode-map
;                           (kbd "M-<down>") 'outline-next-visible-heading)))
;           'append)


;;;   for outline mode in howm files
;; <http://ubulog.blogspot.jp/2007/10/emacs.html>
(defun rd-out-tree ()
  "outline-tree
見出しを別ウィンドウで表示させる.
by yama @ Thu Mar 29 23:37:45 2007"
  (interactive)

;  (if 'outline-minor-mode (outline-minor-mode))
;  (hide-body)

  (let* ((basename (princ (buffer-name)))
         (newtmp (concat basename "-tree")))
    (if (get-buffer newtmp)
        (unless (get-buffer-window newtmp)
            (split-window-vertically 10)
            (switch-to-buffer newtmp)
            (other-window 1))
      (progn
        (make-indirect-buffer (current-buffer) newtmp)
        (split-window-vertically 10)
        (switch-to-buffer newtmp)

;        (if 'outline-mode (outline-mode))
        (if 'rd-mode (rd-mode))

        (hide-sublevels 1)
        (other-window 1)))))

(defun rd-out-jump ()
  (interactive)
  (let* ((basename (princ (buffer-name)))
         (orig-buf-name (substring basename 0 -5))  ; バッファ名は "*-tree" だと想定
	 (line-num (count-lines 1 (point))))
    (other-window 1)
    (switch-to-buffer orig-buf-name)
    (goto-line line-num)))


;;; for hideshow (& other folding features)
;;;   for hideshow (& hideshowvis)
;; プログラムのソースコードに特化した outline-minor-mode のようなもの.
;; 
;;   hs-hide-block                      C-c @ C-h
;;   hs-show-block                      C-c @ C-s
;;   hs-hide-all                        C-c @ C-M-h
;;   hs-show-all                        C-c @ C-M-s
;;   hs-hide-level                      C-c @ C-l
;;   hs-toggle-hiding                   C-c @ C-c
;;   hs-mouse-toggle-hiding             [(shift mouse-2)]
;;   hs-hide-initial-comment-block
;;
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
 
;;;; 諸設定
;; コメントは、隠さず表示する。
(setq hs-hide-comments-when-hiding-all nil)
 
;; 隠した(hide)行は、isearchの対象にしない(outlineモードにも影響)
(setq search-invisible nil)  ;; 「'open」or「t」
 
;;;; ruby-mode 用の hs-special-modes-alist の設定
;; <http://sheepman.sakura.ne.jp/diary/?date=20050131#p03>
;; 
;; <apropos>
;; どういう文字列を対象にするかは hs-special-modes-alist で指定できる.
;; 
;;   Each element has the form
;;     (MODE START END COMMENT-START FORWARD-SEXP-FUNC ADJUST-BEG-FUNC).
;;   
;;   If non-nil, hideshow will use these values as regexps to define blocks
;;   and comments, respectively for major mode MODE.
;;   
;;   START, END and COMMENT-START are regular expressions.  A block is
;;   defined as text surrounded by START and END.
;;   
;;   As a special case, START may be a list of the form (COMPLEX-START
;;   MDATA-SELECTOR), where COMPLEX-START is a regexp w/ multiple parts and
;;   MDATA-SELECTOR an integer that specifies which sub-match is the proper
;;   place to adjust point, before calling `hs-forward-sexp-func'.  Point
;;   is adjusted to the beginning of the specified match.  For example,
;;   see the `hs-special-modes-alist' entry for `bibtex-mode'.
;;   
;;   For some major modes, `forward-sexp' does not work properly.  In those
;;   cases, FORWARD-SEXP-FUNC specifies another function to use instead.
;;   
;;   See the documentation for `hs-adjust-block-beginning' to see what is the
;;   use of ADJUST-BEG-FUNC.
;;   
;;   If any of the elements is left nil or omitted, hideshow tries to guess
;;   appropriate values.  The regexps should not contain leading or trailing
;;   whitespace.  Case does not matter.
;; 
(let ((ruby-mode-hs-info 
      '( ruby-mode
         "class\\|module\\|def\\|if\\|unless\\|case\\|while\\|until\\|for\\|begin\\|do"
         "end"
         "#"
         ruby-move-to-block
         nil)))
  (if (not (member ruby-mode-hs-info hs-special-modes-alist))
    (setq hs-special-modes-alist
      (cons ruby-mode-hs-info hs-special-modes-alist))))
 
;;;; カスタマイズ用の変数設定
;; ;; Hide the comments too when you do a 'hs-hide-all'
;; (setq hs-hide-comments nil)
;; ;; Set whether isearch opens folded comments, code, or both
;; ;; where x is code, comments, t (both), or nil (neither)
;; (setq hs-isearch-open 'x)
 
;; ;;;; 備考: hideshow を使った自作 elisp 用
;; hs-block-start-regexp, hs-block-end-regexp 
;;   ブロックの先頭／最後を表す正規表現
;; hs-block-start-mdata-select
;;   ...

;;;   for hideshow-org
;; <http://www.emacswiki.org/emacs/HideShow>
;; <https://github.com/shanecelis/hideshow-org>
;; org-mode のように Tab/S-Tab で hide/show できるようにする.
;; (Tab を押したときにカーソルが移動しなければ hideshow 機能が働く)
;; 
;; なお, 単に hideshow の機能を呼ぶだけなので
;; (例えば lisp モードなら行頭でも toggle される ('(' がブロック区切り文字なので).
;;  C モードなら '{' の中に移動しないと toggle されない)
;; 
;; (auto-install-from-url "https://raw.github.com/secelis/hideshow-org/master/hideshow-org.el")
(require 'hideshow-org)

;;;; キーバインド
;; I set this as my global key.
;;
;; (global-set-key "\C-ch" 'hs-org/minor-mode)
;;
;; Here are the keys in the minor mode.
;;
;; TAB       -- execute normal TAB command, if point doesn't move, try to
;;              toggle the visibility of the block.
;; <S-tab>   -- execute normal <S-tab> command, if point doesn't move, try to
;;              toggle the visibility of all the blocks.

;;;   hideshow を有効にするモードの設定
;; 結構使いにくいので無くてもいいかな...

;;(dolist (hook (list ;'emacs-lisp-mode-hook
;; 		    ;'lisp-interaction-mode-hook
;;                    'c++-mode-hook  
;; 		    'ruby-mode-hook 
;; 		    ))
;;  ;;(add-hook hook '(lambda() (hs-minor-mode 1)))  ; hs-show-mode を有効にする
;;  (add-hook hook 
;; 	    '(lambda()
;; 	       (hideshowvis-enable)   ; hideshowvis-mode を有効にする
;; 	       (hs-org/minor-mode)))  ; hideshow-org-mode を有効にする
;;  )


;;;   例: C# モード用の設定
;; <http://blogs.msdn.com/b/dotnetinterop/archive/2008/04/14/making-hideshow-el-work-with-csharp-mode-el-and-region-endregion.aspx>

;;;   ;;; その他のモードでも hideshow
;; ;; <http://www.emacswiki.org/emacs/HideShow>
;; ;; hideshow が対応してないモードでも 
;; ;; set-selective-display にフォールバックすれば似たような感じになる.
;; 
;; (defun toggle-selective-display (column)
;;   (interactive "P")
;;   (set-selective-display
;;    (or column
;;        (unless selective-display
;; 	 (1+ (current-column))))))
;; 
;; (defun toggle-hiding (column)
;;   (interactive "P")
;;   (if hs-minor-mode
;;       (if (condition-case nil
;; 	      (hs-toggle-hiding)
;; 	    (error t))
;; 	  (hs-show-all))
;;     (toggle-selective-display column)))
;; 
;; (global-set-key (kbd "C-+") 'toggle-hiding)
;; (global-set-key (kbd "C-\\") 'toggle-selective-display)


;;;   for hideif (hide-ifdefs)
;; <>
;; C-c @ C-d	hide-ifdef-block
;;   カーソル地点の ifdef を隠す
;; C-c @ C-s	show-ifdef-block
;;   カーソル地点の ifdef を表示する
;; 
;; C-c @ h		hide-ifdefs
;;   全ての ifdef を隠す
;; C-c @ s		show-ifdefs
;;   全ての ifdef を表示
;; C-c @ d		hide-ifdef-define
;;   指定したマクロ定数が #define されたことにする (hide-ifdefs 時に非表示にならない)
;; C-c @ u		hide-ifdef-undef
;;   指定したマクロ定数の #define を解除する
;; C-c @ D		hide-ifdef-set-define-alist
;;   
;; C-c @ U		hide-ifdef-use-define-alist
;;   
;;   
;; C-c @ C-w	hide-ifdef-toggle-shadowing
;;   ??
;; C-c @ C-q	hide-ifdef-toggle-read-only
;;   非表示状態では read-only にするかどうかを切り替える
 
(dolist (hook (list 'c-mode-hook
                    'c++-mode-hook
 		    ))
  (add-hook hook 
 	    '(lambda() (hide-ifdef-mode t)))
  )

;;; for imenu
;; outline 系のモードでは, ヘッドラインを表示させてみる.
;;;; for elisp mode
;; <http://d.hatena.ne.jp/kitokitoki/20090619/1245341005>
(defun elisp-imenu-create-index ()
  (let (index)
    (save-excursion
      (goto-char (point-min))
      (loop always (re-search-forward "^;;;\\(.+\\)" nil t)
            do (push (cons (match-string 1) (match-beginning 1)) index)))
       (nreverse index)))

(add-hook 'emacs-lisp-mode-hook 
          (lambda () 
            (setq imenu-create-index-function 'elisp-imenu-create-index)))
; (setq which-func-modes (append which-func-modes '(emacs-lisp-mode)))

;;;; for rd mode
;; 元々 rd-mode には rd-imenu-create-index があるけど, 全部表示してくれて結構重い.
;; 後, 大きなファイルで (rd-imenu-create-index) が失敗してたので, 小さくて軽めのバージョンを作ってみた.
(defun my-rd-imenu-create-index ()
  (let (index)
    (save-excursion
      (goto-char (point-min))
      (loop always (re-search-forward "^= \\(.+\\)" nil t) ; トップレベルの = だけをタグとする
      ; (loop always (re-search-forward "^=+ \\(.+\\)" nil t) ; 全ての "^=+ " をタグとする
            do (push (cons (match-string 1) (match-beginning 1)) index)))
       (nreverse index)))

(add-hook 'rd-mode-hook
          (lambda () 
            (setq imenu-create-index-function 'my-rd-imenu-create-index)))
; (setq which-func-modes (append which-func-modes '(rd-mode)))

;;;; 
; (setq imenu-auto-rescan t)

; imenu-sort-function


;;; for bm
;; <http://www.emacswiki.org/emacs/VisibleBookmarks>
;; <https://github.com/joodland/bm>
;; Visible bookmark とのこと. M$ Visual Studio の機能を真似た物.
;; 
;; <http://www.bookshelf.jp/soft/meadow_31.html#SEC440>
;;   バッファの任意の箇所にしおりをつけておき，そのしおりを順番に巡回することができます． 
;;   複数のバッファにしおりをつけても，巡回できるのは，現在のバッファにあるしおりだけです． 

;; 
;; bm-toggle
;;   現在行にしおりを付ける (or しおりを外す)
;; bm-previous
;;   前のしおりに移動する
;; bm-next
;;   次のしおりに移動する

(require 'bm)

;;;; キーバインド
;; M$ Visual Studio key setup.
;; (global-set-key (kbd "<C-f2>") 'bm-toggle)
;; (global-set-key (kbd "<f2>")   'bm-next)
;; (global-set-key (kbd "<S-f2>") 'bm-previous)

;; Click on fringe to toggle bookmarks, and use mouse wheel to move between them.
;; (global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
;; (global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
;; (global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

;; <http://d.hatena.ne.jp/peccu/20100402>
;; <http://d.hatena.ne.jp/kenkov/20110507/1304754238>
;; キーの設定
(global-set-key (kbd "M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)
;; マークのセーブ
(setq-default bm-buffer-persistence t)
;; セーブファイル名の設定
(setq bm-repository-file (locate-user-emacs-file ".bm-repository"))
;; 起動時に設定のロード
(setq bm-restore-repository-on-load t)
(add-hook 'after-init-hook 'bm-repository-load)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'after-revert-hook 'bm-buffer-restore)
;; 設定ファイルのセーブ
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'auto-save-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
;; Saving the repository to file when on exit
;; kill-buffer-hook is not called when emacs is killed, so we
;; must save all bookmarks first
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))


;;; for helm
;;;   for helm
;;;; for helm
(require 'helm-config)

; (setq helm-buffer-max-length 20) ; 表示する際の各バッファ名の最大長 (あんまり長すぎると間延びする)

;;;; キーバインド
; 以下のような helm が予め定義されている.
; とりあえず使い始める場合は helm-mini でよさげ.
; 
; * helm-mini:
;   helm-source-buffers-list
;   helm-source-recentf
;   helm-source-buffer-not-found
; 
; * helm-for-files:
;   helm-source-buffers-list
;   helm-source-recentf
;   helm-source-bookmarks
;   helm-source-file-cache
;   helm-source-files-in-current-dir
;   helm-source-locate
; 
; * helm-recentf:
;   helm-source-recentf
; 
; また, デフォルトでは helm-command-prefix の値が "C-x c" になっている.
; (こため, C-x c ... というコマンドで, 色々な helm の機能にアクセスできる)
; * C-x c f   	helm-for-files
; * C-x c a   	apropos
; 
; * C-x c M-y 	helm-show-kill-ring
; * C-x c M-s o	helm-occur
; * C-x c M-g s	helm-do-grep
; * C-x c C-x C-b	helm-buffers-list
; * C-x c C-x C-f	helm-find-files
; * C-x c C-c f	helm-recentf
; * C-x c l   	helm-locate
; * C-x c b   	helm-resume
; 
; * C-x c c   	color (emacs で使える色見本一覧)
; * C-x c F   	xfont 一覧
; 
; * C-x c #   	helm-emms
; * C-x c /   	helm-find
; * C-x c 8   	helm-ucs
; * C-x c e   	helm-etags-select
; * C-x c i   	helm-imenu
; * C-x c m   	helm-man-woman
; * C-x c p   	helm-list-emacs-process
; * C-x c r   	helm-regexp
; * C-x c s   	helm-surfraw
; * C-x c t   	helm-top
; * C-x c w   	helm-w3m-bookmarks
; * C-x c x   	helm-firefox-bookmarks
; * C-x c C-, 	helm-calcul-expression
; * C-x c C-: 	helm-eval-expression-with-eldoc
; * C-x c <tab>	helm-lisp-completion-at-point
; * C-x c h g 	helm-info-gnus
; * C-x c h i 	helm-info-at-point
; * C-x c h r 	helm-info-emacs
; * C-x c C-c C-b	helm-browse-code
; * C-x c C-c C-x	helm-run-external-command
; * C-x c C-c SPC	helm-all-mark-rings
; * C-x c C-c g	helm-google-suggest
; * C-x c M-x 	helm-M-x
; * C-x c C-x r b	helm-bookmarks
; * C-x c C-x r i	helm-register

; 公式サイトでのキーバインド例は以下の通り.
(global-set-key (kbd "C-c h")   'helm-mini)
(global-set-key (kbd "C-c /")   'helm-resume) ;; 検索途中の状態で C-g で打ち切っておけば, その状態を一発で復元できるので, 移動が楽になるかも...
(global-set-key (kbd "M-y")     'helm-show-kill-ring) ;; browse-kill-ring からの置き換え
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)   ;; ibuffer からの置き換え
(global-set-key (kbd "M-x")     'helm-M-x)            ;; 
; (global-set-key (kbd "C-x C-r") 'helm-recentf)        ;; helm-mini があれば要らない??
; (define-key ctl-x-map (kbd "C-f") 'helm-find-files) ;; ちょっとうるさい??
; (define-key ctl-x-map (kbd "C-f") 'helm-for-files)  ;; デフォルトで C-x c f にバインド済み
(define-key minibuffer-local-map (kbd "C-r") 'helm-minibuffer-history) ; ミニバッファの履歴を helm で絞込み (minibuf-isearch からの置き換え)

; helm-mode を実行すると, 任意の Emacs コマンド (e.g M-x, C-x C-f, etc...) の中で helm completion が使える.
; 以下のように設定ファイルに書いておくとデフォルトで helm-mode になる.
; (例えば，DiredモードでC-x C-fとするとhelm-mode-find-fileという バッファが表示されてC-n/C-pで選択し，Returnで決定するとそのファイルが開けます)
(helm-mode 0) ; <= 微妙に使いにくいような...  使いたいときは明示的に helm-mini を実行する方がいいかも
  ; <http://fukuyama.co/nonexpansion> : Emacs Helm のパス自動補完がじゃまなので無効化した
  ; C-l(or右矢印)で一つ上のパスに書き換え、C-z(or左矢印)で今回追加したTabと同じ設定がデフォルトです。
  ;; 自動補完を無効
  (custom-set-variables '(helm-ff-auto-update-initial-value nil))
  ;; C-hでバックスペースと同じように文字を削除  
  (define-key helm-c-read-file-map (kbd "C-h") 'delete-backward-char)
  ;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
  (define-key helm-c-read-file-map (kbd "TAB") 'helm-execute-persistent-action)


;; 結果の参照時に source 間を移動するキーをもう少し打ちやすいところに移動 (デフォルトは C-o か矢印キー)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)


;;;; 1ソースあたりの表示候補数を増やしておく
(setq helm-candidate-number-limit 2000) ; 候補数

;;;; バッファに対しては、カーソルを合わせただけで中身を表示する
;; <http://shakenbu.org/yanagi/d/?date=201202>
;; <https://github.com/shishi/.emacs.d/blob/master/inits/10-helm.el>
;; C-z を押さないと中身を見ることができません。
;; これまで使っていた iswitchb では、選択を確定する前に選択中のバッファを表示するようにしていたので、この機能はぜひ欲しいと思っていました。

;;(add-hook 'helm-move-selection-after-hook
;;  (lambda ()
;;    (when (eq (cdr (assq 'type (helm-get-current-source))) 'buffer)
;;      (helm-execute-persistent-action))))

(defun show-buffer-move-by-move-extend ()
  (interactive)
  (when (or (memq (assoc-default 'type (helm-get-current-source)) '(buffer sexp))   ;; buffer か sexp
	    (equal (cdr (assq 'name (helm-get-current-source))) "Grep")             ;; 又は grep
            (equal (cdr (assq 'name (helm-get-current-source))) "Imenu")            ;; 又は Imenu
            (equal (cdr (assq 'name (helm-get-current-source))) "Etags")            ;; 又は Etags
            (equal (cdr (assq 'name (helm-get-current-source))) "Exuberant ctags")  ;; 又は 
	    )
    (helm-execute-persistent-action))
  ;; (y-or-n-p (message "%s" (anything-get-current-source)))
  )
(add-hook 'helm-move-selection-after-hook 'show-buffer-move-by-move-extend)


;;;; for helm-migemo
(require 'helm-migemo)
(add-to-list 'helm-c-source-recentf '(migemo))      ; migemo 対応
;(add-to-list 'helm-c-source-buffers-list '(migemo)) ; migemo 対応
(add-to-list 'helm-c-source-bookmarks '(migemo))

;;;; for helm-descbinds
;; -- <https://github.com/emacs-helm/helm-descbinds>
;; -- `describe-bindings' is replaced to `helm-descbinds'. (Type `C-h b', `C-x C-h' these run `helm-descbinds')
;; - When type RET, selected candidate command is executed.
;; - When type TAB, You can "Execute", "Describe Function" or "Find Function" by the menu.
;; - When type C-z, selected command is described without quiting.
(require 'helm-descbinds)
(helm-descbinds-mode)
;(global-set-key (kbd "C-c b") 'helm-descbinds)

;;;;; prior to emacs24
;  (helm-descbinds-mode 1)


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


;;;   for helm-gtags
;; <https://github.com/syohex/emacs-helm-gtags>
;; <http://d.hatena.ne.jp/syohex/20120705/1341455747>
;; <http://d.hatena.ne.jp/syohex/20120709/1341842636>
;; な anything-gtags.elとは互換性はありません。
;; 
;; gtags.elとの依存関係をなくしたので完全に独自の設定が必要になります。
;; (gtags.elのソースを見ていたところ、内部状態をいろいろと持っていて、部分的に使うことにすると、変な風になるんじゃないかって思ったことと、
;; 一挙動がおかしい(helmとの組み合わせの関係?)ところがあったので、
;; 一利用していた機能をすべて自前で実装しました。
;; あ gtags.elって結構バージョンアップしていて、サポートする際確かめるのが面倒だなと思い、
;; 全自分で責任が取れるようにしたというのも理由の一つです。
;; 
;; C-u(prefix argument)を付加すると、ディレクトリを指定してそれ以下から検索できるようにしました。(特定のディレクトリ以下からの検索機能)
;; 場により有能だろうと思います。
(require 'helm-config)
(require 'helm-gtags)

;;;; add-hooks
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
; (add-hook 'dired-mode-hook 'helm-gtags-mode)

;;;; customize
; (setq helm-gtags-path-style 'relative) ; ファイルパス. 'root, 'relative, 'absolute の ３種類. デフォルトは root.
; (setq helm-gtags-ignore-case t)        ; 大文字／小文字を無視するかどうか. t なら無視する (デフォルトは nil)
; (setq helm-gtags-read-only t)          ; ファイルを開くときに read-only で開くかどうか. デフォルトは nil.

;;;; key bindings
;; 以のキーバインドは公式のもの. 
;; 対する gtags.el のキーバインドを上書きするような設定になっている模様(?).
;; 
;; な, prefix を付けると探索範囲が絞られるとのこと.
;; * C-u 	Searches from specified directory
;; * C-u C-u 	Searches under current directory
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
              (local-set-key (kbd "M-t") 'helm-gtags-find-tag)      ; 関数の定義元の探索
              (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)     ; 関数の参照元の探索
              (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)   ; 変数の定義元と参照元
    	      (local-set-key (kbd "C-c t s") 'helm-gtags-select)    ; すべてのシンボルから探索(experimental)
              (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))   ; 戻る

;;;   for helm-ag
;; <http://emacs-jp.github.io/packages/helm/helm-ag.html>
;; 各コマンド
;;   helm-ag
;;   カレントディレクトリ以下を検索する
;; 
;;   helm-ag-this-file
;;   現在開いているファイルを検索する
;; 
;;   helm-ag-pop-stack
;;   ジャンプ前の場所に戻る
;; 
;;   helm-ag-clear-stack
;;   ジャンプ元を保存しているスタックをクリアする
;; 
;; 各変数 
;; * helm-ag-base-command(デフォルト: ag --nocolor --nogroup)
;;   agコマンドを実行する際のコマンドと基本オプションです.
;; 
;; * helm-ag-command-option(デフォルト: nil)
;;   基本コマンドの後ろに追加されるコマンドラインオプション
;; 
;; * helm-ag-thing-at-point(Default: 'nil)
;;   この値が non nilである場合, カーソル以下のオブジェクトを検索パターンとして 自動的に挿入します. helm-ag-thing-at-pointが取る値は, thing-at-pointに 指定できるものと同じです('word, 'symbol等).

(require 'helm-config)
(require 'helm-ag)

(setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
(setq helm-ag-command-option "--all-text")
(setq helm-ag-thing-at-point 'symbol)


;;;   for helm-howm-list-grep
;(setq howm-directory "~/howm")
;(defun helm-howm-list-grep ()
;  (interactive)
;  (helm-ag howm-directory))


;;;   for helm-bm
;; <http://rubikitch.com/2014/11/22/helm-bm/>
;; ELPA にきてたので, そちらに更新
;; 以前は以下のものを使っていた.
;;   (install-elisp "https://raw.github.com/thomasf/dotfiles-thomasf-emacs/master/emacs.d/lisp/helm-bm.el")  <= こっちをインストール
;;     (install-elisp "https://raw.github.com/lewang/le_emacs_libs/master/helm-bm.el")  <= こっちにもある. 少しだけ違うが, まあ上の方がいいかな.
(require 'helm-bm)
(global-set-key (kbd "C-c b") 'helm-bm)  ; #TODO helm-descbinds との競合解消


;;;   for helm-from-my-template (private)
;;;; helper-function
(defun helm-candidates-from-my-template (fpath)
  "Create helm candidates' strings from a file splitted by empty lines"
  (with-temp-buffer 
    (insert-file-contents fpath nil nil nil t)
    ;; process it ...
    ;; (goto-char 0) ; move to begining of file's content (in case it was open)
    ;; ... do something here
    ;; (write-file fpath) ;; write back to the file
    
    ;; split the buffer by empty lines
    (split-string 
     (buffer-string) ; return the buffer's contents as a string
     "\n\n")
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


;;;   for my helm 
;; helm-mini がカバーしていないものも参照したいので, 少し拡張しておく.
;; 選択できる source は, helm-c-source-* という変数を探せばいい模様 (M-Tab でも apropos でも).

;; 参考になる??
;; <http://www24.atwiki.jp/anything/m/pages/13.html> : anythingの設定方法 まとめwiki source一覧

;;;; for helm-c-source-rd-headline
;; <https://bitbucket.org/kotakanbe/myhome/src/3c9b1ddeb754/.emacs.d/auto-install/anything-config.el>
;; (defvar anything-c-source-rd-headline
;;   '((name . "RD HeadLine")
;;     (headline  "^= \\(.+\\)$" "^== \\(.+\\)$" "^=== \\(.+\\)$" "^==== \\(.+\\)$")
;;     (condition . (memq major-mode '(rdgrep-mode rd-mode)))
;;     (migemo)
;;     (subexp . 1))
;;   "Show RD headlines.
;; 
;; RD is Ruby's POD.
;; http://en.wikipedia.org/wiki/Ruby_Document_format")


;;;; 別のバッファ／ファイルへの移動用
(defun helm-my-buffers ()
  (interactive)
  (let ((helm-ff-transformer-show-only-basename nil))  ; for helm-source-filelist
    (helm-other-buffer '(helm-c-source-recentf
			 ; helm-source-session  ; session.el の file list から取る. recentf と似たようなもの?
                         helm-c-source-files-in-current-dir
			 helm-c-source-bookmarks
			 helm-c-source-buffers-list
			 helm-c-source-elscreen
                         helm-c-source-buffer-not-found
			 helm-c-source-filelist)
                       "*helm my buffers*")))
(global-set-key (kbd "C-c h")   'helm-my-buffers)

;;;; カレントバッファ内での移動用
;; <http://d.hatena.ne.jp/rubikitch/20080107/anythingcurrentbuffer>
;; (setq anything-for-current-buffer-sources
;;           (list anything-c-source-bm
;;                 anything-c-source-eev-anchor
;;                 anything-c-source-imenu))
;; 
;; <https://github.com/lugecy/dot-emacs/blob/master/conf.d/050-anything.el>
;; (defvar anything-for-current-buffer-sources '(anything-c-source-imenu
;;                                               anything-c-source-bm
;;                                               anything-c-source-mark-ring
;;                                               anything-c-source-emacs-lisp-toplevels
;;                                               anything-c-source-occur
;;                                               ))
;; 
;; <http://www.emacswiki.org/emacs-se/RubikitchAnythingConfiguration>
;; (setq anything-headline-sources
;;       '(anything-c-source-org-headline anything-c-source-oddmuse-headline
;;                                        anything-c-source-emacs-lisp-toplevels
;;                                        anything-c-source-rd-headline
;;                                        anything-c-source-w3m-defun
;;                                        anything-c-source-hatena-headline
;;                                        anything-c-source-emacs-source-defun
;;                                        anything-c-source-emacs-lisp-expectations))
;; 
;; (defun anything-for-current-buffer ()
;;   (interactive)
;;   (let* ((anything-buffer "*anything current buffer*")
;;          (anything-sources
;;           (append
;;            '( ;; prior
;;              anything-c-source-not-yet
;;              anything-c-source-ipa
;;              anything-c-source-bm
;;              anything-c-source-fixme
;;              anything-c-source-linkd-tag
;;              anything-c-source-eev-anchor
;;              )
;;            anything-headline-sources
;;            '( ;; mode-oriented
;;              anything-c-source-rdefs
;;              anything-c-source-list-call-seq
;;              ;; minor
;;              anything-c-source-ctags
;;              ;;anything-c-source-imenu
;;              anything-c-source-commands-for-current-buffer
;;              anything-c-source-anything-grep-fallback
;;              anything-c-source-anything-google-fallback
;;              ;;anything-c-source-simple-call-tree-functions-callers
;;              ;;anything-c-source-simple-call-tree-callers-functions
;;              )))
;;          (anything-candidate-number-limit 2000))
;;     (call-interactively anything-function)))

;; (defun helm-semantic-or-imenu ()
;;   "Run `helm' with `semantic' or `imenu'.
;; 
;; If `semantic-mode' is active in the current buffer, then use
;; semantic for generating tags, otherwise fall back to `imenu'.
;; Fill in the symbol at point by default."
;;   (interactive)
;;   (let ((source (if (semantic-active-p)
;;                     'helm-source-semantic
;;                   'helm-source-imenu)))
;;     (push-mark)
;;     (helm :sources source
;;           :buffer "*helm semantic/imenu*"
;;           :preselect (thing-at-point 'symbol))))

(require 'helm-imenu)
(require 'helm-semantic)
(require 'helm-ring)
(defun helm-for-current-buffer ()
  (interactive)
  (let ((helm-c-source-semantic-or-imenu
	 (if (semantic-active-p)
	     helm-source-semantic
	   helm-source-imenu)))
    (helm-other-buffer '(
			 ; helm-c-source-ipa       ; しおり機能
			 helm-c-source-semantic-or-imenu
			 helm-c-source-bm
			 helm-c-source-occur-by-moccur
			 helm-source-mark-ring   ; マーク箇所のリスティング (ちなみに, グローバルなリング用の helm-source-global-mark-ring もある)
			 )
                       "*helm for current buffer*")))
; とりあえず helm-imenu を上書き
(define-key helm-command-map (kbd "i")  'helm-for-current-buffer)  


;;;; 情報検索用
;; 他には何を入れようか??
;; * eldoc の情報も入れたいが...
;; * 英単語なんかどうだろう?? sdic 的な
;; * google suggest もいいかもしれない    <= 入れてみた
;; * info も入れてみる?? でも info はソフトウェア毎に分かれている (helm-source-info-ほにゃらら) ので, どれを選んだものか
;; * surfraw も入れてみる? <http://d.hatena.ne.jp/kitokitoki/20090926/p1>
;;   <= 直接ブラウザに打った方が速いかも. どうせほとんど Google しか使わないし. 使うとしたら Wikipedia くらい?
(require 'helm-elisp)
(require 'helm-man)

; woman の挙動が遅いとき用のキャッシュファイル名. nil ならキャッシュしない. デフォルトは nil.
; (なお, 更新したくなったら C-u を付けて woman を呼ぶ)
; (setq woman-cache-filename "~/.emacs.d/.wmncache.el")

(defun helm-my-apropos (arg)
  (interactive "P")
  (when arg (setq helm-man-pages nil))   ; 引数があれば helm-man-woman のキャッシュを破棄する

  (let ((default (thing-at-point 'symbol)))  ; 現在カーソル地点のシンボルをデフォルト値とする (woman には効かないな... どう変えたらいい??)
    (helm :sources                  ; helm-other-buffer は helm のラッパー
	  (append
	   '(helm-source-man-pages           ; man (helm-man-woman より)
	     helm-source-google-suggest)     ; google suggest
	   '(helm-source-info-pages)         ; info
	   ;; '(helm-source-info-elisp         ; info (helm-info-at-point より)
	   ;;   helm-source-info-cl
	   ;;   helm-source-info-pages)
	   (mapcar (lambda (func)            ; apropos (helm-apropos より)
		     (funcall func default))
		   '(helm-def-source--emacs-commands
		     helm-def-source--emacs-functions
		     helm-def-source--emacs-variables
		     helm-def-source--emacs-faces
		     helm-def-source--helm-attributes)))
	  :buffer "*helm my apropos*"
	  :input default                                                            ; クエリの初期値
	  :preselect (and default (concat "\\_<" (regexp-quote default) "\\_>"))))  ; ぴったりの要素が存在すれば最初から選択
  )
; とりあえず helm-apropos と helm-man-woman を上書き
(define-key helm-command-map (kbd "a")  'helm-my-apropos)
(define-key helm-command-map (kbd "m")  'helm-my-apropos)

;;;; howm 検索用
;; 情報検索用と一緒にしようと思ったが, helm-do-grep-1 がそういう作りになっていないので pending
;; <http://vaughndickson.com/2013/03/07/keybinding-for-emacs-helm-to-recursively-grep-certain-file-extensions-in-your-src-directories/>

(defun helm-my-howm-grep ()
  (interactive)
  (helm-do-grep-1 '("~/howm")
                  '(4)
                  nil
                  '("*.howm" "*.txt")))

(global-set-key (kbd "C-c g") 'helm-my-howm-grep)



;;; for yasnippet
(require 'yasnippet)

;; # (自分用) snippet 管理方法
;;   * 自分が独自に作った snippet は, 以下のディレクトリに格納.
;;     (add-to-list 'yas/root-directory "~/.emacs.d/snippets")
;;   * その他に, 以下のディレクトリにある snippet を使用. (yas-snippet-dirs に設定)
;;     ("~/.emacs.d/snippets"
;;      "~/.emacs.d/elpa/yasnippet-*/snippets")
;;   * ELPA で付いてくる標準 snippet (.emacs.d/elpa/yasnippet-*/snippets) のうち, 
;;     自分の使いにくい物は, 独自ディレクトリ("~/.emacs.d/snippets")の設定で上書き
;;       (例: c++-mode の map, etc)
;;     または, ファイルを削除 
;;       (例: ruby-mode の if, ife, for, forin, time,  etc) (<= 2013-05-13-234544.howm 参照)

;;;; snippet 管理用のディレクトリの設定
;; デフォルトのままなので特に設定する必要なし. ~/.emacs.d/snippets というフォルダを作っておくこと.
;; ;(setq yas-snippet-dirs
;; ;      '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
;; ;        ...
;; ;        ))

(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

;;;; キーバインド
;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
;; (setqだとtermなどで干渉問題ありでした)
;; もちろんTAB以外でもOK 例えば "C-;"とか
(custom-set-variables '(yas-trigger-key "TAB"))
;; 
;; 既存スニペットを挿入する
;(define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
;(define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
;(define-key yas-minor-mode-map (kbd "C-x y v") 'yas-visit-snippet-file)
;; なおデフォルト設定は以下の通り.
;; `C-c & C-s' (yas-insert-snippet)
;; `C-c & C-n' (yas-new-snippet)
;; `C-c & C-v' (yas-visit-snippet-file)

;;;; 表示方法 (yas-insert-snippet の時や Tab 補完で展開候補が複数ある場合などの表示方法)
; 順番を変えると優先順位が変わる
;   * yas/x-prompt          -- X Window
;   * yas/dropdown-prompt   -- dropdown-menu.el  (<= dropdown-list.el ??)
;   * yas/ido-prompt        -- minibuffer (見た目が良い)
;   * yas/completing-prompt -- minibuffer
(require 'dropdown-list)
(setq yas/prompt-functions
      '(yas/dropdown-prompt
        yas/ido-prompt
        yas/x-prompt
        yas/completing-prompt
        yas/no-prompt))

;;;; 参考 (表示方法) : anything に表示させる(yas-insert-snippet が anything-c-yasnippet と同等になる)
;; <http://d.hatena.ne.jp/sugyan/20120111/1326288445>
;; (defun my-yas/prompt (prompt choices &optional display-fn)
;;   (let* ((names (loop for choice in choices
;;                       collect (or (and display-fn (funcall display-fn choice))
;;                                   coice)))
;;          (selected (anything-other-buffer
;;                     `(((name . ,(format "%s" prompt))
;;                        (candidates . names)
;;                        (action . (("Insert snippet" . (lambda (arg) arg))))))
;;                     "*anything yas/prompt*")))
;;     (if selected
;;         (let ((n (position selected names :test 'equal)))
;;           (nth n choices))
;;       (signal 'quit "user quit!"))))
;; (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))

;;;; for helm & yasnippet (helm-c-yasnippet.el)
;; 
;; Customizable Options:
;; ---------------------
;;
;; Below are customizable option list:
;;
;; `helm-c-yas-not-display-dups'
;; if non-nil not display duplicate snippet otherwise display all snippet
;; default = t
;; `helm-c-yas-display-msg-after-complete'
;; if non-nil display snippet key message in minibuffer after Complete
;; default = t
;; `helm-c-yas-snippets-dir-list'
;; list of directory used to find snippet file
;; default = nil
;; `helm-c-yas-space-match-any-greedy'
;; if non-nil helm pattern space match anyword greedy.
;; default = nil
;; `helm-c-yas-display-key-on-candidate'
;; if non-nil helm display candidate(snippet name) include key
;; default = nil
;; 
;; here's my yasnippet's configuration
;;   (require 'yasnippet)
;;   (require 'helm-c-yasnippet)
;;   (setq helm-c-yas-space-match-any-greedy t) ;[default: nil]
;;   (global-set-key (kbd "C-c y") 'helm-c-yas-complete)
;;   (yas--initialize)
;;   (yas-load-directory "<path>/<to>/snippets/")
;;   (add-to-list 'yas-extra-mode-hooks 'ruby-mode-hook)
;;   (add-to-list 'yas-extra-mode-hooks 'cperl-mode-hook)
(require 'yasnippet)
(require 'helm-c-yasnippet)
(setq helm-c-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "C-c y") 'helm-c-yas-complete)
(yas-global-mode 1)  ;(yas--initialize) <= 昔はこうだった

(add-to-list 'helm-c-source-yasnippet '(migemo))      ; migemo 対応


;;;   for additional snippets
; 特になし
; 
;; <https://github.com/AndreaCrotti/yasnippet-snippets>
;; M-x (yas/reload-all) to activate them; 
;; (add-to-list 'yas/root-directory "~/yasnippet-snippets/") 
;; ;  <= 標準として ELPA で付いてくるようになったので除外

;;; for auto-complete
;; <http://cx4a.org/software/auto-complete/manual.ja.html>
 
(when (require 'auto-complete-config nil t)
  (ac-config-default)
 
;;;; 辞書の保存場所の設定 
  ;; ELPA で入れた場合, デフォルトでは elpa によるインストールディレクトリ内になっている.
  ;; 自分で独自の辞書ディレクトリを持ちたい場合は追加してもいい.
  ;; なお, 検索対象は「メジャーモード名と同名のファイル」のみ.
  ;; 
  ;; (add-to-list 'ac-dictionary-directories (locate-user-emacs-file "dict"))
 
;;;; 補完履歴のキャッシュ先
  (setq ac-comphist-file (locate-user-emacs-file "elisp/auto-complete/ac-comphist.dat"))
 
;;;; 諸変数のカスタマイズ
  ;; <http://cloverrose.hateblo.jp/entry/2013/04/12/145825>
  ;; <http://www.gfd-dennou.org/member/uwabami/cc-env/Emacs/auto-complete_config.html>
  ;; 
  ;; (setq ac-auto-start 2)  ;; n文字以上の単語の時に補完を開始. nil に設定すると自動補完されなくなる
  ;; (setq ac-delay 0.05)  ;; n秒後に補完開始
  ;; (setq ac-use-fuzzy t)  ;; 曖昧マッチ有効
  ;; (setq ac-use-comphist t)  ;; 補完推測機能有効
  ;; (setq ac-auto-show-menu 0.05)  ;; n秒後に補完メニューを表示
  ;; (setq ac-quick-help-delay 0.5)  ;; n秒後にクイックヘルプを表示
  ;; (setq ac-ignore-case nil)  ;; 大文字・小文字を区別する
  ;; (setq ac-use-comphist t)  ;; 補完候補をソート
  ;; (setq ac-candidate-limit nil)  ;; 補完候補表示を無制限に
  ;; (setq ac-dwim t)  ;; デフォルトで t
  ;; (setq ac-disable-faces nil)  ;; 文字列中やコメント中でも補完を有効にする
 
  ;; ;; auto-complete の候補に日本語を含む単語が含まれないようにする
  ;; ;; http://d.hatena.ne.jp/IMAKADO/20090813/1250130343
  ;; (defadvice ac-word-candidates (after remove-word-contain-japanese activate)
  ;;   (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
  ;;     (setq ad-return-value
  ;;           (remove-if contain-japanese ad-return-value))))
 
;;;; キーバインド
  ;; <http://www.gfd-dennou.org/member/uwabami/cc-env/Emacs/auto-complete_config.html>
  ;; 
  ;; (setq ac-use-menu-map t)  ; C-n, C-p, C-s 等を有効にする (ac-menu-map というマップが有効化される)
  ;; 
  ;; (define-key ac-completing-map (kbd "C-s")   'ac-isearch)
  ;; (define-key ac-completing-map (kbd "M-/")   'ac-stop)
  ;; (define-key ac-completing-map (kbd "RET") nil) ; return での補完禁止
 
  ;; <http://acidnote.com/2013/05/js2-autocomplete/>
  ;; 設定次第で任意のモードで任意の補完辞書を呼び出させることも出来るっぽい。
  ;; <= (make-local-variable 'ac-dictionary-files) しといた方がいいのでは??
  ;; 
  ;; (add-hook 'hoge-mode-hook ;; 適用先のモード
  ;;   '(lambda ()
  ;;     (add-to-list 'ac-dictionary-files 
  ;;        "~/.emacs.d/elpa/auto-complete-20130330.1836/dict/hoge") ;; 参照したい辞書へのパス
  ;; ))
 
  (define-key ac-completing-map (kbd "M-s")   'ac-isearch)
 
 
  ;; M-TAB で明示的に auto-comlete を発動
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
 
 
;;;; 対応するメジャーモードの設定
  ;;  (setq ac-modes (append '(js2-mode)))
 
 
;;;; 情報源(sources)の設定
  ;; ac-sources を設定すればいい.
  ;; 注意: ac-sources はバッファローカルなので, hook 等で setq するといい.
 					;(push 'ac-source-filename ac-sources)
 
  ;; <http://fukuyama.co/yasnippet>
  ;; どのモードでも共通にベースとなるソースを作っておく.
  ;;   (defvar my-ac-sources
  ;;     '(ac-source-yasnippet             ;; yasnipet を追加
  ;;       ac-source-abbrev
  ;;       ac-source-dictionary
  ;;       ac-source-words-in-same-mode-buffers))
  ;; 
  ;; あるいは ac-sources を直接変更.
  (setq-default ac-sources 
 		`(,@ac-sources ac-source-yasnippet))   ;; YASnippet を補完候補に追加
 
  ;; add-hook で各モードのソースを調整
  ;;  (defun ac-scss-mode-setup ()
  ;;    (setq-default ac-sources (append '(ac-source-css-property) my-ac-sources)))
  ;;  (add-hook 'scss-mode-hook 'ac-scss-mode-setup)
  ;; 
  ;;  (defun ac-web-mode-setup ()
  ;;    (setq-default ac-sources my-ac-sources))
  ;;  (add-hook 'web-mode-hook 'ac-web-mode-setup)
  ;; 
  ;;  (defun ac-coffee-mode-setup ()
  ;;    (setq-default ac-sources my-ac-sources))
  ;;  (add-hook 'coffee-mode-hook 'ac-coffee-mode-setup)
 
 
;;;; look コマンドで英単語を補完
  ;; <http://d.hatena.ne.jp/kitokitoki/20101205/p2>
  ;; (require 'auto-complete-config)
  ;; 
  ;; (defun my-ac-look ()
  ;;   "look コマンドの出力をリストで返す"
  ;;   (interactive)
  ;;   (unless (executable-find "look")
  ;;     (error "look コマンドがありません"))
  ;;   (let ((search-word (thing-at-point 'word)))
  ;;     (with-temp-buffer
  ;;       (call-process-shell-command "look" nil t 0 search-word)
  ;;       (split-string-and-unquote (buffer-string) "\n"))))
  ;; 
  ;; (defun ac-complete-look ()
  ;;   (interactive)
  ;;   (let ((ac-menu-height 50)
  ;;         (ac-candidate-limit t))
  ;;   (auto-complete '(ac-source-look))))
  ;; 
  ;; ;; 表示数制限を変更しない場合
  ;; ;;(defun ac-complete-look ()
  ;; ;;  (interactive)
  ;; ;;  (auto-complete '(ac-source-look)))
  ;; 
  ;; (defvar ac-source-look
  ;;   '((candidates . my-ac-look)
  ;;     (requires . 2)))  ;; 2文字以上ある場合にのみ対応させる
  ;; 
  ;; ;; キーは好きなのを割り当てて下さい
  ;; (global-set-key (kbd "M-h") 'ac-complete-look)
 
 
  ;; いちいち M-h で明示的に呼び出すのが面倒なら、以下のように設定。
  ;; 重そうなのでお勧めはしません。
  ;; (setq ac-source-look
  ;;   '((candidates . my-ac-look)
  ;;     (requires . 4)))  ;; 4文字以上の入力のみ対象とするように変更. 2 だと候補が多すぎてうっとうしい
  ;; 
  ;; ;; 補完対象とするモードの ac-sources に対して追加
  ;; (push 'ac-source-look ac-sources)
 
  )
 
;;;   for ac-helm
;; 
(require 'ac-helm)  ;; Not necessary if using ELPA package
;(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)
(define-key ac-completing-map (kbd "C-M-s")   'ac-complete-with-helm)
 
;; ;; M-TAB で明示的に auto-comlete & ac-helm を発動
;; (define-key ac-mode-map (kbd "M-TAB") 
;;   (lambda ()
;;     (interactive)
;;     (auto-complete)
;;     (ac-complete-with-helm)))
 
 
;;;   for ac-ja
;; <http://sheephead.homelinux.org/2011/10/11/6869/>
(require 'ac-ja)
;; ac-source-dabbrev-ja を補完候補に追加
;; (全ての source から候補を取るわけではなく, 最初に候補を返した source だけを見る模様.
;;  ac-source-words-in-same-mode-buffers が先にあると取られることが多いので, こっちを先頭にしてみる)
(setq-default ac-sources 
	      `(ac-source-dabbrev-ja ,@ac-sources))

;; yc 入力時に auto-complete されるようにしてみる
;; <http://sheephead.homelinux.org/2011/10/11/6869/>
;; <https://gist.github.com/yryozo/5843877>
(eval-after-load "yc"
  '(progn
     (defadvice yc-kakutei (after ac-yc-kakutei last)
       "yc-kakuteiの後にauto-complete-modeによる補完を実行するadvice"
       (unless (minibufferp)
         (ac-start)))
     (ad-activate 'yc-kakutei)))

;; <= ac-trigger-commands を使っても実現可能??

;; (add-hook 'yc-mode-hook
;;           (lambda () 
;;             "skk-kakuteiのadviceを活性化" 
;;             (interactive)
;;             (ad-activate 'yc-rK-trans)))
;;  
;; (defadvice yc-mode-exit (before ad-skk-mode-exit last)
;;   "skk-modeから抜ける時にskk-kakuteiのadviceを不活性化。"
;;   (ad-deactivate 'skk-kakutei))

;;; for markdown-mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;;; gfm-mode にする
;; <http://jblevins.org/projects/markdown-mode/>
;; この場合, プレビューを見るために markdown-command を Doctor にした方がいい.
;; 
;(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))


;;;; キーバインド
;; 設定されているような/されていないような変な感じなので, 明示的にセット
(add-hook 'markdown-mode-hook
          '(lambda ()
	     (local-set-key (kbd "M-RET") 'markdown-insert-list-item)))

;;; ;;; for key-combo
;; ;; 同じキーを連続して入力したときの動作を変更する
;; ;; <http://d.hatena.ne.jp/uk-ar/20111208/1322572618>
;; ;; 
;; ;; <= 使ってみたけど, なんか色々な処理とぶつかるので微妙. 
;; ;;    (C-u 関係を結構奪ってくれる気がする. outshine の C-u C-i とか. 
;; ;;    あと cua-mode での編集ともなんかぶつかってるっぽい)
;; 
;; (require 'key-combo)
;; (key-combo-mode 1)

;; ;;;; デフォルトの設定を読み込む場合
;; (key-combo-load-default)

;; ;; ;;;; グローバルな key-combo 設定
;; ;; ;;  (key-combo-define-global (kbd "=") '(" = " " == " " === " ))
;; ;; ;;  (key-combo-define-global (kbd "=>") " => ")
;; ;;  
;; ;;  
;; ;; (defvar key-combo-global-default
;; ;;   '(;; instead of using (goto-char (point-min))
;; ;;     ;; use beginning-of-buffer for keydescription
;; ;;     ("C-a"   . (back-to-indentation move-beginning-of-line
;; ;;                                     beginning-of-buffer key-combo-return))
;; ;;     ("C-e"   . (end-of-line end-of-buffer key-combo-return))
;; ;;     ))
;; ;;  
;; ;; (key-combo-load-default-1 (current-global-map)
;; ;;  			  key-combo-global-default)
;; ;;  
;; ;;  
;; ;; ;;;; 各モードに対するキー設定
;; ;; (setq key-combo-lisp-mode-hooks
;; ;;       '(lisp-mode-hook
;; ;;         emacs-lisp-mode-hook
;; ;;         lisp-interaction-mode-hook
;; ;;         inferior-gauche-mode-hook
;; ;;         scheme-mode-hook))
;; ;;  
;; ;; (setq key-combo-lisp-default
;; ;;       '(("."  . " . ")
;; ;;         (","  . (key-combo-execute-orignal))
;; ;;         (",@" . " ,@")
;; ;;         (";"  . (";;;; " ";"))
;; ;;         ("="  . ("= " "eq " "equal "))
;; ;;         (">=" . ">= ")))
;; ;;  
;; ;; (setq key-combo-common-mode-hooks
;; ;;       '(c-mode-common-hook
;; ;;         php-mode-hook
;; ;;         ruby-mode-hook
;; ;;         cperl-mode-hook
;; ;;         javascript-mode-hook
;; ;;         js-mode-hook
;; ;;         js2-mode-hook))
;; ;;  
;; ;; (defcustom key-combo-common-default
;; ;;   '((","  . ", ")
;; ;;     ("="  . (" = " " == " " === "));;" === " for js
;; ;;     ("=>" . " => ")
;; ;;     ("=~" . " =~ ");;for ruby regexp
;; ;;     ("=*" . " =* ")                     ;for c
;; ;;     ("+"  . (" + " "++"))
;; ;;     ("+=" . " += ")
;; ;;     ("-"  . (" - " "--"))               ;undo when unary operator
;; ;;     ("-=" . " -= ")
;; ;;     ("->" . " -> ");; for haskell,coffee script. overwrite in c
;; ;;     (">"  . (key-combo-execute-original " >> "))
;; ;;     ;; " > " should be bind in flex-autopair
;; ;;     (">=" . " >= ")
;; ;;     (">>=" . " >>= ")
;; ;;     ("%"  . " % ")
;; ;;     ("%="  . " %= ")
;; ;;     ("^"  . " ^ ");; XOR for c
;; ;;     ("^="  . " ^= ");; for c
;; ;;     ("!" . key-combo-execute-original)
;; ;;     ;; NOT for c
;; ;;     ;; don't use " !" because of ruby symbol
;; ;;     ;; and unary operator
;; ;;     ("!="  . " != " ) ;;" !== " for js and php
;; ;;     ("!==" . " !== ") ;;" !== " for js and php
;; ;;     ("!~" . " !~ ")   ; for ruby
;; ;;     ("~" . key-combo-execute-original)
;; ;;     ;; for unary operator
;; ;;     ("::" . " :: ") ;; for haskell
;; ;;     ;; (":" . ":");;for ruby symbol
;; ;;     ("&"  . (" & " " && "))             ;overwrite in c
;; ;;     ("&=" . " &= ");; for c
;; ;;     ("&&=" . " &&= ")                   ; for ruby
;; ;;     ("*"  . " * " )                     ;overwrite in c
;; ;;     ("*="  . " *= " )
;; ;;     ("**"  . "**" )                     ;for power
;; ;;     ("**=" . " **=" )                     ;for power
;; ;;     ;; ("?" . "? `!!' :"); ternary operator should be bound in yasnippet?
;; ;;     ;; ("?=");; for coffeescript?
;; ;;     ("<" . (key-combo-execute-original " << "))
;; ;;     ;; " < " should be bound in flex-autopair
;; ;;     ("<=" . " <= ")
;; ;;     ;; ("<?" . "<?`!!'?>");; for what?
;; ;;     ("<<=" . " <<= ");; bit shift for c
;; ;;     ("<-" . " <- ")
;; ;;     ("<!" . "<!-- `!!' -->");; for html comment
;; ;;     ("|"  . (" | " " || "));; bit OR and OR for c
;; ;;     ;;ToDo: ruby block
;; ;;     ("|=" . " |= ");; for c
;; ;;     ("||=" . " ||= ")                   ; for ruby
;; ;;     ;; ("/" . (" / " "// " "/`!!'/")) ;; devision,comment start or regexp
;; ;;     ("/" . (key-combo-execute-original))
;; ;;     ("/ SPC" . " / ")
;; ;;     ("/=" . " /= ")
;; ;;     ("*/" . "*/")
;; ;;     ("/*" . "/* `!!' */")
;; ;;     ("/* RET" . "/*\n`!!'\n*/");; add *? m-j
;; ;;     ;; ("/* RET" . "/*\n*`!!'\n*/");; ToDo:change style by valiable
;; ;;     ("{" . (key-combo-execute-original))
;; ;;     ("{ RET" . "{\n`!!'\n}")
;; ;;     )
;; ;;   "Default binding which enabled by `key-combo-common-mode-hooks'"
;; ;;   :group 'key-combo)
;; ;;  
;; ;; (key-combo-define-hook key-combo-common-mode-hooks
;; ;;                        'key-combo-common-load-default
;; ;;                        key-combo-common-default)
;; ;; (key-combo-define-hook key-combo-lisp-mode-hooks
;; ;;                        'key-combo-lisp-load-default
;; ;;                        key-combo-lisp-default)

;;; ;;; for smartchr
;; 同じキーを連続して入力したときの動作を変更する
;; https://github.com/imakado/emacs-smartchr
;; (install-elisp "https://github.com/imakado/emacs-smartchr/raw/master/smartchr.el")
;(require 'smartchr)
;(add-hook 'cperl-mode-hook
;          '(lambda ()
;             (progn
;               (local-set-key (kbd "F") (smartchr '("F" "$")))
;               (local-set-key (kbd "H") (smartchr '("H" " => ")))
;               (local-set-key (kbd "J") (smartchr '("J" "->")))
;               (local-set-key (kbd "M") (smartchr '("M" "my ")))
;               )))

;;; for moccur
;; <>
;; <http://www.kanshin.com/keyword/1504101>
(require 'color-moccur)

; (require 'moccur-edit)

; (setq moccur-grep-default-mask "\\.\\(html\\|php\\|js\\|css\\)$")
; (setq dmoccur-recursive-search t)
; (setq dmoccur-exclusion-mask (append '("\\~$" "\\.svn\\/") dmoccur-exclusion-mask))
; (setq dmoccur-mask '("\\.\\(html\\|php\\|js\\|css\\)$"))
; (setq *moccur-buffer-name-exclusion-list* '("\\~$" "\\.svn\\/"))
; (setq *moccur-buffer-name-inclusion-list* '("\\.\\(html\\|php\\|js\\|css\\)$"))
 	
;; <http://www.bookshelf.jp/soft/meadow_50.html>
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
(setq moccur-split-word t) ; 「 defun agent 」という風にスペースで区切るだ けで，「 defun 」と「 agent 」の両方がある行を検索できます
(setq moccur-use-migemo t) ; 例えば「 setumei 」で「説明」を検索できるようになります． ただし，「.+ 」のような正規表現があると，そのまま正規表現として認識します．この ため，「 setumei. 」のように「句読点」を含む場合， migemo は使われません． 
(eval-after-load "ibuffer"
  '(require 'color-moccur))
(setq *moccur-buffer-name-exclusion-list*
      '(".+TAGS.+" "*Completions*" "*Messages*"
        "newsrc.eld"
        " *migemo*" ".bbdb"))

(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key "O" 'dired-do-moccur)))
(define-key Buffer-menu-mode-map "O" 'Buffer-menu-moccur)
;;(global-set-key "\M-f" 'grep-buffers)
;(global-set-key "\M-o" 'occur-by-moccur)
;(global-set-key "\C-c\C-x\C-o" 'moccur)
;;(global-set-key "\C-c\C-o" 'search-buffers)

;;;; for helm-c-moccur
;; ;;; <http://shibayu36.hatenablog.com/entry/2012/12/29/001418>
;; バッファ内のmoccur(anything-c-moccur-occur-by-moccur)
;;     コマンドを起動(M-o)
;;     パターンを入力
;;         moccur-split-wordがnon-nilならスペース区切りで複数の単語を入力可能
;; 
;; ディレクトリを対象にしたmoccur(anything-c-moccur-dmoccur)
;;     コマンドを起動(C-M-o)
;;     ディレクトリを選択
;;     パターンを入力
;;         moccur-split-wordがnon-nilならスペース区切りで複数の単語を入力可能
;;     C-n,pで上下選択、C-M-f,bでファイル単位で移動
;;     決定
;; 
;; diredからのmoccur(anything-c-moccur-dired-do-moccur-by-moccur)
;;     diredで対象にするファイルにマークをつける
;;     コマンドを起動(O)
;;     パターンを入力
;;         moccur-split-wordがnon-nilならスペース区切りで複数の単語を入力可能
;;     C-n,pで上下選択、C-M-f,bでファイル単位で移動
;;     決定

(when (require 'helm-c-moccur nil t)
  ;; `helm-c-moccur-occur-by-moccur の起動時にポイントの位置の単語を初期パターンにする
  (setq helm-c-moccur-enable-initial-pattern t)
  ;; 現在選択中の候補の位置を他のwindowに表示する
  (setq helm-c-moccur-enable-auto-look-flag t)

  (global-set-key (kbd "M-o") 'helm-c-moccur-occur-by-moccur)
;  (global-set-key (kbd "C-M-o") 'helm-c-moccur-dmoccur)
;  (global-set-key (kbd "C-M-o") 'helm-c-moccur-buffer-list)  ; 全バッファを対象に検索  (<= なんか挙動がおかしいような... 後ものすごく重い...)
  (add-hook 'dired-mode-hook
            '(lambda ()
               (local-set-key (kbd "O") 'helm-c-moccur-dired-do-moccur-by-moccur)))
  (global-set-key (kbd "C-M-s") 'helm-c-moccur-isearch-forward)   ; 現在箇所以降で検索
  (global-set-key (kbd "C-M-r") 'helm-c-moccur-isearch-backward)  ; 現在箇所より前で検索
  
  (define-key isearch-mode-map (kbd "C-o") 'helm-c-moccur-from-isearch)  ; isearch 中に helm-moccur に遷移する
  )

;;;; moccur-edit
;(eval-after-load "color-moccur"
;  '(require 'moccur-edit))


;;; for popwin
;; <http://d.hatena.ne.jp/m2ym/20110120/1295524932>
;; バッファを表示する（display-buffer）際のEmacsのトチ狂った仕様を矯正します。この「トチ狂った仕様」とは例えば、
;; *  M-x describe-functionしたらウィンドウが勝手に分割された
;; *  あるいはウィンドウのバッファを勝手に切り替えられた
;; *  ヘルプバッファ(*Help*)とか補完バッファ(*Completions*)がどのウィンドウに出現するか予測できない
;; *  しかも作業後にそれらのバッファが表示されたままになったりする
;; 
;; さらに, 開いたウィンドウは C-g で手早く閉じることが可能.
;; 
;; <https://github.com/m2ym/popwin-el>
;;  a popup window manager for Emacs which makes you free from the hell of annoying buffers 
;;   such like *Help*, *Completions*, *compilation*, and etc.
(require 'popwin)
(popwin-mode 1)

;;;; ポップアップの位置の指定
;; <http://d.hatena.ne.jp/m2ym/20110120/1295524932>
;; ポップアップウィンドウの幅や高さはpopwin:popup-window-widthやpopwin:popup-window-heightで設定します。
;; ポップアップウィンドウの表示される場所はpopwin:popup-window-positionで設定します。値はleft, top, right, bottomのいずれかです。

(setq popwin:popup-window-position 'right)
(setq popwin:popup-window-width 0.33)

;;;; popwin でコントロールするバッファの指定
;; popwin コントロール化に置きたいバッファの名前を popwin:special-display-config に列挙していく
;; デフォルトでは *Help*, *Completions*, *compilation*, and *Occur* に対応しているらしい.
;; 
;; <http://aikotobaha.blogspot.jp/2013/04/popwinel.html>
;; ;; Browse-Kill-RIng
;; (push '("*Kill Ring*") popwin:special-display-config)
;; ;; anything
;; (push '("*anything*") popwin:special-display-config)
;; ;; sdic
;; (push '("*sdic*") popwin:special-display-config)

;; <http://sleepboy-zzz.blogspot.jp/2012/09/anythinghelm.html>
;; helm-split-window-default-fnという関数で
;; window分割とどのあたり(left,above,right,below)に表示されるかを決定しています。
;; helm-split-window-default-sideという変数を
;; (setq helm-split-window-default-side 'below)
;; のように設定すれば出てくる場所を変更できます、、、
;; が、自分のいるactiveなbufferを見えなくされることが
;; あるので私はpopwin.elで設定しています。

(push '("*auto-async-byte-compile*") popwin:special-display-config)
;(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
(push '("^\*helm my .+\*$" :regexp t) popwin:special-display-config)
;(push '("*helm*" :position right :width 0.5) popwin:special-display-config)
;(push '("*helm mini*") popwin:special-display-config)

;; M-x dired-jump-other-window
;(push '(dired-mode :position top) popwin:special-display-config)

;; M-!
(push "*Shell Command Output*" popwin:special-display-config)

;; M-x compile
(push '(compilation-mode :noselect t) popwin:special-display-config)

;; undo-tree  (<= 'd' で diff を出すと制御が外れちゃうな...)
(push '(" *undo-tree*" :width 0.3 :position right) popwin:special-display-config)

;;;; 最後に popup したものは C-x p で再度 popup するようにする. (<= バッファとして消えるわけじゃないから無くてもいいか?)
;(define-key global-map (kbd "C-x p") 'popwin:display-last-buffer)


;;; for Undo
;; ------------------ Undo ------------------
;;;   for undo-tree
;; <http://www.emacswiki.org/emacs/UndoTree>
;; 
;; <http://shibayu36.hatenablog.com/entry/2012/12/29/001418>
;; undo-treeはこれまでの編集をtree上に出してくれてundoとかredoとかできるやつです。
;; 更にundo-histというemacsを閉じてもundoの履歴を残しておいてくれるものを使うと、どこまでもundoできて便利です。
;; 
;; <http://d.hatena.ne.jp/khiker/20100123/undo_tree>
;; 普通に undo (C-/ や C-_) をしたり、redo (C-? や M-_)をしたりすれば良いです。
;; C-x u (undo-tree-visualize) を押して、undo の履歴を可視化して undo (redo) を行った方がはるかに分かり易いので、おすすめです。
;; C-x u をすると、新しくバッファが表示され、以下のような木構造が表示されます。
;; p や n キーで undo の履歴を辿る事ができ、辿ると同時にその undo (redo) が適用されます。木の枝を切り替える場合は、f や b キーを押せば切り替える事ができ、非常に分かり易いです。
;; undo-tree-visualize を終了する場合は、q を押せば良いです。
;; 
;; また普通に undo をしている時に木構造の枝にあたる部分にあたったとき、"Undo branch point!" というメッセージが出ます。
;; M-x undo-tree-switch-branch をしてやれば、辿る枝を変更できます。

;; undo-treeモードの設定
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

(define-key undo-tree-visualizer-mode-map (kbd "C-M-u") 'undo-tree-visualize-undo-to-x)
(define-key undo-tree-visualizer-mode-map (kbd "C-M-d") 'undo-tree-visualize-redo-to-x)

;; 履歴を保存する (圧縮形式で)
;; (保存先は, 同じディレクトリ内の ".<buffer-file-name>.~undo-tree")
(setq undo-tree-auto-save-history t)
(defadvice undo-tree-make-history-save-file-name
  (after undo-tree activate)
  (setq ad-return-value (concat ad-return-value ".gz")))

;;; for auto-async-byte-compile
;; <http://www.emacswiki.org/emacs/auto-async-byte-compile.el>
;; elisp ファイル保存時に, 自動的にバックグラウンドでバイトコンパイルする.
(require 'auto-async-byte-compile)
;(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;; ;;; for magit
;; ;; <http://daemianmack.com/magit-cheatsheet.html> : cheat sheet
;; ;; 
;; ;; <w.livedoor.jp/whiteflare503/d/magit>
;; ;; 1  M-x magit-status をやって、gitリポジトリを選ぶ
;; ;; 2  s, u でファイル、ディレクトリを追加/削除
;; ;; 3  c でコミットのメッセージの編集へ
;; ;; 4  編集が終わったらC-c C-c でコミット
;; ;; 5  P(Shift + p) でプッシュを行うかのウィンドウが現れて、また P を押せばPush終わり。
;; ;; 6      (パスワード入力が出るとダメかも)
;; ;; 
;; ;; <http://k4zmblog.dtiblog.com/blog-entry-346.html>
;; ;; 1, M-x magit-init(git init相当)
;; ;; 2, M-x magit-status(git status相当 diredのような一覧が表示される）
;; ;; 3, s(magit-stage-item)でファイルやディレクトリを管理対象に追加(git add相当)
;; ;; 4, c(magit-log-edit)でコミット(git commit相当)
;; ;; ※コミット時のメッセージ編集で、完了はC-c C-c 
;; ;; 
;; ;; <http://w.livedoor.jp/whiteflare503/d/magit>
;; ;;  s ファイルやディレクトリをステージに追加
;; ;;  u ファイルやディレクトリをステージから削除
;; ;;  k ファイル自体削除
;; (require 'magit)

;;;; for "helm で過去のコミットログを参照する"
;; <http://qiita.com/okkez@github/items/d3143ba12c604305afd1>
(defvar helm-c-source-git-commit-messages
  '((name . "Git Commit Messages")
    (init . helm-c-git-commit-messages-init)
    (action . (("Insert" . (lambda (candidate)
                             (insert
                              (replace-regexp-in-string "\0" "\n" candidate))))))
    (real-to-display . helm-c-git-commit-messages-real-to-display)
    (migemo)
    (multiline)
    (candidates-in-buffer)))

(defun helm-c-git-commit-messages-init ()
  (with-current-buffer (helm-candidate-buffer 'global)
    (call-process-shell-command
     "git log --format=\"%x00%B\" | tr '\\n\\000\' '\\000\\n' | sed -e '/^$/d' -e 's/\\x0\\+$//'"
     nil (current-buffer))))

(defun helm-git-commit-messages ()
  "`helm' for git commit messages."
  (interactive)
  (helm-other-buffer 'helm-c-source-git-commit-messages
		     "*helm commit messages*"))

(defun helm-c-git-commit-messages-real-to-display (candidate)
  (replace-regexp-in-string "\0" "\n" candidate))

(defun magit-enable-helm ()
  ;; 過去のコミットメッセージを挿入
  (define-key magit-log-edit-mode-map
    (kbd "C-c i") 'helm-git-commit-messages))
(add-hook 'magit-mode-hook
          'magit-enable-helm)

;;; ;;; for gist
;; <https://github.com/defunkt/gist.el>
;; GitHub の Gist に簡単に投稿するための elisp.
;; 初回起動時にユーザー名とパスワードを聞かれる (~/.gitconfig に保存される).
;; 
;; gist-region や gist-buffer で投稿する模様
;; (投稿先の URL が kill ring に保存されるので, ブログなどからリンクを張るのにも便利).
;; (Description を付けたいなら, gist-list してから 'e')
;; (ファイル名は元々の物がそのまま使われる模様. 気に入らなければ gist-list でファイル編集モードにして 'C-x C-w')  (<= ただし git log には残っちゃうので, 最初に上げる前に調整しとくのが賢いかもしれない)
;; (複数ファイルからなる Gist にも対応. '+' や '-' でファイルを追加／削除可能)
;; 
;;   gist-list - Lists your gists in a new buffer. Use arrow keys
;;   to browse, RET to open one in the other buffer.
;;    
;;   gist-region - Copies Gist URL into the kill ring.
;;   With a prefix argument, makes a private gist.
;;    
;;   gist-region-private - Explicitly create a private gist.
;;    
;;   gist-buffer - Copies Gist URL into the kill ring.
;;   With a prefix argument, makes a private gist.
;;    
;;   gist-buffer-private - Explicitly create a private gist.
;;    
;;   gist-region-or-buffer - Post either the current region, or if mark
;;   is not set, the current buffer as a new paste at gist.github.com .
;;   Copies the URL into the kill ring.
;;   With a prefix argument, makes a private paste.
;;    
;;   gist-region-or-buffer-private - Explicitly create a gist from the
;;   region or buffer.
;; 
;; その他に gist-list buffer では以下のようなキーバインドがある模様.
;;   g : reload the gist list from server
;;   e : edit current gist description
;;   k : delete current gist
;;   + : add a file to the current gist
;;   - : remove a file from the current gist
;; 
;; また, gist の閲覧/編集中には C-x C-s や C-x C-w で保存／ファイル名変更が出来る模様.
;;   C-x C-s : save a new version of the gist
;;   C-x C-w : rename some file
;; 
;; また, dired-mode からファイルを gist にアップロードも出来る模様.
;;   @ : make a gist out of marked files (with a prefix, make it private)

;; ;;;; FIXME
;; ;; なんだか package.el がバグっていて, 標準バンドルの eieio 1.4 を見つけてくれないので, 
;; ;; 自前で load-path に入れておく...
;; ;; (そのままだと, eieio 1.3 が必要だと言って ELPA から別の 1.4 を取ってくる. 
;; ;; が, こちらの 1.4 だと semantic が動かない...)
;; (require 'em-glob)
;;  
;; (dolist (dirglob '("~/.emacs.d/elpa/gist-*"
;;  		   "~/.emacs.d/elpa/gh-*"
;;  		   "~/.emacs.d/elpa/pcache-*"
;;  		   "~/.emacs.d/elpa/logito-*"))
;;   (setq load-path 
;;  	(cons 
;;  	 (expand-file-name (car (eshell-extended-glob dirglob))) 
;;  	 load-path)))

;;;; 
;; (require 'gist) ; 依存している gh ライブラリが 24.4 以降必須になってしまったので一時的に削除


;;; ;;; for yascroll
;; (数MBクラスのファイルで使うと重すぎた. 
;; 後, 移動しないと見えないので, 結局あんまり位置は分からない(<= いや, 高速移動中に現在地が分かるのが嬉しいかもしれないが...). 
;; 一旦停止)
;; ;; <http://d.hatena.ne.jp/m2ym/20110401/1301617991>
;; ;; iPhoneのスクロールバーからインスピレーションを得て、主張しないスクロールバーモード、yascroll.elというのを作ってみました。
;; ;; スクロール時にスクロールバーがウィンドウ右辺に現われるという単純なものです。
;; (require 'yascroll)
;; (global-yascroll-bar-mode 1)


;;; for rainbow-delimiters
;; <https://github.com/jlr/rainbow-delimiters>
;; <http://emacs-fu.blogspot.jp/2011/05/toward-balanced-and-colorful-delimiters.html>
;; <http://ergoemacs.org/misc/emacs_rainbow-delimiters-mode.html>
(when (require 'rainbow-delimiters nil 'noerror) 

  ; (global-rainbow-delimiters-mode)  ; To activate the mode globally, add to your init file: 
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)  ; To enable it in all programming-related emacs modes (Emacs 24+): 
  ; (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
  ; (add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
  ; (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))
  )

;;;; ;;;; 色をおとなしくしてみる.
;; ;; <http://ergoemacs.org/misc/emacs_rainbow-delimiters-mode.html>
;; ;; <= 効かないぞ??? 手動で custom-faces してみたら効いた. 何で設定ファイルに書いた場合は駄目???
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(completions-common-part ((t (:inherit default :foreground "red"))))
;;  '(diredp-compressed-file-suffix ((t (:foreground "#7b68ee"))))
;;  '(diredp-ignored-file-name ((t (:foreground "#aaaaaa"))))
;; 
;;  '(rainbow-delimiters-depth-1-face ((t (:foreground "blue"))))
;;  '(rainbow-delimiters-depth-2-face ((t (:foreground "blue"))))
;;  '(rainbow-delimiters-depth-3-face ((t (:foreground "#8b7500"))))
;;  '(rainbow-delimiters-depth-4-face ((t (:foreground "#8b7500"))))
;;  '(rainbow-delimiters-depth-5-face ((t (:foreground "#8b7500"))))
;;  '(rainbow-delimiters-depth-6-face ((t (:foreground "#8b7500"))))
;;  '(rainbow-delimiters-depth-7-face ((t (:foreground "#8b7500"))))
;;  '(rainbow-delimiters-depth-8-face ((t (:foreground "#8b7500"))))
;;  '(rainbow-delimiters-depth-9-face ((t (:foreground "#8b7500"))))
;;  '(rainbow-delimiters-unmatched-face ((t (:foreground "red"))))
;; 
;;  '(show-paren-match ((((class color) (background light)) (:background "azure2")))))

;;; for expand-region
;; <http://d.hatena.ne.jp/syohex/20120117/1326814127>
;; Emacsは Vimに比べて単語単位以上のものを扱うのはとても弱いです。(単語のリージョン選択、引用符で囲まれたものの選択等々)
;; そのあたりのことを改善するツールです。
;; 
;; 検索中の Ctrl-wのような感じで使えるので、どなたでもわりと簡単に便利に使えるんじゃないかなと思います。
;; 
;; <>
;; モードによって, 拡張ルールを変えられる模様. 
;; (CC-mode や Perl mode, text mode 等, 各種のモードに応じたルールが用意されている)
;; カスタマイズしたい場合は、言語ごとの「-expansions.el」のファイルが沢山はいっているので参考にすればいい.
 
;; transient-mark-modeが nilでは動作しませんので注意
;; (transient-mark-mode t)
;; 
(require 'expand-region)

;;;; キーバインド
;; C-Space をその場で押し続けると広がってくれるのが一番嬉しい気がするが...
;; <= set-mark-command-repeat-pop 機能と被るかな? 個人的には使ってないから問題ないが...
;; <= <http://www.gnu.org/software/emacs/manual/html_node/emacs/Mark-Ring.html>
;;    一応, C-Space を二回押すと「現在の position を mark ring に push だけする (mark は解除する)」という機能になっているので, これとも被る.
;;    こちらの機能は C-u Space で帰ってきたい場所を記録しておくのに便利らしい.
;; <= さらに, transient mark mode が off の場合は, 一時的に on にするという機能に割りあたっている.
;; 
;; <https://github.com/magnars/expand-region.el>
;; 以下は公式ページでのキーバインド例
(global-set-key (kbd "C-=") 'er/expand-region)
;; この場合は, contract はこんな感じがいい??
(global-set-key (kbd "C-M-=") 'er/contract-region)

;; mark-sexp を潰してみることにした. これならよく似た機能だし. 
;; ('=' でマークというのはいまいち感覚的に慣れない)
(global-set-key (kbd "C-M-SPC") 'er/expand-region)
;; contract をどうするかが難しい. 既に modifier key 2つでの binding だし...
;; <= 一回目の直後に Control を離してしまって, expand-region-contract-fast-key にまかせてしまうか?
;; とりあえず Shift をさらに追加してみるか... 右小指で打てば無理でもないだろう.
(global-set-key (kbd "C-M-S-SPC") 'er/contract-region)

;; <http://d.hatena.ne.jp/syohex/20120117/1326814127>
;; 日本語キーボードなら @ もよさげ
;; (global-set-key (kbd "C-@") 'er/expand-region)     ;; リージョンを広げる
;; (global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める

;; なお, er/expand-region 中では, 
;; er/expand-region を呼び出したキー(から modifier を除いた物)を連打することで拡大効果が得られる
;;   (例えば C-= にバインドしていれば '=' を連打すればいい).
;; 
;; また, er/expand-region 中に以下のキーを押すと, 縮小(er/contract-region)やリセットが出来る.
;; * expand-region-contract-fast-key (デフォルトは '-')
;;   縮小
;; * expand-region-reset-fast-key (デフォルトは '0')
;;   リセット
;; 
;; ただ, 一回目の er/expand-region 直後でないと駄目っぽい
;; (一度でも次の er/expand-region を入力してしまうと駄目)
;; Control は押しっぱなしの方がむしろ打ちやすいので, ちょっと使いにくい.
;; (custom-set-variables '(expand-region-contract-fast-key "/"))
;;; for paredit
;; <http://www.daregada.sakuraweb.com/paredit_tutorial_ja.html> : ParEdit チュートリアル
;; <http://www.emacswiki.org/emacs-jp/PareditCheatsheet> : PareditCheatsheet
;; 
;; 使い方:
;;   (paredit-mode) で有効化.
;;   気に入ったら add-hook する.
;; 
;; キーバインド
;;   * 空リストを挿入してリストの内容を書く
;;     左丸括弧 ( を入力すると空リスト () が挿入される。左角括弧 [ や二重引用符 " も同様の挙動.
;;     ただし, 文字列やコメントの内部では左丸括弧 ( だけが挿入される。
;; 
;;   * 「飲み込み」と「吐き出し」で既存のリストを伸縮させる
;;      リスト内部で C-<right> (<right> は→キー)を押すと、そのリストの右丸括弧 ) が右に移動して、直後にあるS式をリストに 飲み込む(slurp)。
;;      S式を飲み込み過ぎてしまった場合には、 C-<left> (<left> は←キー)を押せば、同じ右丸括弧 ) が左に移動して、リスト末尾のS式を 吐き出す(barf)。
;;      (もう少しニュアンスを込めて訳すと、slurp は ズルズル音を立てて(飲食物を)すすり込む 、barf は ゲロゲロと吐き出す)
;;      それぞれ C-) と C-} でも同じ結果が得られる。
;;    
;;      もし、空リストを挿入して飲み込む手順がまだるっこしいなら、S式の直前をポイントして M-( を押せば、そのS式を即座に丸括弧 () で囲むことができる。
;;      あるいは、 C-u 個数 ( のようにして、飲み込む個数を引数で指定することもできる。
;;    
;;      このほか、リストの左丸括弧 ( を左右に移動させて飲み込みと吐き出しを行なうキー操作も用意されているが、必要になる場面がほとんどないので説明は省略する。(直前のS式を飲み込むには C-M-<left> か C-(、先頭のS式を吐き出すには C-M-<right> か C-{。)
;;    
;;   * リストの不要な部分を削除してから上位リストに接合する (不要になった () を削除するときの操作)
;;    
;;     リスト内部で M-s を押すと、そのリストの丸括弧 () を左右とも削除し、リストの内容を上位リストに 接合(splice) する。
;;     spliceとは、ロープやフィルムなどの 端と端を繋ぎあわせる こと(撚り継ぎ/重ね継ぎ)を意味する言葉で、これもイメージによく合っている。
;;    
;;     実際には、接合後にリストの内容の一部を削除することが多い。
;;     * 残したいS式の直前をポイントして、 M-<up> (<up> は↑キー) すると
;;       そのリストの丸括弧 () を削除し、ポイント以降のリストの内容だけを上位リストに接合してくれる。
;;       (矢印キーを持たないキーボードの人は、paredit-splice-sexp-killing-backward を好みのキーにバインドしておこう。この機能を使わないのではParEditを使う意味が 大幅に 減少する。)
;;    
;;       たとえば、whenの条件判定が不要になったときや、letのローカル変数が不要になったときに M-<up> を使えば、内部フォームだけを残してさっくりと削除できる。
;;     * いっぽう、リスト内部のS式をひとつだけ残す操作は 上昇(raise) と呼ばれる。
;;       操作の対象とするS式の直前をポイントして M-r を押すと、そのS式を含む最下位リストの丸括弧 () や残りの内容がすべて削除される。
;;    
;;        ifスペシャルフォームのリスト3行からthenフォーム部分のみを取り出す, 等.
;;   ...

(require 'paredit)

(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interacton-mode-hook 'enable-paredit-mode)

;;;; lisp-interacton-mode では C-j は eval-print-last-sexp に戻す
;; <https://gist.github.com/condotti/845081/raw/97632cd8073dc0cf1320d86ddfcf83b10471f4f5/gistfile1.sls>
(defadvice paredit-newline (around eval-print-last-sexp activate)
  (if (eq major-mode 'lisp-interaction-mode)
      (eval-print-last-sexp)
    (paredit-newline)))


;;; for figlet
;; <http://www.emacswiki.org/emacs/Figlet>
;; emacs から figlet をたたくための elisp
;; 以下のコマンドが用意されている. また C-u 付きで実行するとフォントが指定できる.
;;     ‘figlet’
;;     ‘figlet-comment’
;;     ‘figlet-figletify-region’
;;     ‘figlet-figletify-region-comment’
;; 
(require 'figlet)

;;; for boxes
;; (auto-install-from-url "http://boxes.thomasjensen.com/docs/boxes.el")
;; patch -p0 < boxes.el.patch
;; 
;; <http://d.hatena.ne.jp/rubikitch/20071012/boxes>
;; 最新版（Debianのには含まれていない！）にはboxes.elが同梱されている。
;; ただ、かなりいい加減な書き方をしているので手直ししてみる。
;; 
;;     M-x boxes-create で囲む
;;     M-x boxes-remove で囲みを外す
;;     M-x boxes-mend で囲みを再描画する（最新版のみ。俺が追加）
;; 
;; 常にboxes-mendを使えば文字列を適切に囲んでくれる。

(require 'boxes)
;; 文字列を囲む設定に書き換え。デフォルトは正直イラネ
(setq boxes-known-modes
  '((c-mode . "c") (c++-mode . "c") (java-mode . "c")
    (html-mode . "html") (sh-mode . "shell") (perl-mode . "shell")
    (python-mode . "shell") (ruby-mode . "shell")
    (emacs-lisp-mode . "lisp") (lisp-mode . "lisp")))
;; 設定ファイルのコメントは通常 # なので
(setq-default boxes-default-type "shell")
;; センタリングされてるほうがカッコイイ
(setq-default boxes-args "-s 75 -a c")
;; 簡単に作成・修正できるようにする
(defalias 'boxes 'boxes-mend)

   ;;/*          ^-^
   ;;           /o o\
   ;; +----oOO_("{Y}")_OOo-----------------+
   ;; |                                    |
   ;; | C function headers?                |
   ;; |                                    |
   ;; +-----------------------------------*/

   ;;/*          ^-^
   ;;           /o o\
   ;; +----oOO-(={Y}=)-OOo-----------------+

   ;;/*          ^-^
   ;;           /- -\
   ;; +----oOO-( {Y} )-OOo-----------------+

   ;;/*          ^-^
   ;;           /= =\
   ;; +----oOO-( {Y} )-OOo-----------------+

   ;;/*          ^-^
   ;;           /@ @\
   ;; +----oOO-( {Y} )-OOo-----------------+

   ;;/*          ^-^
   ;;           /> <\
   ;; +----oOO-( {Y} )-OOo-----------------+


;;; for align
;; <http://www.emacswiki.org/emacs/AlignCommands>
;; <http://blog.handlena.me/entry/2011/12/11/214923>
(require 'align)

;;;; ruby-mode 用の align
;; <http://d.hatena.ne.jp/rubikitch/20080227/1204051280>
;; ruby-assignment-literalは代入文、ruby-xmpfilter-markはxmpfilterの「# =>」マークの設定。
(add-to-list 'align-rules-list
             '(ruby-comma-delimiter
               (regexp . ",\\(\\s-*\\)[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-hash-literal
               (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-assignment-literal
               (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list          ;TODO add to rcodetools.el
             '(ruby-xmpfilter-mark
               (regexp . "\\(\\s-*\\)# => [^#\t\n]")
               (repeat . nil)
               (modes  . '(ruby-mode))))
(add-to-list 'align-dq-string-modes 'ruby-mode)  ;; A list of modes where double quoted strings should be excluded.
(add-to-list 'align-sq-string-modes 'ruby-mode)  ;; A list of modes where single quoted strings should be excluded.
(add-to-list 'align-open-comment-modes 'ruby-mode)  ;; A list of modes with a single-line comment syntax.


;;;; php-mode 用の align
;; <http://d.hatena.ne.jp/Tetsujin/20070614/1181757931>
;; '+=' や '=&' 等の色々な代入が混じっててもalignしてくれます。
(add-to-list 'align-rules-list
             '(php-assignment
               (regexp . "[^-=!^&*+<>/.| \t\n]\\(\\s-*[.-=!^&*+<>/|]*\\)=>?\\(\\s-*\\)\\([^= \t\n]\\|$\\)")
               (justify .t)
               (tab-stop . nil)
               (modes . '(php-mode))))
(add-to-list 'align-dq-string-modes 'php-mode)  ;; A list of modes where double quoted strings should be excluded.
(add-to-list 'align-sq-string-modes 'php-mode)  ;; A list of modes where single quoted strings should be excluded.
(add-to-list 'align-open-comment-modes 'php-mode)  ;; A list of modes with a single-line comment syntax.

;; align-region-separate が M-x align-current で見るセクションの区切り判定
;; デフォルトの空行や{}だけじゃなく、arrayの中や、if,for等の構文も区切りに入れている
;; (カーソルがifの中ならif { ～ }内を、elseの中なら else { ～ } の中を、arrayの中ならその中をM-x align-currentでalignしてくれます)
(setq align-region-separate (concat "\\(^\\s-*$\\)\\|"
                                    "\\([({}\\(/\*\\)]$\\)\\|"
                                    "\\(^\\s-*[)}\\(\*/\\)][,;]?$\\)\\|"
                                    "\\(^\\s-*\\(}\\|for\\|while\\|if\\|else\\|"
                                    "switch\\|case\\|break\\|continue\\|do\\)[ ;]\\)"
                                    ))

;;;; キーバインド
;; <http://d.hatena.ne.jp/Tetsujin/20070614/1181757931>
;; 自分はこのalign-currentをC-caに割り当てたので、いちいちリージョン選択しなくても、
;; alignしたいあたりにカーソルを持って行ってC-caと押せば勝手にalignしてくれるようにしました。かなり便利！

;; php-mode
(add-hook 'php-mode-user-hook
          '(lambda ()
             (define-key c-mode-base-map "\C-ca" 'align-current) ; これが便利
             ))

;;; for orgtbl
;;;; for rd-mode
(define-key rd-mode-map (kbd "C-c t") 
  '(lambda ()  (interactive)
     (if (and (boundp 'orgtbl-mode) orgtbl-mode) (orgtbl-mode 0) (turn-on-orgtbl))))

;;;; for orgtbl-to-gfm
;; GFM (GitHub Flavored Markdown) 向けに出力.
;; (といっても '+' を '|' に変えるだけ  <= まぁいちおう右 align の場合にも対応している)
;; 
;; 参考情報:
;; * orgtbl-to-generic の apropos
;; * 以下の Web ページ
;;   <http://orgmode.org/manual/Translator-functions.html>
;;   A translator function takes two arguments. 
;;   * The first argument is the table, a list of lines, each line either the symbol hline or a list of fields. 
;;   * The second argument is the property list containing all parameters specified in the ‘#+ORGTBL: SEND’ line. 
;;   * The function must return a single string containing the formatted table.
;;   If you write a generally useful translator, please post it on emacs-orgmode@gnu.org so that others can benefit from your work. 
;; 
;;    (defun orgtbl-to-latex (table params)
;;      "Convert the Orgtbl mode TABLE to LaTeX."
;;      (let* ((alignment (mapconcat (lambda (x) (if x "r" "l"))
;;                                   org-table-last-alignment ""))
;;             (params2
;;              (list
;;               :tstart (concat "\\begin{tabular}{" alignment "}")
;;               :tend "\\end{tabular}"
;;               :lstart "" :lend " \\\\" :sep " & "
;;               :efmt "%s\\,(%s)" :hline "\\hline")))
;;        (orgtbl-to-generic table (org-combine-plists params2 params))))

(defun orgtbl-to-gfm (table params)
  "Convert the Orgtbl mode TABLE to GitHub Flavored Markdown."
  (let* ((alignment (mapconcat (lambda (x) (if x "|--:" "|---"))
                               org-table-last-alignment ""))
         (params2
          (list
	   :no-escape t
           :splice t
	   :hline (concat alignment "|")
           :lstart "| " :lend " |" :sep " | ")))
    (orgtbl-to-generic table (org-combine-plists params2 params))))

;;; for minor-mode-hack
;; <>
;; マイナーモード同士のキーバインドの衝突を解決する.
;; 
;; * 優先順の確認
;;   (show-minor-mode-map-priority)
;; * 優先順位を下げる
;;   (lower-minor-mode-map-alist 'hs-org/minor-mode)
;; * 優先順位を上げる
;;   (raise-minor-mode-map-alist 'yas-minor-mode)
(require 'minor-mode-hack)

;; yasnippet を最優先にしておく
(raise-minor-mode-map-alist 'yas-minor-mode)
;;; ;;; for multi-term
;; ;; <http://www.emacswiki.org/emacs/MultiTerm>
;; ;; 
;; ;; ‘term-unbind-key-list’ is a list of keys which emacs keeps for itself. By default it contains (“C-z” “C-c” “C-x” “C-h” “C-y” “<ESC>”)
;; ;; ‘term-bind-key-alist’ is a list of keys and functions which you can use, for example to use Emacs style cursor movement to the multi-terminal. The default is long, so I’ll let you look it up yourself.
;;
;; ;; 悪くはないと思うんだけど, やっぱり C-e とかが Emacs 的な移動になってないと戸惑う.
;; ;; 後, bash のプロンプトに色を指定してたのに出ない...
;;  
;; (require 'multi-term)
;; (setq multi-term-program "/bin/bash")
;;  
;; ;; Emacs キーバインドを使いたいキーを指定
;; (add-to-list 'term-unbind-key-list '"C-w")

;;; for syslog-mode
;; <http://www.emacswiki.org/emacs/SyslogMode>
(require 'syslog-mode)
(add-to-list 'auto-mode-alist '("/var/log.*\\'" . syslog-mode))
