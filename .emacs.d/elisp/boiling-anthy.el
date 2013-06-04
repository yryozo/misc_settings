;; boiling-anthy.el
;;
;; ゅであんしぃ?
;;
;;  written by Shunsuke OKANO <okano@pro.ics.tut.ac.jp>
;;  original written by <sengoku@gcd.org>
;;
;; comment:
;;  anthy.el(egg 付属のでは無い) を使って boiled な入力方法を実現します.
;;  現在はひらがなへの変換は anthy の入力マップに依存します.
;;  つまり,
;;   C-\ q C-\ kita- M-o -> キター
;;  となります.
;; -> 多分直した。
;;
;;  emacs 22 の CVS で動作確認を行いました.
;;
;; Define autoload entries and key bindings in your .emacs file as follows:
;;
;; (autoload 'boiling-rK-trans "boiling-anthy" "romaji-kanji conversion" t)
;; (autoload 'boiling-rhkR-trans "boiling-anthy" "romaji-kana conversion" t)
;; (global-set-key "\C-o" 'boiling-rK-trans)
;; (global-set-key "\M-o" 'boiling-rhkR-trans)

(defvar boiling-input-method "japanese-anthy")
(defvar boiling-subjective-chars "[^]['.,a-zA-Z@-]")

(defconst boiling-convert-start-string "(space)")
(defconst boiling-commit-string "(enter)")

(setq boiling-last-input-flag nil)

(defun anthy-change-rkmap (newmap)
  "change rkmap to newmap"
  (let ((repl (anthy-send-recv-command
               (concat " MAP_SELECT " newmap "\n"))))
    (if (eq repl 'OK)
        (progn
          (setq anthy-current-rkmap newmap)
          (anthy-update-mode-line)))))

(defun anthy-convert-region (start end)
  "convert region to japanese with japanese-anthy"
  (interactive "*p")
  (anthy-change-rkmap "hiragana")
  (delete-region start end)
  (anthy-handle-normal-key
   (concat boiling-trans-original boiling-convert-start-string)))

(defun anthy-translate-region (start end)
  "translate region to hiragana with japanese-anthy"
  (interactive "*p")
  (anthy-change-rkmap "hiragana")
  (setq anthy-preedit "")
  (let ((str (buffer-substring start end)))
    (delete-region start end)
    (anthy-handle-normal-key
     (concat str boiling-commit-string))))


(defun boiling-rK-trans ()
  "(roman(hankaku) -> KANJI transformation."
  (interactive)
    (if (boiling-rhkR-trans t)
        (progn
          (setq boiling-last-input-flag t)
          (activate-input-method boiling-input-method)
          (anthy-convert-region boiling-trans-start (point)))))

;; commit 時のフックはあるが, キャンセル時のフックは無い為アドバイスを使う
(defadvice anthy-handle-key (after boiling-end activate)
  (if (string= anthy-preedit "")
      (if boiling-last-input-flag
          (progn
            (inactivate-input-method)
            (setq boiling-last-input-flag nil)
            (if (eq boiling-trans-start (point))
                (insert-string boiling-trans-original))
            ))))

(defun boiling-rhkR-trans (&optional kana)
  "roman(hankaku) -> hiragana -> katakana -> ROMAN(zenkaku) transformation"
  (interactive "P")
  (if (and (eq last-command 'boiling-rhkR-trans) boiling-trans-type)
      (cond
       (kana
        (delete-region boiling-trans-start (point))
        (insert-string boiling-trans-original)
        (boiling-rhR-trans boiling-trans-start (point) kana))
       ((eq boiling-trans-type 'h)
        (japanese-katakana-region boiling-trans-start (point))
        (setq boiling-trans-type 'k))
       ((eq boiling-trans-type 'k)
        (delete-region boiling-trans-start (point))
        (insert-string boiling-trans-original)
        (japanese-zenkaku-region boiling-trans-start (point))
        (setq boiling-trans-type 'R))
       ((eq boiling-trans-type 'R)
        (japanese-hankaku-region boiling-trans-start (point))
        (setq boiling-trans-type nil)
        t))
    (let ((pos (point))
          (mark (mark t))
          bol)
      (beginning-of-line)
      (setq bol (point))
      (goto-char pos)
      (if (and mark (<= bol mark) (< mark pos)
               (not (re-search-backward "[^!-~]" mark t)))
          (boiling-rhR-trans mark pos kana)
        (goto-char (- pos 1))
        (if (re-search-backward boiling-subjective-chars bol t)
            (progn
              (forward-char 1)
              (boiling-rhR-trans (point) pos kana))
          (boiling-rhR-trans bol pos kana))
        ))
    ))

(defun boiling-rhR-trans (start end kana)
  (setq boiling-trans-start start)
  (goto-char end)
  (setq boiling-trans-original
        (buffer-substring boiling-trans-start end))
  (condition-case ()
      (progn
        (activate-input-method boiling-input-method)
        (anthy-translate-region boiling-trans-start (point))
        (inactivate-input-method)
        (setq boiling-trans-type 'h)
        t)
    (error
     (if kana
         nil
       (goto-char end)
       (japanese-zenkaku-region boiling-trans-start end)
       (setq boiling-trans-type 'R)
       t)
     )))

;; 右側にも検索する rK-trans
;; これで type したときも楽になるかもしれない
(defun boiling-rK-hungry-trans ()
  "translate hungry"
  (interactive)
  (let ((n (re-search-forward boiling-subjective-chars nil t)))
    (if (numberp n)
        (goto-char (1- n)))
    (boiling-rK-trans)))
