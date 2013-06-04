;;; rdgrep.el --- RD grep -*-emacs-lisp-*-

;; Copyright (c) 2003 Masayuki Ataka <ataka@milk.freemail.ne.jp>
;; $Id: rdgrep.el,v 1.5 2003/07/31 13:42:41 m1378502 Exp $

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
(provide 'rdgrep)
(require 'clgrep)

(defvar rdgrep-major-mode 'rdgrep-mode)
(defvar rdgrep-memo-separate "[ \t\n]+\n== ")
(defvar rdgrep-header-regexp "^= ")

;;;###autoload
(defun rdgrep (query &optional arg)
  "Run grep for RD file and collect output in a buffer.

A wrapper program of `clgrep' for RD."
  (interactive "sRD grep regexp: \nP")
  (let ((clgrep-major-mode    rdgrep-major-mode)
	(clgrep-memo-separate rdgrep-memo-separate)
	(clgrep-header-regexp rdgrep-header-regexp))
    (clgrep query arg)))

;;;###autoload
(defun rdgrep-title ()
  (interactive)
  (let ((clgrep-lookup-method 'title))
    (call-interactively 'rdgrep)))

;;;###autoload
(defun rdgrep-header ()
  (interactive)
  (let ((clgrep-lookup-method 'title))
    (call-interactively 'rdgrep)))

;;;###autoload
(defun rdgrep-other-window ()
  (let ((clgrep-open-other-window (not clgrep-open-other-window)))
    (call-interactively 'rdgrep)))

;;;###autoload
(defun rdgrep-yardm ()
  (interactive)
  (require 'yardm)
  (set-buffer (find-file-noselect yardm-file-name))
  (call-interactively 'rdgrep))


;;;
;;; rdgrep mode
;;;

(define-derived-mode rdgrep-mode clgrep-mode "rdgrep"
  (set (make-local-variable 'paragraph-start) "= \\|== \\|\f")
  (set (make-local-variable 'paragraph-separate) paragraph-start)
  (set (make-local-variable 'page-delimiter) "^\\(= \\|\f\\)")
  (set (make-local-variable 'clgrep-memo-start) rdgrep-memo-separate)
  (set (make-local-variable 'clgrep-header-start) rdgrep-header-regexp)
  (when (and (fboundp 'defface) (locate-library "rd-mode"))
    (require 'rd-mode)
    (set (make-local-variable 'font-lock-defaults)
	 `((,@rd-font-lock-keywords ,@clgrep-font-lock-keywords)
	   t nil nil backward-paragraph))))

;;
;; keymap
;;
(let ((map rdgrep-mode-map))
  (define-key map "g" 'rdgrep)
  (define-key map "t" 'rdgrep-title)
  (define-key map "H" 'rdgrep-header)
  (substitute-key-definition
   'clgrep-kill-ring-save 'kill-ring-save map clgrep-mode-map)
  (substitute-key-definition
   'clgrep-copy-to-register 'copy-to-register map clgrep-mode-map)
  ;; set keymap
  (setq rdgrep-mode-map map))

;;; rdgrep.el ends here

;; Local Variables:
;; fill-column: 72
;; End:
