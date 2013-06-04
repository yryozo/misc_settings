;;; boiled-canna.el
;;; Copyright 1996, 1997, 1998 Kaoru Nakajima

;;; $BK\%W%m%0%i%`$O%U%j!<!&%W%m%0%i%`$G$9!#$"$J$?$O!"(BFree Software
;;; Foundation $B$,8xI=$7$?(B GNU $B0lHL8xM-;HMQ5vBz$N!V%P!<%8%g%s#2!W0?$O$=$l(B
;;; $B0J9_$N3F%P!<%8%g%s$NCf$+$i$$$:$l$+$rA*Br$7!"$=$N%P!<%8%g%s$,Dj$a$k>r9`$K(B
;;; $B=>$C$FK\%W%m%0%i%`$r:FG[I[$^$?$OJQ99$9$k$3$H$,$G$-$^$9!#(B

;;; $BK\%W%m%0%i%`$OM-MQ$H$O;W$$$^$9$,!"G[I[$K$"$?$C$F$O!";T>l@-5Z$SFCDjL\E*(B
;;; $BE,9g@-$K$D$$$F$N0EL[$NJ]>Z$r4^$a$F!"$$$+$J$kJ]>Z$b9T$$$^$;$s!#>\:Y$K(B
;;; $B$D$$$F$O(B GNU $B0lHL8xM-;HMQ5vBz=q$r$*FI$_2<$5$$!#(B

;;; $B$"$J$?$O!"K\%W%m%0%i%`$H0l=o$K(B GNU $B0lHL8xM-;HMQ5vBz$N<L$7$r<u$1<h$C$F(B
;;; $B$$$k$O$:$G$9!#$=$&$G$J$$>l9g$O!"(BFree Software Fundation, Inc., 675 Mass
;;; Ave, Cambridge, MA 02139, USA $B$X<j;f$r=q$$$F2<$5$$!#(B

;;; $B:n<T$X$NO"Mm$O0J2<$X$*4j$$$7$^$9!#(B
;;; E-mail: knak@ceres.dti.ne.jp

;;;
;;;  boiled-canna $B;HMQ>e$NCm0U(B
;;;
;;;   mule-2.3 + X11R6 + Canna3.2 $B$G3+H/$7$?$N$G(B
;;;   $B$=$l0J30$N4D6-$GF0$+$J$$$+$bCN$l$^$;$s(B
;;;   mule-2.3(19.30) $B$G$OLdBjL5$/F0$-$^$9!#(B
;;;
;;;   $B$J$*!"(Bnemacs $B$G$O!"@dBPF0$-$^$;$s!#>-Mh$bBP1~$O$7$J$$$G$7$g$&!#(B
;;;   mule-1.x $B$b!"4m$J$$$+$bCN$l$J$$(B
;;;   $B2?$;$h(B canna-rk-trans-region $B$,L5$$(B emacs $B$G$OF0$-$^$;$s(B
;;;
;;;   minor mode $B2=8e$NBP1~>u67(B
;;;
;;;    emacs-20.2+canna
;;;    emacs-20.3+canna
;;;    mule(based emacs-19.34)
;;;
;;;   $BC/$+0J2<$N(B emacs $B$G3NG'$7$F$/$s$J$$$+$J$!(B
;;;   Linux $B$G(B mule $B$r(B make $B$9$k$N$,LLE]=-$/$F$$$1$M$'$d(B
;;;
;;;    mule(based emacs-19.28)
;;;    mule(based emacs-19.30)
;;;    xemacs-20.x
;;;
;;;
;;;   canna $BBP1~$G$"$k;v$,BgA0Ds(B
;;;   $B$=$N>e$G(B canna $B$r=i4|2=$7$F$+$i(B
;;;   $B$3$N%U%!%$%k$r%m!<%I$9$k;v(B
;;;
;;;
;;;  boiled-canna $B$N5!G=$*$h$SJ}?K(B
;;;
;;;   0. boiled-egg $B$NA`:n46$r$J$k$Y$/:F8=$9$k(B
;;;   1. $B5-9f$bJQ49BP>]$K$9$k(B
;;;   2. $B4A;zJQ49Cf$K(B C-g $B$7$?$iJQ49A0$N>uBV$KLa$9$h$&$K$9$k(B
;;;   3. $BJQ493NDjD>8e$J$i:FJQ49$G$-$k$h$&$K$9$k(B
;;;   4. boiled-egg $B$N(B rRkh-trans $B$H$+(B rhkR-trans $B$K$OBP1~$7$J$$(B
;;;   5. canna $B$N;z<oJQ49$O;H$($k$h$&$K$9$k(B
;;;   6. $B4A;z(B/$B;z<oJQ49Cf$KJ8;z$rF~NO$7$?$i3NDj$7$F(B fence-mode $B$+$iH4$1$k(B
;;;   7. C-g $B$G%m!<%^;z$KLa$9;~$KFI$_$NJQ99$,H?1G$5$l$k$h$&$K$9$k(B
;;;   8. region $B$r;XDj$9$k;v$K$h$C$FJQ49HO0O$r;XDj2DG=$H$9$k(B
;;;
;;;
;;;  boiled-canna $B$N(B key bind
;;;
;;;   $B4pK\E*$K$O0J2<$NDL$j(B
;;;     $BHs(Bfence-mode C-j         ==> $BJQ49(B
;;;       fence-mode C-g         ==> $BJQ49A0$N>uBV(B
;;;       fence-mode [!-~]       ==> $BJQ493NDj(B + $BJ8;zF~NO(B
;;;   $B8e$N(B key $B$O(B canna $B$N(B key bind $B$,$=$N$^$^MxMQ$G$-$k(B
;;;

;;; 3.9.3 1998.10.8
;;;   o boiled-canna-rK-trans-key $B$K(B [\henkan] $B$N$h$&$J(B
;;;     vector $B$rEPO?$5$l$?;~$G$b:FJQ49$,$+$+$k$h$&$K>r7oH=Dj$rJQ99(B
;;;
;;; 3.9.2 1998.10.7
;;;   o boiled-canna-rK-trans-key $B$NDI2C(B
;;;   o boiled-canna-preload-hook $B$NDI2C(B
;;;   o C-j $B$G!"JQ49$7$?$/$J$$?M$O(B boiled-canna $B$r%m!<%I$9$kA0$K(B
;;;     (add-hook 'boiled-canna-preload-hook
;;;       (function (lambda () (setq boiled-canna-rK-trans-key "\C-\\"))))
;;;     $B$H$+$d$l$PNI$$(B
;;;
;;; 3.9.1 1998.10.6
;;;   o boiled-canna-select-mode-map $B$H(B boiled-canna-face-mode-map $B$r(B
;;;     $B;H$&$N$r;_$a$F=>MhDL$j(B canna-mode-map $B$H(B canna-minibuffer-mode-map $B$r(B
;;;     $B;H$&$h$&$KJQ99$7$?(B
;;;
;;; 3.9.0 1998.10.1
;;;   o minor mode $B2=(B
;;;   o beta test $BCf(B
;;;
;;; 3.6 1998.9.22
;;;   o mew-1.93/patches/canna-19.34 $B$rEv$F$?(B
;;;     canna.el $B$G$b;H$($k$h$&$K$9$kBP=h(B
;;;     boiled-canna-minibuffer-henkan-kakutei-and-self-insert $B$G(B
;;;     canna:*minibuffer-local-map-backup* $B$,L5$+$C$?;~$N=hM}DI2C(B
;;;
;;; 3.5 1998.9.1
;;;   o canna 3.5 $B$@$H2?8N$+(B boiled-canna-cancel $BCf$N(B
;;;     (canna-do-function canna-func-kill-to-end-of-line)
;;;     $B$GF,$N#1J8;z;D$k$N$G$=$NBP=h(B
;;;
;;; 3.4 1997.12.11
;;;   o boiled-canna-minibuffer-henkan-kakutei-and-self-insert $B$N=$@5(B
;;;     $BJQ498uJd0lMwI=<(Cf0J30$N(B minibuffer $B$G(B
;;;     (M-x canna-touroku-region $B$NFI$_$NF~NO(B)
;;;     $B%-!<$,F~NO$5$l$:$KL58B%k!<%W$KF~$C$?$+$N$h$&$JF0:n$r$9$k$3$H$X$NBP=h(B
;;;   o $BFI$_$r=$@5$7$?8e$KJQ49%-%c%s%;%k$G%m!<%^;z$KJQ99$,H?1G$5$l$k$h$&$K$7$?(B
;;;     ($B%G%0%l!<%I$r5/$3$7$F$$$?5!G=$,$d$C$H;H$($k$h$&$K$J$C$?(B $B$H$b8@$&(B)
;;;
;;; 3.3 1997.11.28
;;;   o boiled-canna-minibuffer-henkan-kakutei-and-self-insert $B$NDI2C(B
;;;     $BJQ498uJd0lMwI=<(Cf$K?t;z0J30$NJ8;z$rF~NO$7$?;~$K(B
;;;     fence-mode $B$GF~NO$5$l$k%P%0$NBP=h(B
;;;
;;; 3.2 1997.11.06
;;;   o char-category $B"M(B char-charset $B$KJQ49(B
;;;
;;; 3.1 1997.11.01
;;;   o $BJQ49Cf$N%-%c%s%;%k$G%m!<%^;z$,La$k$h$&$K=$@5(B
;;;     boiled-canna-cancel-or-kakutei-romaji $B$N(B boiled-canna-undo $B$r(B
;;;     $B%Q%i%a!<%?L5$7$K$7$?$iD>$C$?(B
;;;   o 20.2 $B$H(B 19.34 $B$G$NF0:n<B@S$O<h$C$?(B
;;;     19.28 $B$H(B XEmacs 20.x $B$O$I$&$J$k$+ITL@$G$9(B
;;;
;;; 3.0 1997.10.29
;;;   o emacs-20.2 + canna $B$X$NBP1~(B
;;;   o canna-undo $B$,;H$($J$/$J$C$?$N$G!":FJQ49=hM}$r<+J,$G<BAu$7$?(B
;;;   o string-to-char-list $B"M(B string-to-list $B$XJQ99(B
;;;   o string-memq $B"M(B memq $B$XJQ99(B 
;;;   o char-category $B"M(B char-charset $B$XJQ99(B
;;;     $B$3$l$KH<$$$A$g$C$H%G%0%l!<%I(B:
;;;     $BA43QJ8;z$NJQ49=hM}$,(B[$B$"(B-$B$s%"(B-$B%s#0(B-$B#9(B]$B$K$J$C$?(B
;;;   o $BJQ49Cf$N%-%c%s%;%k$G%m!<%^;z$,La$i$J$/$J$C$?!#%*%$%*%$(B
;;;
;;; 2.4	1996.06.27
;;;     $BH>3Q(BSPC $B$rJQ49$9$k%P%0BP=h(B
;;;	$BH>3Q%"%k%U%!%Y%C%H$rJQ49$9$k>l9g$K(B
;;;	boiled-canna:stop-char $B$K;XDj$7$?J8;zNs$rJQ49BP>]$H$7$J$$(B
;;;
;;; 2.3 1996.04.16
;;;	$B3F4X?t$X$N@bL@$NIUM?(B
;;;	quote $B$7$F$$$?ItJ,$r(B function $B$KJQ99(B
;;;
;;; 2.2 1995.11.16
;;;	undo $B8e$N5sF0IT?3$N0Y!"(Bboiled-canna-undo $B$rDI2C$7$?(B
;;;
;;; 2.1 1995.11.03
;;;	$B=hM}$N7ZNL2=(B
;;;
;;; 2.0 1995.11.02
;;;	fence-mode $B$K$$$k;~$G$b!"(B
;;;	mode-line-canna-mode $B$,(B "[ $B$"(B ]" $B$K$J$C$F$$$?$i(B
;;;	$BJ8;z$rF~NO$G$-$k$h$&$K$9$k(B
;;;
;;;	$BFI$_$KJQ99$,$"$j!"$+$D!"(B C-g $B$7$?;~$K(B
;;;	$B$=$NJQ99$r5[<}$7$?%m!<%^;z$rLa$9$h$&$K$9$k(B
;;;
;;;	$B>e5-JQ99$KH<$$!"(BC-h / C-? / delete $B$X$N(B
;;;	C-g $B5!G=$N3d$jEv$F$O<h$j;_$a$?(B
;;;	$B2C$($F!":FJQ49;~$N(B C-g $B$O(B
;;;	boiled-egg $B$HF1MM$K!"%m!<%^;z$,La$k$h$&$K$J$C$?(B
;;;	$B$=$s$J$D$b$j$OL5$+$C$?$1$I!"$^$!NI$7$H$7$h$&(B (^^;
;;;
;;; 1.4 1995.10.30
;;;	C-h / C-? / delete $B$K(B C-g $B$N5!G=$r3d$jEv$F$k(B
;;;
;;;	~/.canna $B$K(B (global-set-key "\C-j" 'next) $B$,L5$/$F$b(B
;;;	fence-mode $BCf$G$O<!8uJd$H$J$k$h$&$K$7$?(B
;;;
;;; 1.3 1995.10.24
;;;	undo $B$N6h@Z$jJQ99(B
;;;	$B$?$$$7$?;v$O$d$C$F$J$$$1$I(B
;;;	$BJQ49Cf$KF~NO$5$l$?J8;z$O(B
;;;	$B<!$N%$%s%?%W%j%?%k!<%W$K=hM}$5$;$k$h$&$KJQ99$7$?(B
;;;
;;; 1.2 1995.10.23
;;;	fence-mode $B$K$$$k;~$KJ8;z(B(\000-\040$B0J30(B)$B$,F~NO$5$l$?$i(B
;;;	$BJQ49Cf$NJ8;zNs$r3NDj$7$F!"(Bfence-mode $B$rH4$1(B
;;;	$BF~NO$5$l$?J8;z$r(B buffer $B$KF~$l$k$h$&$K$9$k(B
;;;
;;;	$B$d$C$Q$j!"JQ49Cf$N(B C-g $B$O0lH/$GJQ49Cf;_$K$9$k(B
;;;
;;; 1.1 1995.10.22
;;;	C-g $B$NF0:n$r(B boiled-egg $B$K9g$o$;$F(B canna $B$N5!G=$r0lItL58z$K$9$k$Y$-$+(B
;;;	boiled-egg $B$K9g$o$;$:$K(B canna $B$N5!G=$rA4$F;H$($k$h$&$K$9$k$Y$-$+(B
;;;	$BH=CG$G$-$J$$$N$G!"APJ}$N%$%s%?%U%'!<%9$rF~$l$F(B
;;;	$B%f!<%6$,H=CG$G$-$k$h$&$K$9$k(B
;;;
;;; 1.0 1995.10.19
;;;	undo / $B:FJQ49(B $B$,JQ$J$o$1H=L@(B
;;;	$B;z<oJQ49Cf$K(B C-g $B$,2!$5$l$?;~$K(B
;;;	canna:quit-canna-mode $B$r9T$$(B
;;;	canna:*region-start* $B$H(B canna:*region-end* $B$r(B
;;;	$BGK2u$7$F$$$?0Y(B
;;;
;;; 0.9 1995.10.16
;;;	$B3NDjD>8e$KJQ49%-!<$r2!$9$H:FJQ49$9$kMM$K$9$k(B
;;;
;;; 0.8 1995.10.14
;;;	$BJQ49Cf$K(B C-g $B$r2!$7$?;~$K!"JQ49A0$N>uBV$KLa$9(B
;;;	undo / $B:FJQ49(B $B$,JQ$+$bCN$l$J$$(B
;;;
;;; 0.7 1995.06.11
;;;	{\ca+|\ck+|[\cS\cA\cH\cK]+} (<-- mule $B$GBP1~$7$F$$$k@55,I=8=(B)
;;;	$B>e$G<($5$l$kJ8;zNs$rJQ49$9$k5!G=$rIU2C$9$k(B

(require 'canna)
(canna)

(defvar boiled-canna-rK-trans-key "\C-j")
(run-hooks 'boiled-canna-preload-hook)

(global-set-key "\C-o" 'open-line)
(global-set-key "\C-\\" 'canna-toggle-japanese-mode)

(defvar boiled-canna-toggle-buffer nil
  "boiled-canna $B$r(B toggle $B$9$k%l%Y%k$r@_Dj$9$k(B.
$BHs(Bnil $B$N;~!"(Bbuffer $BC10L(B.
nil $B$N;~!"A4$F$N(B buffer $BC10L(B")

(defvar boiled-canna-mode nil)
(or (assq 'boiled-canna-mode minor-mode-alist)
    (setq minor-mode-alist
	  (cons '(boiled-canna-mode " BC") minor-mode-alist)))

(defvar boiled-canna-mode-map (make-sparse-keymap))
(define-key boiled-canna-mode-map boiled-canna-rK-trans-key
  'boiled-canna-rK-trans)
(or (assq 'boiled-canna-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
;	  (append minor-mode-map-alist
;		  (list (cons 'boiled-canna-mode boiled-canna-mode-map)))))
	  (cons (cons 'boiled-canna-mode boiled-canna-mode-map)
		minor-mode-map-alist)))

;(defvar boiled-canna-fence-mode nil)
;(defvar boiled-canna-fence-mode-map (make-sparse-keymap))
;(define-key boiled-canna-fence-mode-map "\C-g" 'boiled-canna-keyboard-quit)
;(define-key boiled-canna-fence-mode-map boiled-canna-rK-trans-key
;  'boiled-canna-next)
;(define-key boiled-canna-fence-mode-map "\C-m" 'boiled-canna-func-kakutei)
(define-key canna-mode-map "\C-g" 'boiled-canna-keyboard-quit)
(let ((ch (1+ ?\ ))) ; "?\ "
  (while (< ch 127)
;    (define-key boiled-canna-fence-mode-map (char-to-string ch)
(define-key canna-mode-map (char-to-string ch)
      'boiled-canna-kakutei-self-insert)
    (setq ch (1+ ch))))
;(or (assq 'boiled-canna-fence-mode minor-mode-map-alist)
;    (setq minor-mode-map-alist
;	  (cons (cons 'boiled-canna-fence-mode boiled-canna-fence-mode-map)
;		minor-mode-map-alist)))

;(defvar boiled-canna-select-mode nil)
;(defvar boiled-canna-select-mode-map (make-sparse-keymap))
;(define-key boiled-canna-select-mode-map "\C-g"
;  (lookup-key canna-minibuffer-mode-map "\C-g"))
;(define-key boiled-canna-select-mode-map "\C-m"
;  (lookup-key canna-minibuffer-mode-map "\C-m"))
;(define-key boiled-canna-select-mode-map boiled-canna-rK-trans-key
;  (lookup-key canna-minibuffer-mode-map boiled-canna-rK-trans-key))
(let ((ch (1+ ?\ )))
  (while (< ch 127)
    (if (or (< ch ?1) (< ?9 ch))
;	(define-key boiled-canna-select-mode-map (char-to-string ch)
	(define-key canna-minibuffer-mode-map (char-to-string ch)
	  'boiled-canna-minibuffer-henkan-kakutei-and-self-insert))
    (setq ch (1+ ch))))
;(or (assq 'boiled-canna-select-mode minor-mode-map-alist)
;    (setq minor-mode-map-alist
;	  (cons (cons 'boiled-canna-select-mode
;		      boiled-canna-select-mode-map)
;		minor-mode-map-alist)))

;(defun boiled-canna-post-command-hook ()
;  (setq boiled-canna-select-mode
;	(or (and canna:*fence-mode* canna:*select-mode*)
;	    (equal (current-local-map) canna-minibuffer-mode-map))))
;(add-hook 'post-command-hook 'boiled-canna-post-command-hook)

(defvar boiled-canna:yomi nil
  "boiled-canna $B$,FI$_$NJQ99$r<1JL$9$k0Y$NJQ?t(B

$BJQ49BP>]J8;zNs$,@_Dj$5$l$k$N$G!"%f!<%6$,$3$NJQ?t$rJQ99$7$F$O$$$1$^$;$s(B")

(defvar boiled-canna:stop-char "(){}" ; boiled-egg $B$O(B (){} $B$rJQ49BP>]$K$7$J$$(B
  "$BH>3Q%"%k%U%!%Y%C%H$rJQ49$9$k;~$KJQ49BP>]$H$7$J$$J8;z$rJ8;zNs$H$7$F;XDj$9$k(B")

(defvar boiled-canna:skip-char nil)

;;; $B:FJQ49MQ$NDj5A(B
;; $B$3$NDj5A$,L5$$$H:FJQ49$5$l$?;~$KJ?2>L>$KLa$k$@$1(B
(setq canna-undo-hook
      (function (lambda ()
		  (message "$B:FJQ49$7$^$9(B....")
		  (canna-do-function canna-func-henkan))))
;; $B$J$s$G(B add-hook $B$G$-$J$$$s$@$!(B
;(setq canna-undo-hook nil)
;(add-hook 'canna-undo-hook
;	  (function (lambda ()
;		      (message "$B:FJQ49$7$^$9(B...")
;		      (canna-do-function canna-func-henkan))))



(defun boiled-canna-mode (&optional arg)
  "boiled-canna-mode $B$N5/F0$^$?$ODd;_(B.
$B@5$N0z?t$rH<$C$?>l9g$K$O6/@)E*$K(BON$B$K$9$k(B."
  (interactive "P")
  (if (and boiled-canna-toggle-buffer
	   (not (local-variable-p 'boiled-canna-mode)))
      (make-local-variable 'boiled-canna-mode))
  (setq boiled-canna-mode
	(if (null arg) (not boiled-canna-mode)
	  (> (prefix-numeric-value arg) 0)))
  (force-mode-line-update t)
  (if boiled-canna-mode
      (progn
;	(if (not (local-variable-p 'boiled-canna-fence-mode))
;	    (make-local-variable 'boiled-canna-fence-mode))
;	(if (boundp canna:*select-mode*)
;	    (if (not (local-variable-p 'boiled-canna-select-mode))
;		(make-local-variable 'boiled-canna-select-mode)))
	(if (null boiled-canna:skip-char)
	    (boiled-canna:set-skip-char boiled-canna:stop-char))
	(run-hooks 'boiled-canna-mode-hook))))


;;; $B%(%s%H%j!<%k!<%A%s(B
(defun boiled-canna ()
  "boiled-canna $B$N5/F0(B"
  (interactive)
  (boiled-canna-mode 1))

(if (eq emacs-major-version 20)
    (defun boiled-canna-char-charset (ch)
      (char-charset ch))
  (defun boiled-canna-char-charset (ch)
    (cond ((equal (char-category ch) "a") 'ascii)
	  ((equal (char-category ch) "k") 'katakana-jisx0201)
	  ((string-match "[SAHK]j" (char-category ch))
	   'japanese-jisx0208)
	  (t nil) )))

(if (null (fboundp 'string-to-list))
    (defun string-to-list (str)
      (string-to-char-list str)) )

;;;
;;; $BH>3Q%"%k%U%!%Y%C%H$rJQ49$9$k;~$K(B
;;; region $B$r:n$k0Y$K(B skip $B$9$kJ8;zNs$r@8@.$9$k(B
;;;
(defun boiled-canna:set-skip-char (stop-char)
  (setq boiled-canna:skip-char
	(let ((i (1+ ?\ ))
	      (chars))
	  (while (< i ?\177)
;	    (if (not (string-memq
;		      (char-to-string i)
;		      (mapcar 'char-to-string
;			      (string-to-char-list stop-char)
;			      (string-to-list stop-char) )))
	    (if (not (memq i (string-to-list stop-char))) ; modified 97.10.23
		(progn
		  (cond ((or (eq i ?\\) (eq i ?-) (eq i ?^))
			 (setq chars (concat chars "\\"))))
		  (setq chars (concat chars (char-to-string i)))))
	    (setq i (1+ i)))
	  chars)))

;;;
;;; canna $B$N<!8uJd(B $B5!G=$NF~8}4X?t(B
;;;
(defun boiled-canna-next ()
  (interactive)
  (canna-do-function canna-func-next)
  (canna:display-candidates 0))


(defun boiled-canna-rK-trans ()
  "$B4A;zJQ49$r3+;O$9$k(B ($BHs(B fence-mode $B$+$i(B fence-mode $B$X$N(B mode $BA+0\(B)

$B%]%$%s%H0JA0$NJ8;zNs$rJQ49BP>]$H$7$F4A;zJQ49$r9T$&!#(B
$B%]%$%s%HD>A0$NJ8;z<o$K$h$j0J2<$K<($9HO0O$rJQ49BP>]$H$9$k!#(B

	$B%]%$%s%HD>A0$NJ8;z<o(B	$BJQ49HO0O(B

	$BH>3Q(I6@6E(B		$B9TF,J}8~$XH>3Q(I6@6E$B$,B3$/HO0O(B
	$BH>3QJ8;z(B((I6@6E$B0J30(B)	$B9TF,J}8~$XH>3QJ8;z(B((I6@6E$B0J30(B)$B$,B3$/HO0O(B
	$BA43Q(B{$B$R$i$,$J(B|		$B9TF,J}8~$XA43Q(B{$B$R$i$,$J(B|
	     $B%+%?%+%J(B|		               $B%+%?%+%J(B|
	     $B?t;z(B|$B5-9f(B}		               $B?t;z(B|$B5-9f(B}$B$,B3$/HO0O(B

$B$?$@$7!">e=R$NHO0O$NCf$K(B region $B$,4^$^$l$k>l9g$K$O!"(Bregion $B$,JQ49HO0O$H$J$k!#(B
$B$^$?!"JQ493NDjD>8e$N>l9g!"3NDj$7$?J8;zNs$r:FEYJQ49BP>]$H$9$k!#(B

\\{canna-mode-map}
$BJQ49Cf$K(B \\[boiled-canna-keyboard-quit] $B$rF~NO$7$?>l9g!"(B
$BJQ49$rCf;_$7%m!<%^;z$KLa$9!#(B
$B$3$N;~!"FI$_$KJQ99$,$"$l$P!"$=$NJQ99$rH?1G$7$?%m!<%^;z$K$9$k!#(B

$B$5$i$K!"JQ49Cf$KH>3Q(B{$B%"%k%U%!%Y%C%H(B|$B?t;z(B|$B5-9f(B}$B$rF~NO$7$?>l9g$K$O!"(B
$BJQ49$r3NDj$7!"F~NO$5$l$?J8;zNs$r(B buffer $B$KA^F~$9$k!#(B


$B0J2<$O(B $B$*$^$1(B $B$G$9!#(B
boiled-canna $B$N(B fence-mode $B$G$N%-!<%P%$%s%I$rIU$1$F$_$^$7$?!#(B
$B>\:Y$O(B canna $B$N%I%-%e%a%s%H$r;2>H$7$F2<$5$$!#(B
$B4pK\E*$K(B canna $B$N%G%U%)%k%H%-!<%P%$%s%I$K=>$C$F$$$k$D$b$j$G$9!#(B

$BJQ49%b!<%I(B	$B%b!<%I%i%$%sI=<((B
$B4A;zJQ49%b!<%I(B	[$B4A;z(B]

			key		binding
			---		-------

			SPC		$B<!8uJd(B
			C-a		$B@hF,J8@a$X(B
			C-b		$B#1J8@aLa$k(B
			C-c		$BBP>]J8@a$N$_FI$_=$@5(B
			C-e		$B:G=*J8@a$X(B
			C-f		$B#1J8@a?J$`(B
			C-g		$BJQ49Cf;_(B
			C-h		$BFI$_=$@5(B
			TAB		$BJ8@a=L$a(B
			LFD		$B<!8uJd(B
			C-k		$BFI$_=$@5(B
			C-l		$B>.J8;zJQ49(B
			RET		$BJQ493NDj(B
			C-n		$B<!8uJd(B
			C-o		$BJ8@a?-$P$7(B
			C-p		$BA08uJd(B
			C-u		$BBgJ8;zJQ49(B
			C-w		$B8uJd0lMwI=<((B
			! .. ~		$BJQ493NDj8eF~NO(B


$B;z<oJQ49%b!<%I(B	[$B;z<o(B]

			key		binding
			---		-------

			SPC		$B4A;zJQ49(B
			C-a		$B@hF,J8@a$X(B
			C-b		$B#1J8@aLa$k(B
			C-c		$BBP>]J8@a$N$_FI$_=$@5(B
			C-e		$B:G=*J8@a$X(B
			C-f		$B#1J8@a?J$`(B
			C-g		$BFI$_=$@5(B
			C-h		$BFI$_=$@5(B
			TAB		$BJ8@a=L$a(B
			LFD		$B<!J8;z<o(B
			C-l		$B>.J8;zJQ49(B
			RET		$BJQ493NDj(B
			C-n		$B<!J8;z<o(B
			C-o		$BJ8@a?-$P$7(B
			C-p		$BA0J8;z<o(B
			C-u		$BBgJ8;zJQ49(B
			! .. ~		$BJQ493NDj(B


$BFI$_=$@5%b!<%I(B	[ $B$"(B ]

			key		binding
			---		-------

			SPC		$B4A;zJQ49(B
			C-a		$BFI$_$N@hF,$X(B
			C-b		$B#1J8;zLa$k(B
			C-d		$B#1J8;z:o=|(B
			C-e		$BFI$_$N=*C<$X(B
			C-f		$B#1J8;z?J$`(B
			C-g		$BJQ49Cf;_(B
			LFD		$B;z<oJQ49(B
			C-k		$B%]%$%s%H0J9_$NFI$_:o=|(B
			C-l		$B>.J8;zJQ49(B
			RET		$BJQ493NDj(B
			C-n		$B;z<oJQ49(B
			C-p		$B;z<oJQ49(B
			C-q		quoted-insert
			C-u		$BBgJ8;zJQ49(B
			! .. ~		$BFI$_F~NO(B"
  (interactive)

  ;; $B0JA0$NJQ49BP>]J8;zNs$rGK4~$9$k(B
  ;; $B$3$3$GGK4~$9$k;v$K$h$j(B
  ;; $B:FJQ49;~$K(B keyboard-quit $B$7$?>l9g$K(B
  ;; $B%m!<%^;z$KLa$k$h$&$K$J$k(B
  (if canna:*fence-mode*
      (boiled-canna-next)

    (setq boiled-canna:yomi nil)

    (if (and ;(eq last-command 'boiled-canna-func-kakutei)
	     ;(eq last-command-char
		 ;(string-to-char boiled-canna-rK-trans-key)))
	     (eq last-command 'canna-functional-insert-command)
	     (or (and (vectorp boiled-canna-rK-trans-key)
		      (equal (vector last-command-char)
			     boiled-canna-rK-trans-key))
		 (equal last-command-char
			(string-to-char boiled-canna-rK-trans-key))))
		 
	;; $BJQ493NDjD>8e$J$i:FJQ49$9$k(B
	(progn
;	  (message "$B:FJQ49$7$^$9(B...")
	  (boiled-canna-undo)
	  (setq unread-command-events (list last-command-event)) )

      (cond ((and (eq (boiled-canna-char-charset (preceding-char)) 'ascii))
	     ;; $B%+!<%=%k>e$NJ8;z$,H>3Q(B{$B%"%k%U%!%Y%C%H(B|$B?t;z(B|$B5-9f(B}$B$N>l9g(B
	     ;; $B%+!<%=%k>e$NJ8;z$,(B
	     ;; $BH>3Q(B{$B%"%k%U%!%Y%C%H(B|$B?t;z(B|$B5-9f(B}$B$N4V$r(B
	     ;; $BJQ49BP>]$H$9$k(B
	     (boiled-canna:henkan-function:alpha
	      (function canna-rk-trans-region)))

	    ((eq (boiled-canna-char-charset (preceding-char))
		 'katakana-jisx0201)
	     ;; $B%+!<%=%k>e$NJ8;z$,H>3Q%+%?%+%J$N>l9g(B
	     (boiled-canna:henkan-function
	      (function canna-henkan-region)
	      (function (lambda (ch)
		;; $B%+!<%=%k>e$NJ8;z$,(B
		;; $BH>3Q%+%?%+%J$N4V$r(B
		;; $BJQ49BP>]$H$9$k(B
                (eq (boiled-canna-char-charset ch) 'katakana-jisx0201) ))))

	    ((and (eq (boiled-canna-char-charset (preceding-char))
		      'japanese-jisx0208)
		  (not (string-match "[$B0!(B-$Bt$(B]"
				     (char-to-string (preceding-char)))))
	     ;; $B%+!<%=%k>e$NJ8;z$,A43Q(B{$B$R$i$,$J(B|$B%+%?%+%J(B|$B5-9f(B|$B?t;z(B}$B$N>l9g(B
	     (boiled-canna:henkan-function
	      (function canna-henkan-region)
	      (function (lambda (ch)
	        ;; $B%+!<%=%k>e$NJ8;z$,(B
	        ;; $BA43Q(B{$B$R$i$,$J(B|$B%+%?%+%J(B|$B5-9f(B|$B?t;z(B}$B$N4V$r(B
	        ;; $BJQ49BP>]$H$9$k(B
	        (and (eq (boiled-canna-char-charset ch)
			 'japanese-jisx0208)
		     (not (string-match
			   "[$B0!(B-$Bt$(B]"
			   (char-to-string (preceding-char))))) )) ))))))

(defun boiled-canna:henkan-function (function condition)
  "$BJQ49BP>]J8;zNs$r8!=P$7!"4A;zJQ49$9$k(B

$BJQ49BP>]$H$J$kHO0O$r@_Dj$7!"(BFUNCTION $B$r8F$V(B
$BJQ49BP>]$O8=:_$N(B point $B$+$i(B CONDITION $B$,@.N)$7$F$$$k4VLa$C$?=j$^$G$H$J$k(B
$B$?$@$7!"8!=P$7$?HO0O$NCf$K%^!<%/$,4^$^$l$F$$$?$i(B region $B$rJQ49HO0O$H$9$k(B"
  (let* ((end (point))
	 (start (progn
		  (let* ((mark-position (marker-position (mark-marker)))
			 (pos (if mark-position mark-position 1))
			 (mark-check (not (< pos (point))) ))
		    (while (and (or mark-check (< pos (point)))
				(eval (list condition (preceding-char))))
		      (backward-char)))
		  (point)) ))
    ;; $BJQ49BP>]J8;zNs$NJ]B8(B
    (setq boiled-canna:yomi (buffer-substring start end))

    (if (not (string= boiled-canna:yomi ""))
	;; boiled-canna $B$+$i(B fence-mode $B$KF~$C$?0u(B
	(setq boiled-canna-fence-mode t))
    ;; $BJQ49(B
    (eval (list function start end))))

(defun boiled-canna:henkan-function:alpha (function)
  "$BH>3Q%"%k%U%!%Y%C%H$rJQ49$9$k;~$KJQ49BP>]J8;zNs$r8!=P$7!"4A;zJQ49$9$k(B

$BJQ49BP>]$H$J$kHO0O$r@_Dj$7!"(BFUNCTION $B$r8F$V(B
($BJQ49BP>]30J8;zNs$r;XDj$9$k$K$O(B boiled-canna:stop-char $B$rMQ$$$k(B)
$B$?$@$7!"8!=P$7$?HO0O$NCf$K%^!<%/$,4^$^$l$F$$$?$i(B region $B$rJQ49HO0O$H$9$k(B"
  (let* ((end (point))
	 (gap (boiled-canna:skip-char-backward)))
    (goto-char end)
    (if (not (= gap 0))
	(progn
	  (setq boiled-canna:yomi (buffer-substring (+ end gap) end))
          (if (not (string= boiled-canna:yomi ""))
              (setq boiled-canna-fence-mode t))
	  (eval (list function (+ end gap) end)))) ))

(defun boiled-canna:skip-char-backward ()
  (let* ((mark-position (if (markerp (mark-marker))
			    (marker-position (mark-marker))
			  nil))
	 (pos (if mark-position mark-position 1)))
    (skip-chars-backward boiled-canna:skip-char
			 (if (< pos (point)) pos nil))))


(defun boiled-canna-keyboard-quit (arg)
  "$BJQ49Cf;_4X?t(B

$BJQ49A0$NJ8;zNs$rLa$9$h$&$K$9$k(B
$B$?$@$7!"FI$_(B($B%m!<%^;z(B)$B$KJQ99$,$"$C$?>l9g(B
$BJQ99$r5[<}$7$?%m!<%^;z$rLa$9(B"
  (interactive "*p")
  (let ((mode-string (canna-query-mode)))
    (cond ((and (not canna:*japanese-mode*)
		(or (equal mode-string "[$B4A;z(B]")
		    (equal mode-string "[ $B$"(B ]") ))
	   ;; boiled-canna $B$G(B fence-mode $B$KF~$C$?>l9g$H(B
	   ;; $B4A;zJQ49Cf$H!";z<oJQ49$N7k2L(B $BF~NO%b!<%I$K$J$C$?;~$O(B
	   ;; $BJQ49A0$NJ8;zNs$KLa$9(B
	   ;; $BFI$_$,JQ99$5$l$F$$$?>l9g$K$O(B
	   ;; $B$=$NJQJ,$r5[<}$7$?J8;zNs$rLa$9(B
	   (boiled-canna-cancel-or-kakutei-romaji))
	      
	  (t
	   ;; $B$=$NB>$N>l9g(B
	   ;; $B;z<oJQ49Cf$NF0:n$b$3$NItJ,$K4^$^$l$k(B
	   ;; $B;z<oJQ49Cf$K$O:FJQ49$G$-$k$h$&$K(B
	   ;; $BF~NO%b!<%I$K$9$k!"$D$^$j!";z<oJQ49$r;_$a$k$@$1(B
	   (canna-functional-insert-command arg)) )
    (setq boiled-canna-fence-mode nil) ))


(defun boiled-canna-cancel-or-kakutei-romaji ()
  "$B%m!<%^;z3NDj4X?t(B

$BJQ49$rCf;_$7JQ49BP>]J8;zNs$rJV$9(B
$B$?$@$7!"FI$_$KJQ99$,$"$C$?>l9g$K$O(B
$B$=$NJQ99$r5[<}$7$?7A$N%m!<%^;z$rJV$9(B"
  (if (or (and boiled-canna:yomi
	       (not (equal (boiled-canna-char-charset
			    (car (string-to-list boiled-canna:yomi)))
			   'ascii)))
	  (string= (boiled-canna-romaji) boiled-canna:yomi))
      ;; $BJQ49BP>]J8;zNs$,%m!<%^;z$G$J$$$+!"$b$7$/$O!"(B
      ;; $BJQ49BP>]J8;zNs$H%m!<%^;zJQ49$7$?7k2L$,0lCW$7$?$i(B
      ;; $BJQ49$rCf;_$7JQ49A0$NJ8;zNs$rLa$9(B
      (progn
	(boiled-canna-cancel)
	(if (and (boundp 'emacs-major-version)
		 (>= emacs-major-version 20))
	    (boiled-canna-undo)
	  (boiled-canna-undo 0)) )
    ;; $BFI$_$KJQ99$,$"$C$?>l9g(B
    ;; $B%m!<%^;zJQ49$r3NDj$9$k(B
    ;; $B:FJQ49;~$O$3$3$KMn$A$k(B
    (boiled-canna-kakutei)))

;; simple.el $B$+$i;}$C$FMh$?(B
;; minibuffer $B$K(B "Undo!" $B$r=PNO$9$k$N$r;_$a$k$@$1(B
(defun boiled-canna-undo (&optional arg)
  "Undo some previous changes.
Repeat this command to undo more changes.
A numeric argument serves as a repeat count."
  (interactive "*p")
  ;; If we don't get all the way thru, make last-command indicate that
  ;; for the following command.
  (setq this-command t)
  (let ((modified (buffer-modified-p))
	(recent-save (recent-auto-save-p)))
    (or (and (eq last-command 'undo)
	     (and (string-match "XEmacs" emacs-version)
		  (eq (current-buffer) last-undo-buffer)) ) ; XEmacs
	(progn (undo-start)
	       (undo-more 1)))
    (undo-more (or arg 1))
    ;; Don't specify a position in the undo record for the undo command.
    ;; Instead, undoing this should move point to where the change is.
    (let ((tail buffer-undo-list)
	  done)
      (while (and tail (not done) (not (null (car tail))))
	(if (integerp (car tail))
	    (progn
	      (setq done t)
	      (setq buffer-undo-list (delq (car tail) buffer-undo-list))))
	(setq tail (cdr tail))))
    (and modified (not (buffer-modified-p))
	 (delete-auto-save-file-if-necessary recent-save)))
  ;; If we do get all the way thru, make this-command indicate that.
  (setq this-command 'undo))

(defun boiled-canna-romaji ()
  "$B%m!<%^;zJQ494X?t(B

boiled-canna-cancel-or-kakutei-romaji $B$+$i8F$P$l$k;v$rA0Ds$H$9$k(B
$B$h$C$F!"B>$N4X?t$+$i8F$P$l$?>l9g$NF0:n$OJ]>Z$G$-$J$$(B
(boiled-canna-cancel-or-kakutei-romaji $B0J30$+$i8F$P$l$?;~$O(B
$B%m!<%^;zJQ49$G$-$kJ]>Z$,$J$$0Y(B)"
  (canna-do-function canna-func-beginning-of-line)
  (if (not (equal (canna-query-mode) "[$B4A;z(B]"))
      (canna-do-function canna-func-henkan))
  (while (not (= canna-henkan-length canna-henkan-revlen))
    ;; canna-henkan-length $B$H(B canna-henkan-revlen $B$,(B
    ;; $BF10lD9$K$J$k$^$GJ8@a$r?-$P$9;v$K$h$j(B
    ;; $BJQ49Cf$NJ8;zNs$rA4$F(B
    ;; $B$=$N8e$NBP>]J8;zNs$H$9$k;v$,$G$-$k(B
    (canna-do-function canna-func-extend))
  (canna-do-function canna-func-romaji)
  (canna-do-function canna-func-hankaku)
  canna-henkan-string)

;;; $BJQ496/@)=*N;(B($BJQ49J8;zNsGK4~(B)$B4X?t(B
(defun boiled-canna-cancel ()
  "$BJQ496/@)=*N;(B($BJQ49J8;zNsGK4~(B)$B4X?t(B"
  (canna-do-function canna-func-beginning-of-line)
  (if (not (equal (canna-query-mode) "[$B4A;z(B]"))
      (canna-do-function canna-func-henkan))
  (canna-do-function canna-func-kill-to-end-of-line)
      
  (if canna-henkan-string
      ;; canna 3.5 $B$@$H2?8N$+(B
      ;; (canna-do-function canna-func-kill-to-end-of-line)
      ;; $B$GF,$N#1J8;z;D$k$N$G$=$NBP=h(B
      (canna-do-function canna-func-delete_previous))
  (canna-do-function canna-func-quit)
  (canna:display-candidates 0))


;; $B8uJd0lMw$rI=<($7$F$$$k;~$K%-!<$r2!$7$?$iF0$+$94X?t(B
(defun boiled-canna-minibuffer-henkan-kakutei-and-self-insert (arg)
  (interactive "*p")
  (if (equal (canna-query-mode) "[$B0lMw(B]")
      (progn
	(canna-do-function canna-func-kakutei)
	(select-window canna:*previous-window*)
	(canna:display-candidates (length canna-kakutei-string))
	(boiled-canna-kakutei-self-insert arg)
	(setq boiled-canna-fence-mode nil))
    (if (and (boundp 'canna:*minibuffer-local-map-backup*)
	     canna:*minibuffer-local-map-backup*)
	(use-local-map canna:*minibuffer-local-map-backup*)
      (setq canna:*select-mode* nil))
    (set-window-buffer (minibuffer-window) canna:*saved-minibuffer*)
    (select-window canna:*previous-window*)
    (canna:functional-insert-command2 last-command-char arg)
    (setq boiled-canna-fence-mode nil) ))

(defun boiled-canna-func-kakutei (arg)
  (interactive "*p")
  (if (or canna:*japanese-mode*
	  (equal (canna-query-mode) "[ $B$"(B ]"))
      ;; $BF~NOCf(B
      (canna-functional-insert-command arg)

    ;; $B4A;zJQ49Cf(B
    (boiled-canna-kakutei)
    (setq boiled-canna-fence-mode nil) ))

;; $B$3$N4X?t$O(B canna.el $B$r;29M$K$7$?(B
(defun boiled-canna-kakutei-self-insert (arg)
  "$BJ8;z$rF~NO$9$k(B

$BJQ49Cf$KF~NO$5$l$?>l9g$K$OJQ49Cf$NJ8;zNs$r3NDj$7(B
$BF~NO$5$l$?J8;zNs$r(B buffer $B$KA^F~$9$k(B"
  (interactive "*p")

  (if (or canna:*japanese-mode*
	  (equal (canna-query-mode) "[ $B$"(B ]"))
      ;; $BF~NOCf(B
      (canna-functional-insert-command arg)

    ;; $B4A;zJQ49Cf(B
    (boiled-canna-kakutei)
    (setq boiled-canna-fence-mode nil)
    ;; $B%-!<F~NO$r<!$N%$%s%?%W%j%?%k!<%W$K=hM}$5$;$k(B
    (setq unread-command-events (list last-command-event))) )

;; $B$3$N4X?t$O(B canna.el $B$r;29M$K$7$?(B
(defun boiled-canna-kakutei ()
  "$BJQ49$r3NDj$9$k(B"
  (let ((res)
	(kakutei canna-henkan-string))
    (while (not canna-empty-info)
      (setq res (canna-do-function canna-func-kakutei)))
    ;; $BJQ49Cf$NJ8;zNs$+$i6uGr$r:o=|$7$F3NDjJ8;zNs$r:n$k(B
    (setq canna-kakutei-string (boiled-canna-delete-space kakutei))
    (canna:display-candidates (length canna-kakutei-string))
    (mode-line-canna-mode-update canna:*alpha-mode-string*))
  (setq boiled-canna-fence-mode nil))

(defun boiled-canna-delete-space (str)
  "$B6uGr:o=|4X?t(B

canna-henkan-string $B$+$i6uGr$r:o=|$9$k(B"
  (let ((res)
	(chr (string-to-list str)))
    (while chr
      (if (not (eq (car chr) ?\ ))
	  (setq res (concat res (char-to-string (car chr)))))
      (setq chr (cdr chr)))
    res))

(provide 'boiled-canna)
