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

;;;### (autoloads nil nil ("el-get/el-get-autoloads.el" "el-get/el-get-build.el"
;;;;;;  "el-get/el-get-byte-compile.el" "el-get/el-get-core.el" "el-get/el-get-custom.el"
;;;;;;  "el-get/el-get-dependencies.el" "el-get/el-get-install.el"
;;;;;;  "el-get/el-get-methods.el" "el-get/el-get-notify.el" "el-get/el-get-recipes.el"
;;;;;;  "el-get/el-get-status.el" "hideshow-org/hideshow-org.el"
;;;;;;  "howm/action-lock.el" "howm/bcomp.el" "howm/cheat-font-lock.el"
;;;;;;  "howm/gfunc.el" "howm/honest-report.el" "howm/howm-backend.el"
;;;;;;  "howm/howm-cl.el" "howm/howm-common.el" "howm/howm-date.el"
;;;;;;  "howm/howm-lang-en.el" "howm/howm-lang-ja.el" "howm/howm-menu-en.el"
;;;;;;  "howm/howm-menu-ja.el" "howm/howm-menu.el" "howm/howm-misc.el"
;;;;;;  "howm/howm-mkmenu.el" "howm/howm-mode.el" "howm/howm-reminder.el"
;;;;;;  "howm/howm-vars.el" "howm/howm-version.el" "howm/howm-view.el"
;;;;;;  "howm/howm.el" "howm/illusion.el" "howm/riffle.el") (20925
;;;;;;  804 656562 272000))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here