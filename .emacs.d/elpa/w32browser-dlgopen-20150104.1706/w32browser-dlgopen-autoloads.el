;;; w32browser-dlgopen-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (dlgopen-open-files) "w32browser-dlgopen" "w32browser-dlgopen.el"
;;;;;;  (22038 32720 708594 847000))
;;; Generated autoloads from w32browser-dlgopen.el

(autoload 'dlgopen-open-files "w32browser-dlgopen" "\
Open files using the Windows standard Open dialog box.
Var `dlgopen-executable-path' is path of executable `getfile.exe'.

If `w32-browser' is defined, then it is used to open the selected
files.  Otherwise, standard Emacs `find-file' functions are used.

If `w32-browser' is not defined, then `dlgopen-other-window'
controls how selected files are opened:
  non-nil => Display chosen file(s) in separate windows.
  nil     => Display a single chosen file in the current window;
             don't display multiple chosen files.

Optional prefix arg FLIP non-nil reverses the effect of variable
`dlgopen-other-window', for this call.

\(fn &optional FLIP)" t nil)

;;;***

;;;### (autoloads nil nil ("w32browser-dlgopen-pkg.el") (22038 32720
;;;;;;  730588 340000))

;;;***

(provide 'w32browser-dlgopen-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; w32browser-dlgopen-autoloads.el ends here
