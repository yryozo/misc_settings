;;; Use Powershell (instead of cmd.exe)
(global-set-key "\M-s" 'powershell)

;;;; 最近の dired-mode では \M-s が別のコマンドに割り当てられているので, 明示的に上書き
(add-hook 'dired-mode-hook
	  '(lambda () (local-set-key "\M-s" 'powershell)))

