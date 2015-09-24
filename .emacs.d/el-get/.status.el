((dmacro status "removed" recipe nil)
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (ffap- status "installed" recipe
	(:name ffap- :auto-generated t :type emacswiki :description "Extensions to library `ffap.el'" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/ffap-.el"))
 (hideshow-org status "removed" recipe nil)
 (howm status "removed" recipe nil)
 (sicp status "installed" recipe
       (:name sicp :description "The second edition of the book Structure and Interpretation of Computer Programs (SICP) in info format" :type http :url "http://www.neilvandyke.org/sicp-texi/sicp.info.gz" :build
	      ("gunzip -f sicp.info.gz")
	      :info "sicp.info")))
