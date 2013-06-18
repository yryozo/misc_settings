((dmacro status "removed" recipe nil)
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (hideshow-org status "installed" recipe
	       (:name hideshow-org :description "Provides org-mode like hide and show for hideshow.el" :type github :pkgname "secelis/hideshow-org"))
 (howm status "removed" recipe nil)
 (sicp status "installed" recipe
       (:name sicp :description "The second edition of the book Structure and Interpretation of Computer Programs (SICP) in info format" :type http :url "http://www.neilvandyke.org/sicp-texi/sicp.info.gz" :build
	      ("gunzip -f sicp.info.gz")
	      :info "sicp.info")))
