;;; basic list functions
(defun select (f l)
  (cond ((null l) ())
	((funcall f (car l))
	 (cons (car l) (select f (cdr l))))
	(t
	 (select f (cdr l)))))

(defun reject (f l)
  (cond ((null l) ())
	((funcall f (car l))
	 (reject f (cdr l)))
	(t
	 (cons (car l) (reject f (cdr l))))))

(defun collect (f l)
  (cond ((null l) ())
	(t
	 (cons (funcall f (car l))
	       (collect f (cdr l))))))

(defun detect (f l)
  (cond ((null l) ())
	((funcall f (car l))
	 (car l))
	(t
	 (detect f (cdr l)))))

(defun inject (f l init)
  (cond ((null l) init)
	(t
	 (inject f (cdr l) (funcall f (car l) init)))))

(defun all (f l)
  (cond ((null l) t)
	((funcall f (car l))
	 (all f (cdr l)))
	(t ())))

(defun any (f l)
  (cond ((null l) ())
	((funcall f (car l)) t)
	(t
	 (any f (cdr l)))))

