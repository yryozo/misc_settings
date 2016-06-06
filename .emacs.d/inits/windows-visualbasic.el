;;; Visual Basic (VBA) 用の設定
;;;;; visual-basic-mode
(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(setq auto-mode-alist (append '(("\\.\\(bas\\|cls\\)$" .
                                 visual-basic-mode)) auto-mode-alist))

;;;; vbasense
(require 'vbasense)

;; キーバインド
(setq vbasense-popup-help-key "C-:")
(setq vbasense-jump-to-definition-key "C->")

;; 必要に応じて適宜カスタマイズして下さい。以下のS式を評価することで項目についての情報が得られます。
;; (customize-group "vbasense")

;; 推奨設定を行う
(vbasense-config-default)
