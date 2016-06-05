;;; ELPA が使用する url.el 用の proxy 設定
; (setq url-using-proxy t)
; (setq url-proxy-services  '(("http"  . "hogehoge-proxy.fuga.com:8888")
;                             ("https" . "hogehoge-proxy.fuga.com:8888")))

;;;; proxy にパスワードが必要な場合
; (setq url-http-proxy-basic-auth-storage
;       (list (list "hogehoge-proxy.fuga.com:8888"
;                   (cons "/"
;                         (base64-encode-string "my_username:my_password")))))
