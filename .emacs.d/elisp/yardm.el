;; yardm.el --- Yet another RD Memo -*-emacs-lisp-*-

;; Copyright (c) 2003 Masayuki Ataka <ataka@milk.freemail.ne.jp>
;; $Id: yardm.el,v 1.2 2003/07/31 13:53:32 m1378502 Exp $

;; Author: Masayuki Ataka <ataka@milk.freemail.ne.jp>
;; Keywords: tools, convenience

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 59 Temple Place, Suite 330; Boston, MA 02111-1307, USA.


;;; Code:
(provide 'yardm)
(require 'clmemo)

(autoload 'rdgrep "rdgrep" "grep mode for RD file." t)
(autoload 'rdgrep-title "rdgrep" "grep first line of entry in RD." t)
(autoload 'rdgrep-header "rdgrep" "grep header line of RD." t)
(autoload 'rdgrep-clmemo "rdgrep" "clgrep directly RD MEMO." t)

(defvar yardm-file-name "~/yardm.txt"
  "*yardm file name.")

(defvar yardm-full-name nil)
(defvar yardm-mail-address nil)

(defvar yardm-header-regexp "^= ")
(defvar yardm-memo-separate "[ \t\n]+\n== ")
(defvar yardm-replace-entry "^== \\(.+\\):")
(defvar yardm-dummy-entry "\n== DUMMY: \n")
(defvar yardm-call-rdgrep 'rdgrep-yardm)

(defun yardm (arg)
  (interactive "P")
  (let ((clmemo-file-name yardm-file-name)
	(clmemo-header-regexp yardm-header-regexp)
	(clmemo-memo-separate yardm-memo-separate)
	(clmemo-new-entry 'yardm-add-entry-other-window)
	(clmemo-dummy-entry yardm-dummy-entry)
	(clmemo-call-clgrep yardm-call-rdgrep)
	(clmemo-replace-entry yardm-replace-entry))
    (call-interactively 'clmemo)))

(defun yardm-add-entry-other-window (whoami file-name)
  (yardm-add-entry whoami file-name t))

(defun yardm-add-entry (whoami file-name &optional other-window)
  (or yardm-full-name
      (setq yardm-full-name (user-full-name)))
  (or yardm-mail-address
      (setq yardm-mail-address user-mail-address))
  (unless (equal file-name buffer-file-name)
    (if (or other-window (window-dedicated-p (selected-window)))
	(find-file-other-window file-name)
      (find-file file-name)))
  (let* ((date   (funcall add-log-time-format))
	 (header (format "= %s  %s  <%s>\n" date yardm-full-name yardm-mail-address))
	 (pos    (point-min)))
    ;; Jump to RD beginning tag "=begin"
    (goto-char pos)
    (unless (re-search-forward "^=begin.*\n\n" nil t)
      (goto-char pos))
    ;; Insert entry
    (if (not (re-search-forward (concat yardm-header-regexp date) nil t))
	;; New header and entry
        (progn
          (insert header)
	  (insert yardm-dummy-entry)
	  (insert "\n")
	  (backward-char 1))
      ;; New entry
      (forward-line 1)
      (insert yardm-dummy-entry))
    (backward-char 1)))

;;
;; yardm mode
;;

(defvar yardm-mode nil)
(make-variable-buffer-local 'yardm-mode)

(defun yardm-mode (&optional arg)
  "Minor mode to insert entry with completion for RD MEMO.
For more information, See function `yardm'.

\\{yardm-mode-map}
"
  (interactive "P")
  (if (< (prefix-numeric-value arg) 0)
      (setq yardm-mode nil)
    (setq yardm-mode t)))

(defvar yardm-mode-map nil)
(if yardm-mode-map
    nil
  (let ((map (copy-keymap clmemo-mode-map)))
    (setq yardm-mode-map map)))

(unless (assq 'yardm-mode minor-mode-alist)
  (setq minor-mode-alist
	(cons '(yardm-mode " MEMO") minor-mode-alist)))

(unless (assq 'yardm-mode minor-mode-map-alist)
  (setq minor-mode-map-alist
	(cons (cons 'yardm-mode yardm-mode-map) minor-mode-map-alist)))

