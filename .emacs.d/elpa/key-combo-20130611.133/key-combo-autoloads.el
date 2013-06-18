;;; key-combo-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads (key-combo-load-default key-combo-define-hook global-key-combo-mode
;;;;;;  key-combo-mode) "key-combo" "key-combo.el" (20928 16259 98495
;;;;;;  642000))
;;; Generated autoloads from key-combo.el

(autoload 'key-combo-mode "key-combo" "\
Toggle key combo.

\(fn &optional ARG)" t nil)

(defvar global-key-combo-mode nil "\
Non-nil if Global-Key-Combo mode is enabled.
See the command `global-key-combo-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-key-combo-mode'.")

(custom-autoload 'global-key-combo-mode "key-combo" nil)

(autoload 'global-key-combo-mode "key-combo" "\
Toggle Key-Combo mode in all buffers.
With prefix ARG, enable Global-Key-Combo mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Key-Combo mode is enabled in all buffers where
`key-combo-mode-maybe' would do it.
See `key-combo-mode' for more information on Key-Combo mode.

\(fn &optional ARG)" t nil)

(autoload 'key-combo-define-hook "key-combo" "\


\(fn HOOKS NAME KEYS)" nil t)

(autoload 'key-combo-load-default "key-combo" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("key-combo-pkg.el" "n-gram.el") (20928
;;;;;;  16259 102173 965000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; key-combo-autoloads.el ends here
