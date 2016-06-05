(insert "#TODO: (helm-migemo-mode 1) の導入検討")

;;; loading settings 
;; (24.4 以降で有効)
;; バイトコンパイルされていないファイル(.el)の方が新しい場合、
;; 古いバイトコンパイル済みのファイル(.elc)はロードしない.
(setq load-prefer-newer t)

;;; for user-emacs-directory setting
;; for under Emacs 23
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/"))) 
;; <http://d.hatena.ne.jp/syohex/20140923/1411445055>
;; emacs -l init.el等で直接ロードしたときに, user-emacs-directoryを書き換える
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;; for ELPA
;;=========================================
; 注: marmalade は, https 接続のため, openssl が必要  (NTEmacs などの場合は注意)
(if (>= emacs-major-version 24)
    (progn
      (require 'package)
      (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
      (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
      (package-initialize)))


;;; for el-get
; ;; <http://shibayu36.hatenablog.com/entry/2013/03/14/081524>
; ;; <http://shishithefool.blogspot.jp/2012/04/el-get-emacs.html>
; ;; M-x el-get-list-packages で利用できるpackageを一覧できます。
; ;; 欲しいところでiを押して、その後xを押せばinstallが始まります。
; ;; するとel-get-dirで指定したdirectoryにインストールされます。簡単ですね。
; ;; 
; ;; h を押下すればミニバッファにコマンドのヘルプが表示されます。? を押して詳細を確認できるのがすばらしいです。
; ;; 
; ;; それ以外にもM-x el-get-install とかM-x el-get-remove みたいなコマンドがあります。
; ;; 
; ;; なお、el-get 自身のアップデートには M-x el-get-self-update が、
; ;; インストールしているもの全てのアップデートには M-x el-get-update-all というショートカットが用意されています。
; ;; 
; ;; <http://d.hatena.ne.jp/zqwell-ss/20130324/1364139367>
; ;; 定期的に実行することを記載しておきます。
; ;;
; ;;  * (el-get-emacswiki-refresh)
; ;;      emacswiki に存在する elisp の recipe を自動で生成. 
; ;;      (通常はバックグラウンドで行う. 失敗したら C-u を付けて foreground で行うといい模様)
; ;;  * (el-get-elpa-build-local-recipes)
; ;;      package.el を通してインストールできるもののレシピを自動生成
; ;; 
; ;; <https://github.com/dimitri/el-get>
; ;; 
; ;;   * M-x el-get-self-update
; ;;     Update only one package, el-get itself.
; ;; 
; ;;   * M-x el-get-update
; ;;     Will prompt for an installed package name, with completion, then update it. This will run the build commands and init the package again.
; ;; 
; ;;   * M-x el-get-update-all
; ;;     Will update all packages that have the installed status in your status file. Before the update you will be prompted for confirmation that you wish to proceed.
; ;;     Beware that using this function can lead to hours of settings review: more often than not updating a package requires some adjustments to your setup. Updating all of them at once will require reviewing almost all your setup.
; ;; 
; ;;   * M-x el-get-reload
; ;;     Reload the given package files. Happens automatically at update time too.
;  
; ;;;; 
; ; <http://d.hatena.ne.jp/tarao/20150221/1424518030>
; ;  El-Getがインストールされていればそれを有効化し, 
; ; そうでなければGitHubからダウンロードしてインストールする. 
; ; (Emacsの標準機能のみを用いてインストール)
; ; 
; ; 注: el-get-install.el は git コマンドを必要とする
; ; 注: <http://grugrut.hatenablog.jp/entry/2014/01/05/214509>
; ;     https 接続のため, openssl も必要  (NTEmacs などの場合は注意)
; ;     ダメなら, 直接下記の el ファイルをダウンロードして実行すれば良い (それでも git は必要)
; (add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
; (unless (require 'el-get nil 'noerror)
;   (with-current-buffer
;       (url-retrieve-synchronously
; ;       "https://raw.github.com/dimitri/el-get/master/el-get-install.el"  ; こちらでもいい
;        "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
;     (goto-char (point-max))
;     (eval-print-last-sexp)))
; ; ; github に https でアクセスしたい場合は以下を設定 proxy 環境下など) 
; ; (setq el-get-github-default-url-type 'https)
;  
; ; el-getのレシピの場所を設定
; (add-to-list 'el-get-recipe-path (locate-user-emacs-file "el-get-user/recipes"))
;  
; ; インストール済みpackageが更新されていないかチェック
; (el-get 'sync) 
;  
; ;; ;; なお, 以上は stable version を使いたい人向けの設定.
; ;; ;; develop version (master branch) を使いたい人は以下の用にする.
; ;; (add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
; ;; 
; ;; (unless (require 'el-get nil 'noerror)
; ;;   (with-current-buffer
; ;;       (url-retrieve-synchronously
; ;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
; ;;     (let (el-get-master-branch)
; ;;       (goto-char (point-max))
; ;;       (eval-print-last-sexp))))
; ;; 
; ;; (el-get 'sync)
;  
; ;; <http://d.hatena.ne.jp/zqwell-ss/20130324/1364139367>
; ;; <http://shibayu36.hatenablog.com/entry/2013/04/30/175740>
; ;; マイレシピを手軽に追加する場合は以下に書く
; ;; (自分が適当に作ってgithubに置いたものをel-getで管理するには
; ;; 以下のようにrecipeを追加する必要があります。
; ;; el-get-sourcesのリストを作っておくとel-get-installコマンドでインストールできるようになります。)
; (setq el-get-sources
;       '(
;         ;; 以下追加例
;         ;; (:name ruby-mode-trunk-head
;         ;;        :type http
;         ;;        :description "Major mode for editing Ruby files. (trunk-head)"
;         ;;        :url "http://bugs.ruby-lang.org/projects/ruby-trunk/repository/raw/misc/ruby-mode.el")
;         ;; (:name php-mode-github
;         ;;        :type github
;         ;;        :website "https://github.com/ejmr/php-mode"
;         ;;        :description "Major mode for editing PHP files. (on Github based on SourceForge version))"
;         ;;        :pkgname "ejmr/php-mode")
;         ))

;;; for other elisp's load-path
(setq load-path (cons (expand-file-name (locate-user-emacs-file "elisp")) load-path))


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


;; <https://github.com/emacs-jp/init-loader>
;; * valid names of configuration files start with two digits.  (e.g.  00_util.el,  01_ik-cmd.el,  21_javascript.el,  99_global-keys.el)
;; 
;; * Files are loaded in the lexicographical order. 
;;   This helps you to resolve dependency of the configurations.
;; 
;; * A platform specific configuration file has a prefix corresponds to the platform. 
;;   The following is the list of prefixes and 
;;   platform specific configuration files are loaded in the listed order after non-platform specific configuration files.
;;   | Platform  | Subplatform       | Prefix        | Example                     |
;;   |-----------+-------------------+---------------+-----------------------------|
;;   | Windows   |                   | windows-      | windows-fonts.el            |
;;   |           | Meadow            | meadow-       | meadow-commands.el          |
;;   | Mac OS X  | Carbon Emacs      | carbon-emacs- | carbon-emacs-applescript.el |
;;   |           | Cocoa Emacs       | cocoa-emacs-  | cocoa-emacs-plist.el        |
;;   | GNU/Linux |                   | linux-        | linux-commands.el           |
;;   | All       | Non-window system | nw-           | nw-key.el                   |
;; 
;; * 設定ファイル名の例:
;;   <https://github.com/fukamachi/emacs-config/blob/master/elisp/init-loader.el>
;;   '("00_utils.el"
;;     "23_yaml.el"
;;     "01_ik-cmd.el"
;;     "96_color.el"
;;     "20_elisp.el"
;;     "21_javascript.el"
;;     "25_perl.el"
;;     "98_emacs-config.el"
;;     "99_global-keys.el"
;;     "carbon-emacs-config.el"
;;     "carbon-emacs-migemo.el"
;;     "nw-config.el"
;;     "emacs-migemo.el"
;;     "meadow-cmd.el"
;;     "meadow-config.el"
;;     "meadow-gnuserv.el"
;;     "meadow-shell.el"
;;     "meadow-w32-symlinks.el")

;; 
(if (>= emacs-major-version 24)
    (progn
      (require 'init-loader)
      (setq init-loader-byte-compile t) ; ロード時に自動的に設定ファイルをバイトコンパイルする (elc がない場合. or el のほうが新しい場合)
      (init-loader-load (locate-user-emacs-file "inits")) ; デフォルト値は init-loader-directory 変数の値 (= ~/.emacs.d/inits)
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
      (setq init-file (locate-user-emacs-file "inits/00-util.el"))
      (load init-file)))

