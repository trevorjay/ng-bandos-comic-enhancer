(progn ;;libs
 (let ((quicklisp-init "/home/tfulp/projects/bcb/ql/setup.lisp"))
   (when (probe-file quicklisp-init)
     (load quicklisp-init)))

 (ql:quickload :parenscript)

 (defpackage :enh (:use :common-lisp :parenscript))
 (in-package :enh))

(defmacro code-src (&rest body)
  `(define-symbol-macro code (ps (progn ,@body))))

(code-src
 
 (defun b094-bce ()
   (with-slots (st) b094-bce
     (setf st 0)
     (setf idx 0)
     (setf img null)
     (setf img-obs null)
     (setf i 0)
     (setf org-title "")
     (setf star-title ""))
   
   (defun fetch$ (url ms)
     (when (@ document hidden) (return-from fetch$))
     (defun star (ign)
       (when (= ms 0) (setf (@ document title) (@ b094-bce star-title))))
     (let ((img (new -image)))
       (setf (@ img onload) #'star)
       (set-timeout (lambda () (setf (@ img src) url)) ms)))

   (defun error$ (msg)
     (chain console (log (concatenate 'string "BCE: error - " msg)))
     (setf (@ document title) (concatenate 'string (decode-u-r-i-component (escape (atob "4p2X"))) (@ b094-bce org-title))))
  
   (defun main ()
     (with-slots (st idx img img-obs i org-title star-title used) b094-bce
       (case st
	 (0
	  ;; setup
	  (when (defined used)
	    (return-from main))
	  (setf used true)

	  (setf org-title (@ document title))
	  (setf star-title (concatenate 'string  (decode-u-r-i-component (escape (atob "4pyo"))) org-title))
	  (setf (@ document title) (concatenate 'string  (decode-u-r-i-component (escape (atob "4o+z"))) org-title))
		 
	  (unless (and (defined ng-image-viewer)
		   (defined (@ ng-image-viewer current-gallery))
		   (defined (@ ng-image-viewer galleries))
		   (defined (aref (@ ng-image-viewer galleries) (@ ng-image-viewer current-gallery))))
	      (return-from main (error$ "gallery not found")))

	  (chain document (add-event-listener "visibilitychange" (lambda () (unless (@ document hidden) (setf st 1) (main)))))

	  (chain (new (-mutation-observer
		       (lambda (muts)
			 (when (loop named not-text
				     for mut across muts
				     do (when (= (@ mut type) "childList")
					  (loop for node across (@ mut added-nodes)
						do (when (not (chain (chain (@ node node-name) (to-lower-case)) (includes "text")))
						     (return-from not-text true)))
					  (loop for node across (@ mut removed-nodes)
						do (when (not (chain (chain (@ node node-name) (to-lower-case)) (includes "text")))
						     (return-from not-text true)))))
			   (setf st 1)
			   (main)))))
		 (observe (@ document body) (create subtree true child-list true)))

	  (incf st)
	  (return-from main (set-timeout main 0)))
       
	 (1
	  ;; possible mode change

	  (when (not (null img-obs))
	    (chain img-obs (disconnect)))
	  (setf img-obs null)

	  (setf i 0)
	  (incf st)
	  (return-from main (set-timeout main 0)))

	 (2
	  ;; looking for viewer	  
	  (incf i)

	  (setf img (chain document (query-selector "img[data-elem=\"image\"]")))

	  (when (and (null img) (< i 3))
	    (return-from main (set-timeout main 168)))

	  (incf st)
	  (return-from main (set-timeout main 0)))

	 (3
	  ;; setting up img-obs

	  (when (null img)
	    (setf img (chain document (query-selector "img[data-item=\"image\"]"))))
	
	  (when (null img)
	    (return-from main (setf (@ document title) (concatenate 'string  (decode-u-r-i-component (escape (atob "8J+Ujg=="))) org-title))))

	  (setf img-obs (new (-mutation-observer (lambda () (setf st 4) (main)))))
	  (chain img-obs (observe img (create attribute-filter (list "src"))))

	  (incf st)
	  (return-from main (set-timeout main 0)))

	 (otherwise
	  ;;preload

	  (setf (@ document title) org-title)
	
	  (when (or (@ document hidden) (null img))
	    (return-from main))
	
	  (let ((gallery (aref (@ ng-image-viewer galleries) (@ ng-image-viewer current-gallery))))	    
	    (loop named search
		  for j from 0 to (- (@ gallery length) 1)
		  do (progn
		       (when (= (@ (aref gallery j) src) (@ img src))
			 (setf idx j)
			 (return-from search))
		       (when (= (@ (aref gallery j) config preview) (@ img src))
			 (setf idx j)
			 (loop named prevs
			       for k from (+ j 1) to (- (@ gallery length) 1)
			       with ms = 0
			       do (if (> k (+ j 2))
				      (return-from prevs)
				      (progn
					(fetch$ (@ (aref gallery k) config preview) ms)
					(setf ms (+ ms 250)))))
			 (return-from main))))
	   
	    (loop named meds
		  for k from (+ idx 1) to (- (@ gallery length) 1)
		  with ms = 0
		  do (if (> k (+ idx 2))
			 (return-from meds)
			 (progn
			   (fetch$ (@ (aref gallery k) src) ms)
			   (setf ms (+ ms 250))))))))
       ))
   
   (main)
   null)
 (b094-bce)
 
 )

(with-open-file
    (out
     "/home/tfulp/projects/bcb/bce.html"
     :direction :output
     :if-exists :supersede)
  (format out "~a"
	  (ps-html
	   (:html
	    (:body
	     (:script
	      (ps
		(chain document (write
				 (concatenate 'string
					      "javascript:"
					      (encode-u-r-i-component (chain
								       (chain (lisp code) (replace (new (-reg-exp "\\n")) ""))
								       (replace (new (-reg-exp "\\s+" "g")) " ")))))))))))))

(with-open-file
    (out
     "/home/tfulp/projects/bcb/bce.js"
     :direction :output
     :if-exists :supersede)
  (format out "~a" code))
