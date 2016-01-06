(clear)
(open "./src/main/java/output/wyniki.txt" file "w")

;;import wymaganych bibliotek i plikow
(import nrc.fuzzy.*)
(import nrc.fuzzy.jess.*)
(load-package FuzzyFunctions)
(batch ./src/main/java/scripts/zmienne.clp)


;;deklaracja zmiennych rozmytych
(defglobal ?*poziomPaliwa* = (new FuzzyVariable "poziom_paliwa" 0 100 "stopien"))
(defglobal ?*predkosc* = (new FuzzyVariable "predkosc*" 0 100 "stopien"))
(defglobal ?*ciag* = (new FuzzyVariable "ciag" 0 100 "stopien"))

(defglobal ?*statek_kosmiczny* = 0)


;;regula startowa inicjujaca proces wnioskowania rozmytego
(defrule init
 (declare (salience 100))
=>
 (import nrc.fuzzy.*)
 (load-package nrc.fuzzy.jess.FuzzyFunctions)

(bind ?rlf (new RightLinearFunction)) (bind ?llf (new LeftLinearFunction))

(?*poziomPaliwa* addTerm "maly" (new TriangleFuzzySet 0 0 25))
(?*poziomPaliwa* addTerm "sredni" (new TriangleFuzzySet 0 25 50))
(?*poziomPaliwa* addTerm "duzy" (new TriangleFuzzySet 25 50 75))
(?*poziomPaliwa* addTerm "bardzo_duzy" (new TriangleFuzzySet 50 75 100))
(?*poziomPaliwa* addTerm "pelny_bak" (new TriangleFuzzySet 75 100 100))

(?*predkosc* addTerm "mala" (new TriangleFuzzySet 0 0 25))
(?*predkosc* addTerm "srednia" (new TriangleFuzzySet 0 25 50))
(?*predkosc* addTerm "duza" (new TriangleFuzzySet 25 50 75))
(?*predkosc* addTerm "bardzo_duza" (new TriangleFuzzySet 50 75 100))
(?*predkosc* addTerm "pelna_predkosc" (new TriangleFuzzySet 75 100 100))

(?*ciag* addTerm "slaby" (new TriangleFuzzySet 0 0 25))
(?*ciag* addTerm "sredni" (new TriangleFuzzySet 0 25 50))
(?*ciag* addTerm "duzy" (new TriangleFuzzySet 25 50 75))
(?*ciag* addTerm "bardzo_duzy" (new TriangleFuzzySet 50 75 100))
(?*ciag* addTerm "pelna_moc" (new TriangleFuzzySet 75 100 100))

(printout file "" crlf)
(printout file "System ekspertowy - logika rozmyta " crlf)
(printout file "" crlf)
(printout file "Sterownik rozmyty dla statku kosmicznego" crlf)
(printout file "" crlf)
(printout file "Jako wynik otrzymujemy poziom ustawienia ciagu statku kosmicznego " crlf)
(printout file "" crlf)
(printout file "Poziom jest z przedzialu 0 do 100 " crlf)
(printout file "" crlf)
(printout file "gdzie 0 to slaby ciag a 100 to pelna moc " crlf)
(printout file "" crlf)



;;po wczytaniu z pliku dane wejsciowe zapisywane sa do odpowiedniej formy faktu w celu przeprowadzenia procesu wnioskowania
;;temperatura wewnatrz
(assert (crispPoziomPaliwa ?*poziomPal*))
(assert (PozPal (new FuzzyValue ?*poziomPaliwa* (new TriangleFuzzySet ?*poziomPal* ?*poziomPal* ?*poziomPal* ))))

;;temperatura zewnatrz
(assert (crispPredkosc ?*predk*))
(assert (Predk (new FuzzyValue ?*predkosc* (new TriangleFuzzySet ?*predk* ?*predk* ?*predk* ))))
)

(defrule regula1
(PozPal ?tw&:(fuzzy-match ?tw "maly"))
(Predk ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula1" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "slaby"))))

(defrule regula2
(PozPal ?tw&:(fuzzy-match ?tw "sredni"))
(Predk ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula2" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "slaby"))))

(defrule regula3
(PozPal ?tw&:(fuzzy-match ?tw "duzy"))
(Predk ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula3" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "sredni"))))

(defrule regula4
(PozPal ?tw&:(fuzzy-match ?tw "bardzo_duzy"))
(Predk ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula4" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "sredni"))))

(defrule regula5
(PozPal ?tw&:(fuzzy-match ?tw "pelny_bak"))
(Predk ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula5" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "duzy"))))

(defrule regula6
(PozPal ?tw&:(fuzzy-match ?tw "maly"))
(Predk ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula6" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "slaby"))))

(defrule regula7
(PozPal ?tw&:(fuzzy-match ?tw "sredni"))
(Predk ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula7" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "sredni"))))

(defrule regula8
(PozPal ?tw&:(fuzzy-match ?tw "duzy"))
(Predk ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula8" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "sredni"))))

(defrule regula9
(PozPal ?tw&:(fuzzy-match ?tw "bardzo_duzy"))
(Predk ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula9" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "duzy"))))

(defrule regula10
(PozPal ?tw&:(fuzzy-match ?tw "pelny_bak"))
(Predk ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula10" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "bardzo_duzy"))))

(defrule regula11
(PozPal ?tw&:(fuzzy-match ?tw "maly"))
(Predk ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula11" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "sredni"))))

(defrule regula12
(PozPal ?tw&:(fuzzy-match ?tw "sredni"))
(Predk ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula12" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "sredni"))))

(defrule regula13
(PozPal ?tw&:(fuzzy-match ?tw "duzy"))
(Predk ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula13" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "duzy"))))

(defrule regula14
(PozPal ?tw&:(fuzzy-match ?tw "bardzo_duzy"))
(Predk ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula14" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "bardzo_duzy"))))

(defrule regula15
(PozPal ?tw&:(fuzzy-match ?tw "pelny_bak"))
(Predk ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula15" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "bardzo_duzy"))))

(defrule regula16
(PozPal ?tw&:(fuzzy-match ?tw "maly"))
(Predk ?tz&:(fuzzy-match ?tz "bardzo_duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula16" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "sredni"))))

(defrule regula17
(PozPal ?tw&:(fuzzy-match ?tw "sredni"))
(Predk ?tz&:(fuzzy-match ?tz "bardzo_duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula17" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "duzy"))))

(defrule regula18
(PozPal ?tw&:(fuzzy-match ?tw "duzy"))
(Predk ?tz&:(fuzzy-match ?tz "bardzo_duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula18" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "bardzo_duzy"))))

(defrule regula19
(PozPal ?tw&:(fuzzy-match ?tw "bardzo_duzy"))
(Predk ?tz&:(fuzzy-match ?tz "bardzo_duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula19" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "bardzo_duzy"))))

(defrule regula20
(PozPal ?tw&:(fuzzy-match ?tw "pelny_bak"))
(Predk ?tz&:(fuzzy-match ?tz "bardzo_duza"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula20" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "pelna_moc"))))

(defrule regula21
(PozPal ?tw&:(fuzzy-match ?tw "maly"))
(Predk ?tz&:(fuzzy-match ?tz "pelna_predkosc"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula21" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "duzy"))))

(defrule regula22
(PozPal ?tw&:(fuzzy-match ?tw "sredni"))
(Predk ?tz&:(fuzzy-match ?tz "pelna_predkosc"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula22" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "bardzo_duzy"))))

(defrule regula23
(PozPal ?tw&:(fuzzy-match ?tw "duzy"))
(Predk ?tz&:(fuzzy-match ?tz "pelna_predkosc"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula23" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "bardzo_duzy"))))

(defrule regula24

(PozPal ?tw&:(fuzzy-match ?tw "bardzo_duzy"))
(Predk ?tz&:(fuzzy-match ?tz "pelna_predkosc"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula24" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "pelna_moc"))))

(defrule regula25
(PozPal ?tw&:(fuzzy-match ?tw "pelny_bak"))
(Predk ?tz&:(fuzzy-match ?tz "pelna_predkosc"))
=>
(bind ?*statek_kosmiczny* 1)
(printout t "regula25" crlf)
(assert (StatekKosmiczny (new FuzzyValue ?*ciag* "pelna_moc"))))


;;regula odpowiadajaca za proces wnioskowania rozmytego, nastepuje tutaj defuzyfikacja, wnioskowanie, wyostrzanie, zapisanie wynikow do pliku
(defrule control
(declare (salience -100))

?tem_wew <- (crispPoziomPaliwa ?tw)
?tem_zew <- (crispPredkosc ?tz)


?klimat <- (StatekKosmiczny ?fuzzyStatekKosmiczny)


=>

    (bind ?crispStatekKosmiczny (?fuzzyStatekKosmiczny momentDefuzzify))


	;;wyswietlanie wynikow wnioskowania w konsoli
    (printout file "" crlf)
    (printout file "Dla poziomu paliwa = " ?tw " , i predkosci = " ?tz crlf)




    (bind ?zmienna1 (* ?crispStatekKosmiczny 1))



    ;;zaokraglanie wynikow do 2 miejsc po przecinku
   (bind ?aaa (round  (* ?zmienna1 100)))

   (bind ?aaaa (/ ?aaa 100))


	;;wyswietlanie wynikow w formie procentowej - do 100%
    (printout file "" crlf)

    (printout file "Poziom ciagu statku kosmicznego ustawiono na : " ?aaaa crlf)
    )




;;zaladowanie faktow do pamieci roboczej jess i uruchomienie mechanizmu wnioskowania
(reset)
(run)

(close file)

