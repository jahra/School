;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;Game: Survive plane crash
;;;;;Author: Jan Hrabal
;;;;;Date: 2016-10-10

;;start
(defvar *game-plan* (list 
 ;;room number  | story | posibilities | healt lost
 '(1 ("Ocitáš se na neznámém ostrově, kde jsi jediný přeživší zříceného letadla. Právě stojíš na pláži a v dálce slyšíš šumění vodopádu." "1. Pokračovat po pláži." "2. Jít k vodopádu. " ) (2 3) 0)
 '(2 ("Došel jsi na konec pláže, nic tu není. Pláž pozvolna mizí v nedalekém lese.  Najednou v hustém křoví objevuješ vstup do jeskyně." "1. Jít do jeskyně." "2. Jít do lesa.") (4 6) 0)
 '(3 ("Došel jsi k vodopádu, s úžasem zíráš na tu přírodní krásu a nevšiml sis, že se v trávě plazí had. Kousl tě!(-1 život)" "1. Projdeš vodopádem do jeskyně." "2. Pokusíš se vylézt na vodopád.") (4 8) 1)
 '(4 ("Jsi v jeskyni, před tebou se cesta dělí do tří tunelů. " "1. Jít levým tunelem." "2. Jít prostředním tunelem." "3. Jít pravým tunelem.") (7 6 5) 0)
 '(5 ("Špatně jsi odhadl strukturu tunelu, zřítil se strop a uvěznil tě v jeskyni. Z toho se už nedostaneš." ) () 10)
 '(6 ("Šel jsi dlouhou cestu, prolézáš křovím a ocitáš se na kraji lesa. Slyšíš podivné zvuky a najednou uvidíš sele uvězněné pod spadeným stromem." "1. Pomůžeš ubohému zvířeti. " "2. Ignoruješ to a pokračuješ dál.") (9 11) 0)
 '(7 ("Došel jsi do místnosti plné netopýrů. Snažíš se opatně našlapovat, aby jsi je nevzbudil, ale nepodařilo se. Netopýři útočí!(-1 život). Nemáš kam utéct, najednou zahlédneš denní světlo." "1. Rychle se vydáš za světlem. " "2. Zůstaneš a pokusíš se bojovat s netopýry.") (6 14) 1)
 '(8 ("Šplháš nahoru, naneštěstí uklouzneš na mokrém kameni a spadneš dolů. Při pádu jsi si zlomil ruku a obě nohy, z toho se už nedostaneš.") () 10)
 '(9 ("Jakmile jsi se přiblížil k seleti, zaútočila na tebe rozzuřená divoká svině. (-1 život). Utekl jsi, ale naneštěstí jsi se ztratil." "1. Jít na východ." "2. Jít na západ.") (10 11) 1)
 '(10  ("Došel jsi k bažině, přes bažinu vedé stará lávka. Najednou v dálce uvidíš nějaké světlo. Nejspíš plápolající oheň." "1. Jít přes bažinu." "2. Jít za světlem.") (12 13) 0)
 '(11 ("Došel jsi na kraj lesa. Po pravé straně vidíš v dálce moře. Zaujme tě, ale úplně  něco jiného, v dálce vidíš nějaké světlo, možná někdo dělá táborák." "1. Jít k moři." "2. Jít ke světlu.") (16 13) 0)
 '(12 ("Lávka nevydržela a ty se zoufale snažíš dostat z bažiny,ale nejde to. Utopil jsi se.") () 10)
 '(13 ("Přiblížil jsi se ke zdroji světla, vidíš lidožravé domorodce jak pojídají nějakého člověka. Zřejmě si je vyrušil a vydávájí se s oštěpy za tebou" "1. Zkusíš utéct přes lávku krz bažinu. " "2. Otočíš se a budeš utíkat zpátky do lesa." "3. Pokusíš se přemoci jednoho strážce, bránící loďku u řeky a odplout.") (12 15 17) 0)
 '(14 ("Tvé síly na hejno netopýrů nestačili.") () 10)
 '(15 ("Domorodci tě dohonili a snědli.") () 10)
 '(16 ("Došel jsi k malé pláži obklopené skalami. Před tebou je obří krab. Zahnal jsi ho, ale uštědřil ti pár ran. (-1 život)." "1. Jít zpátky k lesu. ") (11) 1)
 '(17 ("Utekl jsi domorodcům. Řeka ústila do moře a doplul jsi na vedlejší obydlený ostrov, kde byla tvá záchrana.") () 0)))

(defvar *actual-state* '(0 0 3)) ;(actual-positon health-points max-hp)

(defun actual-position ()
  (first *actual-state*))

(defun hp ()
  (second *actual-state*))

(defun set-hp (value)
  (setf (second *actual-state*) value))

(defun actual-room ()
  (assoc (first *actual-state*) *game-plan*))

(defun print-story ()
  (format t "~a" (first (second (actual-room)))))

(defun print-hp ()
  (format t "~%Počet životů: ~s. Co uděláš?" (hp)))

(defun print-choices ()
  (dolist (x (cdr (second (actual-room)))) (format t "~%~a" x)))

(defun list-choices ()
  (third (actual-room)))

(defun set-room (room-nmbr)
  (setf (first *actual-state*) room-nmbr))

(defun credits ()
  (format t "~%~a" "Vytvořil Jan Hrabal, 10.10. 2016"))

(defun choose (number)
  (if (and (> number 0) (<= number (length (list-choices))));;if choosen number is in valid range
      (progn 
        (set-room (nth (- number 1) (list-choices)))
        (if (=(first (first (last *game-plan*))) (actual-position));;at the end?
            (progn
              (print-story)
              (format t "~%~a~%~a" "GRATULUJI K DOKONČENÍ HRY" "pro novovou hru napiš (start)" )
              (credits))
          (progn
          
            (print-story)
            (set-hp (- (hp) (fourth (actual-room))))
            (if (< (hp) 1)
                (format t "~%~a~%~a~%~a" "Došly ti životy, jsi mrtvý!" "KONEC HRY" "pro novou hru napiš (start)")
              (progn
                (print-hp)
                (print-choices))))))
    (format t "~%Zadal jsi špatnou možnost. Zkus to znova." )))

(defun start ()
  (setf *actual-state* (list 1 (third *actual-state*) (third *actual-state*)))
  (format t "~%Hra se ovádá příkazem choose, např. (choose 1)~%")
  (print-story)
  (print-hp)
  (print-choices))