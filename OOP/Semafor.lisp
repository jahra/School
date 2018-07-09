;(load (current-pathname "load.lisp"))             ;;;;
;(load (current-pathname "05.lisp"))               ;;;;
;(load (current-pathname "05_light.lisp"))       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;Jan Hrabal;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DOKUMENTACE
-----------
SEMAPHORE
Třída semaphore je potomkem třídy picture. Její instance představují semafor,
kterému lze přempínat jednotlivé fáze. 

UPRAVENÉ ZDĚDĚNÉ VLASTNOSTI

žádné

NOVÉ VLASTNOSTI

 **SEM-TYPE**   :   Globální proměnná, do které může uživatel přidat vlastní typ semaforu podle vzoru 
                              stávajících typů    
semaphore-phase:   Číslo fáze ve které se semafor aktuálně nachází.
count-phase:       Počet fází semaforu.
semaphore-type:    Typ semaforu (pro chodce, pro vozidla). Ve výchozím stavu pro vozidla.
phase-list:        Seznam fází semaforu 


UPRAVENÉ ZDĚDĚNÉ ZPRÁVY

žádné

NOVÉ ZPRÁVY

set-semaphore-phase   Nastaví fázi semaforu (číslo fáze)
set-count-phase       Nastaví počet fází (počet fází)
set-semaphore-type    Nastaví typ semaforu (:vehicle nebo :pedestrian)
next-phase            Přechod od jedné fáze k druhé (bez parametru)
set-phase             Přepne semafor do fáze (číslo fáze)
lights                Seznam světel semaforu.

|#

(defclass semaphore (picture) 
  ((semaphore-phase :initform 0)
   (count-phase :initform 0)
   (semaphore-type :initform :none)
   (phase-list :initform :none)))

(defmethod initialize-instance ((sem semaphore) &key)
  (call-next-method)
  (set-semaphore-type sem :vehicle))

(defmethod semaphore-phase ((s semaphore))
  (slot-value s 'semaphore-phase))

(defmethod count-phase ((s semaphore))
  (slot-value s 'count-phase))

(defmethod semaphore-type ((s semaphore))
  (slot-value s 'semaphore-type))

(defmethod phase-list ((s semaphore))
  (slot-value s 'phase-list))

(defmethod set-phase-list ((s semaphore) list)
  (setf (slot-value s 'phase-list) list))

(defmethod set-semaphore-phase ((s semaphore) value)
  (setf (slot-value s 'semaphore-phase) value)
  (set-phase s value)
  s)

(defmethod set-count-phase ((s semaphore) value)
  (setf (slot-value s 'count-phase) value)
  s)

(defvar **SEM-TYPE** (list 
                           ;type  phase-cnt    phase-list             '(items)
                      (list :vehicle 4 (list '(1 0 0) '(1 1 0) '(0 0 1) '(0 1 0))                                  
                            '(list
                              (move (set-on-color (set-off-color (set-radius (make-instance 'light) 20) :gray) :red) 25 25)
                              (move (set-on-color (set-off-color (set-radius (make-instance 'light) 20) :gray) :orange) 25 67)
                              (move (set-on-color (set-off-color (set-radius (make-instance 'light) 20) :gray) :green) 25 109)
                              (set-items (set-filledp (make-instance 'polygon) t)
                                         (list 
                                          (move (make-instance 'point) 0 0)
                                          (move (make-instance 'point) 50 0)
                                          (move (make-instance 'point) 50 134)
                                          (move (make-instance 'point) 0 134))
                                         )))
                      (list :pedestrian 2 (list '(1 0) '(0 1))
                            '(list 
                              (move (set-on-color (set-off-color (set-radius (make-instance 'light) 20) :gray) :red) 25 25)
                              (move (set-on-color (set-off-color (set-radius (make-instance 'light) 20) :gray) :green) 25 67)                         
                              (set-items (set-filledp (make-instance 'polygon) t)
                                         (list 
                                          (move (make-instance 'point) 0 0)
                                          (move (make-instance 'point) 50 0)
                                          (move (make-instance 'point) 50 92)
                                          (move (make-instance 'point) 0 92)))))))

(defmethod lights((s semaphore))
  (let ((l '()))
    (dolist (x (items s))
      (if (eql (type-of x) 'light)
          (setf l (append l (list x)))))
    l))

(defmethod set-semaphore-type ((s semaphore) semaphore-type)
  (let ((items (cdr (assoc semaphore-type **sem-type**))))
    (set-count-phase s (first items))
    (set-phase-list s (second items))
    (set-items s (eval (third items)))
    (set-phase s 0)
    (setf (slot-value s 'semaphore-type) semaphore-type))
  s)

(defmethod set-phase ((s semaphore) value)  
  (let ((next (nth value (phase-list s))))
    (dotimes (n (length next))
      (if (= 1 (nth n next))
          (set-on (nth n (lights s)))
        (set-off (nth n (lights s))))))
  (setf (slot-value s 'semaphore-phase) value)
  s)

(defmethod next-phase ((s semaphore))
  (let ((val (+ 1 (semaphore-phase s))))
    (if (< val (count-phase s))
        (set-phase s val)
      (set-phase s 0))))
          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;TESTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
(setf w (make-instance 'window))
(setf sem (make-instance 'semaphore))
(setf semb (make-instance 'semaphore))
(set-semaphore-type semb :pedestrian)
(move semb 0 200)
(setf pic (make-instance 'picture))
(set-items pic (list sem semb))
(set-shape w pic)
(redraw w)
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

DOKUMENTACE
-----------
CROSSROADS
Třída crossroads je potomkem třídy picture. Její instance představují křižovatku,
které lze přempínat jednotlivé fáze. 

UPRAVENÉ ZDĚDĚNÉ VLASTNOSTI

žádné

NOVÉ VLASTNOSTI

crossroads-phase    Číslo fáze ve které se křižovatka aktuálně nachází.
phase-count         Počet fází křižovatky.
program             Seznam fází križovatky, sekvence konfigurací semaforů

UPRAVENÉ ZDĚDĚNÉ ZPRÁVY

žádné

NOVÉ ZPRÁVY

set-crossroads-items    Nastaví objekty křižovatky (bez parametru)
phase-init              Nastaví počáteční fázi křižovatky (bez parametru)
next-phase              Přechod od jedné fáze k druhé (bez parametru)
semaphores              Vrací seznam semaforů křižovatky

|#

(defclass crossroads (picture)
  ((crossroads-phase :initform 0)
   (phase-count :initform 0)
   (program :initform nil)))

(defmethod crossroads-phase ((c crossroads))
  (slot-value c 'crossroads-phase))

(defmethod phase-count ((c crossroads))
  (slot-value c 'phase-count))

(defmethod program ((c crossroads)) 
  (slot-value c 'program))

(defmethod set-crossroad-phase ((c crossroads) value)
  (setf (slot-value c 'crossroads-phase) value)
  c)

(defmethod set-phase-count ((c crossroads) value)
  (setf (slot-value c 'phase-count) value)
  c)

(defmethod set-program ((c crossroads) list)
  (set-phase-count c (length list))
  (setf (slot-value c 'program) list)
  c)

(defmethod semaphores((c crossroads))
  (let ((semlist '()))
    (dolist (x (items c))
      (if (eql (type-of x) 'semaphore)
          (setf semlist (append semlist (list x)))))
    semlist))

(defmethod next-phase ((c crossroads))
  (if (eql (crossroads-phase c) (- (phase-count c) 1))
      (set-crossroad-phase c 0) 
    (set-crossroad-phase c (+ 1 (crossroads-phase c))))  
  (let ((next (nth (crossroads-phase c) (program c))))
    (dotimes (n (length next))
      (set-semaphore-phase (nth n (semaphores c)) (nth n next))))
  c)

;;;pomocná fce, vrátí list polygonů představující silnice křižovatky
(defmethod make-roads () 
  (list
   (move (set-color (set-items (set-filledp (make-instance 'polygon) t)
                               (list 
                                (move (make-instance 'point) 0 0)
                                (move (make-instance 'point) 2000 0)
                                (move (make-instance 'point) 2000 100)
                                (move (make-instance 'point) 0 100))) :gray32) 0 200)
   (move (set-color (set-items (set-filledp (make-instance 'polygon) t)
                               (list 
                                (move (make-instance 'point) 0 0)
                                (move (make-instance 'point) 100 0)
                                (move (make-instance 'point) 100 2000)
                                (move (make-instance 'point) 0 2000))) :gray32) 400 0)))

;;;pomocná, demosntrační, vytvoří instance semaforů
(defmethod set-crossroads-items ((c crossroads))
  (set-items c (append (list 
            (make-instance 'semaphore) 
                        (set-semaphore-type (make-instance 'semaphore) :pedestrian)
                      (make-instance 'semaphore) 
                        (set-semaphore-type (make-instance 'semaphore) :pedestrian) 
                       (make-instance 'semaphore) 
                        (set-semaphore-type (make-instance 'semaphore) :pedestrian) 
                        (make-instance 'semaphore) 
                        (set-semaphore-type (make-instance 'semaphore) :pedestrian))
                       (make-roads))))

;;;pomocná funkce, rozmístí semafory
(defmethod set-semaphores-positions ((c crossroads))
  (move (first (semaphores c)) 550 330)
  (move (second (semaphores c)) 500 330)
  
  (move (third (semaphores c)) 580 66)
  (move (fourth (semaphores c)) 530 66)
  
  (move (fifth (semaphores c)) 350 36)
  (move (sixth (semaphores c)) 300 36)
  
  (move (seventh (semaphores c)) 320 300)
  (move (eighth (semaphores c)) 270 300))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Testing;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
(setf w (make-instance 'window))
(setf cr (make-instance 'crossroads))
(set-crossroads-items cr)
(set-semaphores-positions cr)
(set-background w :forestgreen)
(set-program cr '((0 1 2 0 0 1 2 0) (1 1 3 0 1 1 3 0) (2 0 0 1 2 0 0 1) (3 0 1 1 3 0 1 1)))
(set-shape w cr)
(redraw w)
(dotimes  (n 20) (next-phase cr) (sleep 2) (redraw w))
|#