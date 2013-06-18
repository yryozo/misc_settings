Minor mode that enables the ability of having a custom keys for
working with regions.  This is a pretty good way to keep the global
bindings clean.

Installation:

Add this to your .emacs:

(add-to-list 'load-path "/folder/containing/file")
(require 'region-bindings-mode)
(region-bindings-mode-enable)
