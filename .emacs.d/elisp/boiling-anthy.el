;; boiling-anthy.el
;;
;; $B$e$G$"$s$7$#(B?
;;
;;  written by Shunsuke OKANO <okano@pro.ics.tut.ac.jp>
;;  original written by <sengoku@gcd.org>
;;
;; comment:
;;  anthy.el(egg $BIUB0$N$G$OL5$$(B) $B$r;H$C$F(B boiled $B$JF~NOJ}K!$r<B8=$7$^$9(B.
;;  $B8=:_$O$R$i$,$J$X$NJQ49$O(B anthy $B$NF~NO%^%C%W$K0MB8$7$^$9(B.
;;  $B$D$^$j(B,
;;   C-\ q C-\ kita- M-o -> $B%-%?!<(B
;;  $B$H$J$j$^$9(B.
;; -> $BB?J,D>$7$?!#(B
;;
;;  emacs 22 $B$N(B CVS $B$GF0:n3NG'$r9T$$$^$7$?(B.
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

;; commit $B;~$N%U%C%/$O$"$k$,(B, $B%-%c%s%;%k;~$N%U%C%/$OL5$$0Y%"%I%P%$%9$r;H$&(B
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

;; $B1&B&$K$b8!:w$9$k(B rK-trans
;; $B$3$l$G(B type $B$7$?$H$-$b3Z$K$J$k$+$b$7$l$J$$(B
(defun boiling-rK-hungry-trans ()
  "translate hungry"
  (interactive)
  (let ((n (re-search-forward boiling-subjective-chars nil t)))
    (if (numberp n)
        (goto-char (1- n)))
    (boiling-rK-trans)))
