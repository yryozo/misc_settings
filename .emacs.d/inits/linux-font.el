;;; for font settings
;; 基本となるfontを指定 (英語部分担当)
(if (>= emacs-major-version 24)
    (set-frame-font "Ricty-13.5" nil t)
  (set-default-font "Ricty-13.5"))
;; <= <http://d.hatena.ne.jp/kitokitoki/20110502/p2> 
;;    <https://github.com/yascentur/Ricty>
;;    横幅が 1:2 になるのは、12pt, 13.5pt, 15pt, 18pt など.
;;    "ピクセル値 (px) が偶数でないとき、どのフォントにおいても起こりうる問題です。
;;    一般的な 96 DPI のフォントレンダリングでは、9 pt、10.5 pt、12 pt、13.5 pt、15 pt など、1.5 の倍数を指定すると 1:2 で表示されると思います。"

;;; その他のフォント候補
					; (set-frame-font "Myrica M-14" nil t)  ; ちょっと日本語が細いかな?? バランスが悪いような.
					; 

;; 日本語部分用のfont設定を追加
(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty"))


;; 英語fontと日本語fontの横幅がずれていれば調整
					; (今は同じfont(どちらもRicty)なので不要)
					; (setq face-font-rescale-alist '(("MeiryoKe_Console" . 1.08)))

					;(add-to-list 'default-frame-alist '(font . "Ricty-13.5"))
					;(custom-set-faces
					; '(variable-pitch ((t (:family "Ricty"))))
					; '(fixed-pitch ((t (:family "Ricty"))))
					; )

					; (set-face-attribute 'default nil :family "Menlo" :height 140)
					; (set-fontset-font (frame-parameter nil 'font)
					;                   'japanese-jisx0208
					;                   (font-spec :family "Hiragino Kaku Gothic ProN" :size 16))

;;; ;;; for font-lock (<= 最近はデフォルトでオンになっている模様. まぁ当たり前か...)
;; (if window-system
;;     (progn
;; ;      (setq font-lock-support-mode 'lazy-lock-mode)
;;       (global-font-lock-mode t)
;; ;      (setq font-lock-support-mode 'fast-lock-mode)
;;       (setq fast-lock-cache-directories '("~/.emacs-flc"))
;;        ))
