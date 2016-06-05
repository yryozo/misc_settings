;; helm-migemo (20150817.750) の buf fix
; <http://rubikitch.com/2014/12/19/helm-migemo/>
(require 'helm-migemo)
;;; この修正が必要
(eval-after-load "helm-migemo"
  '(progn
     (defun helm-compile-source--candidates-in-buffer (source)
       (helm-aif (assoc 'candidates-in-buffer source)
           (append source
                   `((candidates
                      . ,(or (cdr it)
                             (lambda ()
                               ;; Do not use `source' because other plugins
                               ;; (such as helm-migemo) may change it
                               (helm-candidates-in-buffer (helm-get-current-source)))))
                     (volatile) (match identity)))
         source))
     ;; [2015-09-06 Sun]helm-match-plugin -> helm-multi-match変更の煽りを受けて
     (defalias 'helm-mp-3-get-patterns 'helm-mm-3-get-patterns)
     (defalias 'helm-mp-3-search-base 'helm-mm-3-search-base)))
