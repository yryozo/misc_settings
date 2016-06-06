;;; for C
(require 'flymake)
(add-hook 'c-mode-hook (lambda () (flymake-mode t)))


;;; for scheme
(setq scheme-program-name "gosh -i")
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
(setq cmuscheme-load-hook
      '((lambda () (define-key inferior-scheme-mode-map "\C-c\C-t"
		     'favorite-cmd))))
(add-hook 'inferior-scheme-mode-hook
          '(lambda ()
             (set-buffer-process-coding-system 'euc-jp-unix 'euc-jp-unix))) 

;;; for awk-mode
(autoload 'awk-mode "cc-mode" nil t)

;;; for bison-mode
(setq auto-mode-alist (cons '("\\.y$" . bison-mode) auto-mode-alist))
(autoload 'bison-mode "bison-mode" "Major mode for editing flex code" t)

;;; for flex-mode
(setq auto-mode-alist (cons '("\\.l$" . flex-mode) auto-mode-alist))
(autoload 'flex-mode "flex-mode" "Major mode for editing flex code" t)

;;; for haskell-mode
(setq load-path (cons "~/lib/emacs" load-path))

(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t) 

(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci) 

;;; for ocaml
;; <http://www.emacswiki.org/emacs/TuaregMode>
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(add-hook 'tuareg-mode-hook
	  '(lambda () (local-set-key "\C-c\C-c" 'comment-region)))
(add-hook 'tuareg-mode-hook
	  '(lambda () (local-set-key "\C-c\C-u" 'uncomment-region)))
(setq tuareg-skip-after-eval-phrase nil)

(autoload 'tuareg-imenu-set-imenu "tuareg-imenu" 
  "Configuration of imenu for tuareg" t) 
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

;; (if (and (boundp 'window-system) window-system)
;;     (when (string-match "XEmacs" emacs-version)
;;        	(if (not (and (boundp 'mule-x-win-initted) mule-x-win-initted))
;;             (require 'sym-lock))
;;        	(require 'font-lock)))

;; ; Here is an example of Tuareg variables customization:
;; (add-hook 'tuareg-mode-hook
;; 	  '(lambda ()
;; 	     (setq tuareg-lazy-= t) ; indent `=' like a standard keyword
;; 	     (setq tuareg-lazy-paren t) ; indent [({ like standard keywords
;; 	     (setq tuareg-in-indent 0) ; no indentation after `in' keywords
;; 	     (auto-fill-mode 1) ; turn on auto-fill minor mode
;; 	     (if (featurep 'sym-lock)   ; Sym-Lock customization only
;; 		 (setq sym-lock-mouse-face-enabled nil))
;; 					; turn off special face under mouse
;; 	     ))


;;; for python-mode
;; なお, 標準バンドルの python.el もある.
;; python-mode はコミュニティによる開発. 
;; python-mode の方が機能が豊富. python.el はそれを追いかけるような感じ.
(autoload 'python-mode "python-mode"
  "Major mode for editing Python programs" t)
(setq auto-mode-alist
      (cons (cons "\\.py$" 'python-mode) auto-mode-alist))

;; forward-sexp を普通の挙動にしておく
(add-hook 'python-mode-hook
	  (lambda () (setq forward-sexp-function nil)))

;;;; for flymake
;; <https://github.com/purcell/flymake-python-pyflakes>
;; 別途 pyflakes コマンドが必要
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;; To use flake8 instead of pyflakes, add this line:
; (setq flymake-python-pyflakes-executable "flake8")


;;; for ruby-mode
;; TODO: <http://futurismo.biz/archives/2213> : EmacsでRubyの開発環境をさらにめちゃガチャパワーアップしたまとめ

(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("ruby" . ruby-mode)
                                     interpreter-mode-alist))
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t) ;追加

;;;; for flymake
;; <https://github.com/purcell/flymake-ruby>
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;;;; for ruby-electric
;; 括弧などを自動で挿入する

;;;; for inf-ruby-mode
;; Emacs から irb を利用できる
;; (C-c C-s で *ruby* バッファが作られ irb が起動する)
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-setup-keybindings "inf-ruby" "" t)
(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings))

;;; for cpp-complt
;; (add-hook 'c-mode-common-hook
;;           (function (lambda ()
;;                       (require 'cpp-complt)
;;                       (define-key c-mode-map [mouse-2]
;;                         'cpp-complt-include-mouse-select)
;;                       (define-key c-mode-map "#"
;;                         'cpp-complt-instruction-completing)
;;                       (define-key c-mode-map "\C-c#"
;;                         'cpp-complt-ifdef-region)
;;                       (cpp-complt-init))))

;; (setq cpp-complt-standard-header-path
;;       '("/usr/include/" ""))

;;; for scala mode
(load "scala-mode-navigation")  ; for avoiding scala-mode's bug
(autoload (quote scala-mode) "scala-mode" 
  "Major mode for editing Scala code. When started, run `scala-mode-hook'. \\{scala-mode-map}" t nil)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; for perl-mode
;;;; for cperl-mode
;; <>
;; 構文解析を C 言語っぽくした perl-mode なので cperl-mode, らしい.

(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq auto-mode-alist
      (cons '("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode)  auto-mode-alist ))
(setq interpreter-mode-alist (cons '("perl" . cperl-mode)
				   interpreter-mode-alist))
;(add-hook 'cperl-mode-hook
;          (lambda ()
;            (set-face-bold-p 'cperl-array-face nil)
;            (set-face-background 'cperl-array-face "black")
;            (set-face-bold-p 'cperl-hash-face nil)
;            (set-face-italic-p 'cperl-hash-face nil)
;            (set-face-background 'cperl-hash-face "black")
;            ))

;;;; for perlplus
;; (add-hook 'cperl-mode-hook
;;           (lambda ()
;;             (require 'perlplus)
;;             (local-set-key "\M-\t" 'perlplus-complete-symbol)
;;             (perlplus-setup)))

;;;; for perl-completion


;;; for prolog
(require 'prolog)
;(add-to-list 'auto-mode-alist '("\\.pl$" . prolog-mode))
;<= perl mode とかぶるので M-x run-prolog で.
;   あるいは, プログラムファイルの先頭に  %% -*- mode: prolog -*-  を付けるか.
(setq prolog-program-name "/usr/bin/gprolog")
(setq prolog-consult-string "[user].\n")


;;; for javascript
;; TODO: Google が出している js2-mode というのが良さそうである.

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
(setq javascript-indent-level 4)


;;; for coq
(setq auto-mode-alist (cons '("\\.v$" . coq-mode) auto-mode-alist))
(autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)
(autoload 'run-coq "coq-inferior" "Run an inferior Coq process." t)
(autoload 'run-coq-other-window "coq-inferior"
  "Run an inferior Coq process in a new window." t)
(autoload 'run-coq-other-frame "coq-inferior"
  "Run an inferior Coq process in a new frame." t)


;;; for Cuda
;; <http://www.emacswiki.org/emacs/CudaMode>
;; (auto-install-from-emacswiki "CudaMode")
(require 'cuda-mode)

(require 'flymake)
(push '("\\.cu$" flymake-simple-make-init) flymake-allowed-file-name-masks)
(add-hook 'cuda-mode-hook (lambda () (flymake-mode t)))


;;; for shell script
;; <http://www.emacswiki.org/emacs/FlymakeShell>
(require 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)
