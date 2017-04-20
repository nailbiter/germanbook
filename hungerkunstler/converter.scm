(use-modules (srfi srfi-98))
(load (string-concatenate (list (get-environment-variable "HOME")"/for/forscheme/misc.scm")))

;(define srcname (cadr(command-line)))

(let* ((raw (read-delimited "" (current-input-port)))
       )(display "hi"))
            
