;;; for IMEs

;; (set-input-method "japanese") ;; tamago が 24.3 で動かないので, 暫定的に設定
;; => もうとりあえず japanese-yc でいい

;;;   ;; for anthy
; (set-input-method "japanese-anthy")
;;;   ;; for boiling-anthy
; (require 'anthy)
; (autoload 'boiling-rK-trans "boiling-anthy" "romaji-kanji conversion" t)
; (autoload 'boiling-rhkR-trans "boiling-anthy" "romaji-kana conversion" t)
; (global-set-key [?\C-\;] ' boiling-rK-trans)  ; roman(hankaku) -> KANJI transformation.
; ;;(global-set-key "\M-o" 'boiling-rhkR-trans) ; roman(hankaku) -> hiragana -> katakana -> ROMAN(zenkaku) transformation

;;;   ;; for canna
;; (set-input-method "japanese-egg-canna")
;; (setq egg-mode-hook
;;       '(lambda ()
;;          (its-defrule "tha" "てゃ" nil t)
;;          (its-defrule "thi" "てぃ" nil t)
;;          (its-defrule "thu" "てゅ" nil t)
;;          (its-defrule "the" "てぇ" nil t)
;;          (its-defrule "tho" "てょ" nil t)
;;          (its-defrule "dha" "でゃ" nil t)
;;          (its-defrule "dhi" "でぃ" nil t)
;;          (its-defrule "dhu" "でぅ" nil t)
;;          (its-defrule "dhe" "でぇ" nil t)
;;          (its-defrule "dho" "でぉ" nil t)
;;          (its-defrule "va" "う゛ぁ" nil t)
;;          (its-defrule "vi" "う゛ぃ" nil t)
;;          (its-defrule "vu" "う゛ぅ" nil t)
;;          (its-defrule "ve" "う゛ぇ" nil t)
;;          (its-defrule "vo" "う゛ぉ" nil t)
;; ;	 (its-defrule "/" "・" nil t)
;;  	 (its-defrule "~" "〜" nil t)
;;        )
;; )
;; (define-key its-mode-map "\C-g" 'its-cancel-input)
;; ;(define-key its-mode-map "\C-j" 'its-exit-mode)
;; (define-key egg-conversion-map "\C-g" 'egg-abort-conversion)
;; ;(define-key egg-conversion-map "\C-j" 'egg-exit-conversion)
;; ;(define-key menudiag-mode-map "\C-j" 'menudiag-select-this-item)
;;  
;; ;(setq egg-conversion-auto-candidate-menu 5)
;; ;(setq menudiag-select-without-return t)
;; ;(setq its-hira-period "．")
;; ;(setq its-hira-comma  "，")
;; ;(setq its-hira-enable-zenkaku-alphabet nil)
;; ;; (setq its-delete-by-keystroke t)
;; ;(setq its-delete-by-character t)


;;;   ;; for yc
; 暫定的に無効化
; (setq yc-rK-trans-key [?\C-\;]) ; C-j ではなく C-; で変換(load する前に設定すること)
; (load "yc") ; これでフェンスモードは使用可能
; (global-yc-mode) ; 全バッファで ANK-漢字変換を有効にする
; ; (setq yc-use-color t) ; <= 見づらくない？
; ; (setq yc-use-fence (not (eq window-system 'x)))
; (setq yc-use-fence t)

; ; (global-set-key "\M-\ " 'yc-mode) ; 一時的に無効にするときに使う


;;;   for mozc
(require 'mozc)
(setq default-input-method "japanese-mozc")

; <https://wiki.archlinux.org/index.php/Mozc_(日本語)#Emacs_.E3.81.A7_Mozc_.E3.82.92.E4.BD.BF.E3.81.86>
; mozc.el は変換候補の表示スタイルに、候補のリストを入力中文字列のそばに表示する "overlay" モードを提供しています (Mozc r77以降)。
; このモードをデフォルトで利用する場合は、以下の設定を追加します:
(setq mozc-candidate-style 'overlay)
; <>
; あるいは, Mozcの変換候補をMini Bufferに表示させることも可能。
; (setq mozc-candidate-style 'echo-area)

;;;   for boiled-mozc
; <https://github.com/tadanagao/boiled-mozc>
; boiled-mozc.el wraps("boil"s) mozc.el to offer modeless input style
(autoload 'boiled-mozc-rK-conv "boiled-mozc" "Romaji to Kana-Kanji conversion" t)
(autoload 'boiled-mozc-rhkR-conv "boiled-mozc" "Romaji to Hiragana conversion" t)

;(global-set-key "\C-o" 'boiled-mozc-rK-conv) ; roman(hankaku) -> KANJI transformation.
(global-set-key [?\C-\;] 'boiled-mozc-rK-conv) ; roman(hankaku) -> KANJI transformation.
;(global-set-key "\M-o" 'boiled-mozc-rhkR-conv) ; roman(hankaku) -> hiragana -> katakana -> ROMAN(zenkaku) transformation
