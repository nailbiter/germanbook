(use-modules (srfi srfi-98))
(load (string-concatenate (list (get-environment-variable "HOME")"/for/forscheme/misc.scm")))

(define counter (make-variable (string->number(caddr(command-line)))))

(let* ((raw (read-delimited "" (current-input-port)))
       (rawlist (mytokenize "\n" raw))
       (min2sec (lambda(expr)(let*((match(string-match "([0-9]*):" expr))
                                   (num(if(eq? match #f)(string->number expr)(+(* 60 (string->number(match:substring match 1)))(string->number(string-drop expr(inc(string-index expr #\:)))) )))
                                   (res(lambda()(number->string num)))
                               )(res))))
;;       (rawlist (map(lambda(line)(let*
;;                                   ((res(string-match "^([0-9].*)$"  line))
;;                                   (func(lambda(num)(format #f "<span id=\"~a\" data-endon=\"~a\">~%</span>" (begin(inc-var counter)(variable-ref counter))(min2sec num)))))
;;                                        (if(eq? #f res)line (func(match:substring res 1)))))rawlist))
;;       (count (length rawlist))
       (my-extractor (letrec((res (lambda(l crit func buf return)
                                    (cond
                                      ((null? l) return)
                                      ((crit(car l)) (res (cdr l) crit func '() (append return (list (func (car l) buf)))))
                                      (else (res (cdr l) crit func (append buf (list (car l))) return))
                                      )))) (lambda(l crit func)(res l crit func '() '()))))
       (rawlist (my-extractor rawlist 
;;                              (lambda(s)#t)(lambda(s buf)s)
                              (lambda(s)(not(eq? #f (string-match "^([0-9].*)$" s))))
                              (lambda(s buf)(format #f "<span id=\"~a\" data-endon=\"~a\">~a</span>" (begin(inc-var counter)(variable-ref counter))
                                                    (min2sec (match:substring (string-match "^([0-9].*)$" s) 1))(string-concatenate(map(lambda(s)(format #f "~a~%" s)) buf))))
                              ))
         ;(lambda(l crit func))
       (res(lambda()(map (lambda(line)(format #t "~a~%" line))rawlist)))
       )(res))
;;TODO: output last id at end
