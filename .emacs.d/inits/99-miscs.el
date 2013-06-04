;;; for color-theme
;;;; for solarized theme
(when (require 'color-theme)
  (color-theme-initialize)
  ;; color-theme-solorized.el
  (when (require 'color-theme-solarized)
    (color-theme-solarized-light)))
    ;(color-theme-solarized-dark)))

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
(load "elscreen" "ElScreen" t)
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


;;; for session
;; ミニバッファの履歴をファイルに保存する (~/.session に保存される).
;; (ミニバッファ内のM-nやM-pで辿れる履歴をファイルに保存する.
;;  C-x C-fの履歴, M-x grepの履歴, kill-ring, 検索／置換の履歴, 各ファイルにおけるカーソル位置なども保存される)
(require 'session )
(add-hook 'after-init-hook 'session-initialize)

;; <http://elim.hatenablog.com/entry/2012/11/07/022233> : anything-browse-kill-ring と session.el 
;; Anything と session.el を一緒に使うなら, 以下を .emacs に追加すること.
(setq session-save-print-spec '(t nil nil))

;;; for mic-paren
(require 'mic-paren)
(paren-activate)

;;; for gtags
(autoload 'gtags-mode "gtags" "" t)

;;; for cscope
(require 'xcscope)

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


;;; for IMEs

;;; for anthy
;(set-input-method "japanese-anthy")
;;; for boiling-anthy
;(require 'anthy)
;(autoload 'boiling-rK-trans "boiling-anthy" "romaji-kanji conversion" t)
;(autoload 'boiling-rhkR-trans "boiling-anthy" "romaji-kana conversion" t)
;(global-set-key [?\C-\;] 'boiling-rK-trans)
;;(global-set-key "\M-o" 'boiling-rhkR-trans)

;;; for canna
(set-input-method "japanese-egg-canna")
(setq egg-mode-hook
      '(lambda ()
         (its-defrule "tha" "てゃ" nil t)
         (its-defrule "thi" "てぃ" nil t)
         (its-defrule "thu" "てゅ" nil t)
         (its-defrule "the" "てぇ" nil t)
         (its-defrule "tho" "てょ" nil t)
         (its-defrule "dha" "でゃ" nil t)
         (its-defrule "dhi" "でぃ" nil t)
         (its-defrule "dhu" "でぅ" nil t)
         (its-defrule "dhe" "でぇ" nil t)
         (its-defrule "dho" "でぉ" nil t)
         (its-defrule "va" "う゛ぁ" nil t)
         (its-defrule "vi" "う゛ぃ" nil t)
         (its-defrule "vu" "う゛ぅ" nil t)
         (its-defrule "ve" "う゛ぇ" nil t)
         (its-defrule "vo" "う゛ぉ" nil t)
;	 (its-defrule "/" "・" nil t)
	 (its-defrule "~" "〜" nil t)
       )
)
(define-key its-mode-map "\C-g" 'its-cancel-input)
;(define-key its-mode-map "\C-j" 'its-exit-mode)
(define-key egg-conversion-map "\C-g" 'egg-abort-conversion)
;(define-key egg-conversion-map "\C-j" 'egg-exit-conversion)
;(define-key menudiag-mode-map "\C-j" 'menudiag-select-this-item)

;(setq egg-conversion-auto-candidate-menu 5)
;(setq menudiag-select-without-return t)
;(setq its-hira-period "．")
;(setq its-hira-comma  "，")
;(setq its-hira-enable-zenkaku-alphabet nil)
;; (setq its-delete-by-keystroke t)
;(setq its-delete-by-character t)

;;; for yc
(setq yc-rK-trans-key [?\C-\;]) ; C-j ではなく C-; で変換(load する前に設定すること)
(load "yc") ; これでフェンスモードは使用可能
(global-yc-mode) ; 全バッファで ANK-漢字変換を有効にする
; (setq yc-use-color t) ; <= 見づらくない？
; (setq yc-use-fence (not (eq window-system 'x)))
(setq yc-use-fence t)
; (global-set-key "\M-\ " 'yc-mode) ; 一時的に無効にするときに使う


;;; for dired
;;;; for bf-mode
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


;;;;; for dired-sorter
(load "sorter")

;;; for rd-mode
(autoload 'rd-mode "rd-mode" nil t)


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

;;; for outshine
;;;; 注意事項
;; 現在は, デフォルトの状態では, elisp mode だけは ";;[;]+ " がヘッドラインになるように設定されている.
;; ただし, 本文中に一つでも通常のヘッドライン (";; =+ " 等) にひっかかる物があれば特別扱いされなくなるので注意.

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


;;; for helm
;;;; for helm
(require 'helm-config)

; helm を使用する場合は helm-mini を実行すればいい.
; 公式サイトでのキーバインド例は以下の通り.
(global-set-key (kbd "C-c h")   'helm-mini)
(global-set-key (kbd "C-c /")   'helm-resume) ;; 検索途中の状態で C-g で打ち切っておけば, その状態を一発で復元できるので, 移動が楽になるかも...
(global-set-key (kbd "M-y")     'helm-show-kill-ring) ;; browse-kill-ring からの置き換え
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)   ;; ibuffer からの置き換え
(global-set-key (kbd "M-x")     'helm-M-x)            ;; 
(global-set-key (kbd "C-x C-r") 'helm-recentf)        ;; helm-mini があれば要らない??
; (define-key ctl-x-map (kbd "C-f") 'helm-find-files) ;; ちょっとうるさい??
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

;;;; バッファに対しては、カーソルを合わせただけで中身を表示する
;; <http://shakenbu.org/yanagi/d/?date=201202>
;; C-z を押さないと中身を見ることができません。
;; これまで使っていた iswitchb では、選択を確定する前に選択中のバッファを表示するようにしていたので、この機能はぜひ欲しいと思っていました。
(add-hook 'helm-move-selection-after-hook
  (lambda ()
    (when (eq (cdr (assq 'type (helm-get-current-source))) 'buffer)
      (helm-execute-persistent-action))))

;;;; for helm-migemo
(require 'helm-migemo)
(add-to-list 'helm-c-source-recentf '(migemo))      ; migemo 対応
;(add-to-list 'helm-c-source-buffers-list '(migemo)) ; migemo 対応

;;;; for helm-descbinds
;; -- <https://github.com/emacs-helm/helm-descbinds>
;; -- `describe-bindings' is replaced to `helm-descbinds'. (Type `C-h b', `C-x C-h' these run `helm-descbinds')
;; - When type RET, selected candidate command is executed.
;; - When type TAB, You can "Execute", "Describe Function" or "Find Function" by the menu.
;; - When type C-z, selected command is described without quiting.
(require 'helm-descbinds)
(helm-descbinds-mode)
(global-set-key (kbd "C-c b") 'helm-descbinds)

;;;;; prior to emacs24
;  (helm-descbinds-mode 1)

;;; for yasnippet
(require 'yasnippet)
;; デフォルトのままなので特に設定する必要なし. ~/.emacs.d/snippets というフォルダを作っておくこと.
;(setq yas-snippet-dirs
;      '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
;        ))
(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

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
;; `C-c & C-s' (`yas-insert-snippet')
;; `C-c & C-n' (`yas-new-snippet')
;; `C-c & C-v' (`yas-visit-snippet-file')

;; 
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

;;; for helm & yasnippet (helm-c-yasnippet.el)
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
(yas--initialize)

(add-to-list 'helm-c-source-yasnippet '(migemo))      ; migemo 対応


;;; for markdown-mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))


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
  (global-set-key (kbd "C-M-o") 'helm-c-moccur-buffer-list)  ; 全バッファを対象に検索  (<= なんか挙動がおかしいような... 後ものすごく重い...)
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
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
;(push '("*helm*") popwin:special-display-config)
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
;;; for undo-tree
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
