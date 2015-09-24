;;; cuda-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (cuda-mode) "cuda-mode" "cuda-mode.el" (22018 52842
;;;;;;  335861 861000))
;;; Generated autoloads from cuda-mode.el

(add-to-list 'auto-mode-alist '("\\.cu\\'" . cuda-mode))

(autoload 'cuda-mode "cuda-mode" "\
Major mode for editing CUDA.
Cuda is a C like language extension for mixed native/GPU coding
created by NVIDIA
 
The hook `c-mode-common-hook' is run with no args at mode
initialization, then `cuda-mode-hook'.

Key bindings:
\\{cuda-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("cuda-mode-pkg.el") (22018 52842 365925
;;;;;;  99000))

;;;***

(provide 'cuda-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cuda-mode-autoloads.el ends here
