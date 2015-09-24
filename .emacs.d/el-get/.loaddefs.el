;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (el-get-checksum el-get-make-recipes el-get-cd
;;;;;;  el-get-self-update el-get-update-all el-get-version) "el-get/el-get"
;;;;;;  "el-get/el-get.el" (20924 62529 859330 904000))
;;; Generated autoloads from el-get/el-get.el

(autoload 'el-get-version "el-get/el-get" "\
Message the current el-get version

\(fn)" t nil)

(autoload 'el-get-update-all "el-get/el-get" "\
Performs update of all installed packages.

\(fn &optional NO-PROMPT)" t nil)

(autoload 'el-get-self-update "el-get/el-get" "\
Update el-get itself.  The standard recipe takes care of reloading the code.

\(fn)" t nil)

(autoload 'el-get-cd "el-get/el-get" "\
Open dired in the package directory.

\(fn PACKAGE)" t nil)

(autoload 'el-get-make-recipes "el-get/el-get" "\
Loop over `el-get-sources' and write a recipe file for each
entry which is not a symbol and is not already a known recipe.

\(fn &optional DIR)" t nil)

(autoload 'el-get-checksum "el-get/el-get" "\
Compute the checksum of the given package, and put it in the kill-ring

\(fn PACKAGE &optional PACKAGE-STATUS-ALIST)" t nil)

;;;***

;;;### (autoloads (el-get-list-packages) "el-get/el-get-list-packages"
;;;;;;  "el-get/el-get-list-packages.el" (20924 62529 859330 904000))
;;; Generated autoloads from el-get/el-get-list-packages.el

(autoload 'el-get-list-packages "el-get/el-get-list-packages" "\
Display a list of packages.

\(fn)" t nil)

;;;***

;;;### (autoloads (ffap-inhibit-ffap-flag ffap-bindings) "ffap-/ffap-"
;;;;;;  "ffap-/ffap-.el" (20932 25819 3375 342000))
;;; Generated autoloads from ffap-/ffap-.el

(defvar ffap-bindings '((global-set-key [S-mouse-2] 'ffap-at-mouse) (global-set-key [C-S-mouse-2] 'ffap-menu) (global-set-key "" 'find-file-at-point) (global-set-key "4f" 'ffap-other-window) (global-set-key "5f" 'ffap-other-frame) (global-set-key "d" 'dired-at-point) (when (fboundp 'ffap-alternate-file) (global-set-key "" 'ffap-alternate-file) (global-set-key "" 'ffap-read-only) (global-set-key "4r" 'ffap-read-only-other-window) (global-set-key "5r" 'ffap-read-only-other-frame) (global-set-key "4d" 'ffap-dired-other-window) (global-set-key "5d" 'ffap-dired-other-frame) (global-set-key "" 'ffap-list-directory)) (add-hook 'gnus-summary-mode-hook 'ffap-gnus-hook) (add-hook 'gnus-article-mode-hook 'ffap-gnus-hook) (add-hook 'vm-mode-hook 'ffap-ro-mode-hook) (add-hook 'rmail-mode-hook 'ffap-ro-mode-hook)) "\
*List of key-binding forms evaluated by function `ffap-bindings'.")

(custom-autoload 'ffap-bindings "ffap-/ffap-" t)

(defvar ffap-inhibit-ffap-flag nil "\
*Non-nil means that `ffap-*' functions should do nothing special.
For example, `ffap' then acts simply as `find-file' (or, more
precisely, as `ffap-file-finder').")

(custom-autoload 'ffap-inhibit-ffap-flag "ffap-/ffap-" t)

;;;***

;;;### (autoloads nil nil ("el-get/el-get-autoloads.el" "el-get/el-get-build.el"
;;;;;;  "el-get/el-get-byte-compile.el" "el-get/el-get-core.el" "el-get/el-get-custom.el"
;;;;;;  "el-get/el-get-dependencies.el" "el-get/el-get-install.el"
;;;;;;  "el-get/el-get-methods.el" "el-get/el-get-notify.el" "el-get/el-get-recipes.el"
;;;;;;  "el-get/el-get-status.el" "hideshow-org/hideshow-org.el")
;;;;;;  (22022 101 389477 327000))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
