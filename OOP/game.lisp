;;Name: Txt game
;;Author: Jan Hrabal
;;Date: 2016-5-10

;;start
(defvar *game-plan* (list 
 ;;room number  | story | posibilities | healt lost
 '(0 "zivoty" (1) 3)    ;inicializace hp
 '(1 ("Ocitáš se na neznámém ostrově, kde jsi jediný přeživší zříceného letadla. Právě stojíš na pláži a v dálce slyšíš šumění vodopádů." "1. Pokračovat po pláži" "2. Jít k vodopádu. " ) (2 3) 0)
 '(2 ("Došel jsi na konec pláže, nic tu není. Pláž pozvolna mizí v nedalekém lese.  Najednou v hustém křoví objevuješ vstup do jeskyně." "1. Jít do jeskyně" "2. Jít do lesa") (4 6) 0)
 '(3 ("Došel jsi k vodopádu, s úžasem zíráš na tu přírodní krásu a nevšiml sis, že se v trávě plazí had. Kousl tě!(-1 život)" "1. Projdeš vodopádem do jeskyně." "2. Pokusíš se vylézt na vodopád.") (4 8) 1)
 '(4 ("Jsi v jeskyni, před tebou se cesta rozvětvuje do tří tunelů. " "1. Jít levým tunelem" "2. Jít prostředním tunelem" "3. Jít prabým tunelem") (7 6 5) 0)
 '(5 ("Špatně jsi odhadnul strukturu tunelu, zřítil se strop a uvěznil tě v jeskyni. Z toho se už nedostaneš." ) (17) 0)
 '(6 ("Šel jsi dlouhou cestu, nakonec prolézáš křovím a ocitáš se na kraji lesa. Slyšíš podivné zvuky a najednou uvidíš sele uvězněné pod spadeným stromem." "1. Pomomůžeš ubohému zvířeti. " "2. Ignoruješ to a pokračuješ dál.") (9 11) 0)
 '(7 ("Došel jsi do místnosti plné netopírů. Snažíš se opatně našlapovat aby jsi je nevzbudil, ale nepodařilo se. Netopíři útočí!(-1 život). Nemáš kam utéct, najednou zahlédneš denní světlo." "1. Rychle se vydáš za světlem " "2. Zůstaneš a pokusíš se bojovat s netopíry.") (6 17) 1)
 '(8 ("Šplháš nahoru, naneštěstí uklouzneš na mokrém kameni a spadneš dolů. Při pádu jsi si zlomil ruku a obě nohy, z toho se už nedostaneš.") () 10)
 '(9 ("Jakmile jsi se přiblížil k seleti zaútočila na tebe rozzuřená divoká svině (-1 život). Utekl jsi, ale naneštěstí jsi se ztratil." "1. Jít na východ." "2. Jít na západ.") (10 11) 1)
 '(10  ("Došel jsi k bažině, přes bažinu vedé stará lávka. Najednou v dálce uvidíš nějaké světlo. Nejspíš plápolající oheň." "1. Jít přes bažinu." "2. Jít za světlem.") (12 13) 0)
 '(11 ("Došel jsi na kraj lesa. Po pravé straně vidíš v dálce moře. Zaujme tě, ale úplně  něco jiného, v dálce vidíš nějaké světlo, možná někdo dělá táborák." "1. Jít k moři." "2. Jítke světlu.") (16 13) 0)
 '(12 ("Lávka nevydržela a  ty se zoufale snažíš dostat z bažiny,ale nejde to. Utopil jsi se.") () 10)
 '(13 ("Přiblížil jsi se ke zdroji světla, vidíš lidožravé domorodce jak pojídají nějkého člověka, žřejmě si je vyrušil a vydávájí se s oštěpama za tebou" "1. Zkusíš utéct přes lávku krz bažinu. " "2. Otočíš se a budeš utíkat zpátky do lesa" "3. Pokusíš se přemoct jednoho strážce, bránící loďku u řeky a odplout.") (12 15 14) 0)
 '(14 ("Utekl jsi domorodců. Řeka ústila do moře a doplul jsi na vedlejší obydlený ostrov, kde byla tvá záchrana.") () 0)
 '(15 ("Domorodci tě dohonili a snědli.") () 10)
 '(16 ("Došel jsi k malé pláži obklopené skalami. Před tebou je obří krab. Zahnal jsi ho, ale uštědřil ti pár ran. (-1 život)." "1. Jít zpátky k lesu. ") (11) 1)
 '(17 ("Jsi mrtev. Konec hry.") () 10)))

(defvar *actual-state* '(0 0)) ;(actual positon . health points)

(defun find-room ()
  (assoc (first *actual-state*) *game-plan*))

(defun print-story ()
  (format t "~a" (first (second (find-room)))))

(defun print-hp ()
  (format t "~%Počet životů: ~s. Co uděláš?" (second *actual-state* )))

(defun print-choices ()
  (dolist (x (cdr (second (find-room)))) (format t "~%~a" x)))

(defun list-choices ()
  (third (find-room)))

(defun set-room (room-nmbr)
  (setf (first *actual-state*) room-nmbr))

(defun choose (number)
  (if (and (> number 0) (<= number (length (list-choices))))
      (progn 
        ;(setf (first *actual-state*) number)
        (set-room (nth (- number 1) (list-choices)))
        (print-story)
        (setf (second *actual-state*) (- (second *actual-state*) (fourth (find-room))))
        (if (< (second *actual-state*) 1)
            (format t "~%~a" "Došli ti životy, jsi mrtvý!")
          (progn
            (print-hp)
            (print-choices))))
    (format t "~%Zadal jsi špatnou možnosti , mužeš volit pouze: ~s" (caddr (find-room)))))

(defun start ()
  (setf *actual-state* (list 1 (fourth (assoc 0 *game-plan*))))
  (format t "~%Hra se ovádá příkazem choose, např. (choose 1)~%")
  (print-story)
  (print-hp)
  (print-choices))