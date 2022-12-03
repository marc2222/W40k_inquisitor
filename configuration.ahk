; --------------------------------------------------------------------------------
; configuration Générale
; --------------------------------------------------------------------------------

gameName := "Warhammer: Inquisitor - Martyr"
nbBoucleTotale := 50 
nbBoucleAvantVente := 0 ; 0 veut dire pas de vente
nbBoucleAvantRecyclage := 0 ; 0 veut dire pas de recyclage
classeJouee := "Technopretre"
;classeJouee := "Assassin"

resolutionLargeur := 3840
resolutionHauteur := 2160

winWidth := 0
winHeight := 0
startTime := 0
gameFound := false

; --------------------------------------------------------------------------------
; vente des objets
; --------------------------------------------------------------------------------
xSelectionVendeur := 841
ySelectionVendeur := 619


; --------------------------------------------------------------------------------
; mission coeur intrepide
; --------------------------------------------------------------------------------
;tableau des missions
xPositionVuegenerale := 2165 
yPositionVuegenerale := 2014

xPositionMissionsSpeciales := 2140 
yPositionMissionsSpeciales := 119

xPositionAscenseur := 1230 
yPositionMAscenseur := 1532

xPositionMissionCoeur := 1230 
yPositionMissionCoeur := 1537

xPositionContinuer := 3511 
yPositionContinuer := 1823

; --------------------------------------------------------------------------------
;  Deplacement vers le haut TechnoPretre
; --------------------------------------------------------------------------------
xPositionDeplacementHaut := 1913 
yPositionDeplacementHaut := 976

tempsAttenteAvantInvoqueTourelle := 1500
tempsAttenteAvantRecommencerInvoqueTourelle := 500

xPositionRelativePourInvocationTourelleHaut :=  0 
yPositionRelativePourInvocationTourelleHaut := 900

nbDeplacementHautPourPremierDeplacement := 7
nbDeplacementHautPourDeuxiemeDeplacement := 30

; --------------------------------------------------------------------------------
;  Deplacement vers la droite TechnoPretre
; --------------------------------------------------------------------------------
xPositionDeplacementDroite := 2224 
yPositionDeplacementDroite := 1274

xPositionRelativePourInvocationTourelleDroite :=  0 
yPositionRelativePourInvocationTourelleDroite := 900

nbDeplacementDroitePourPremierDeplacement := 9

; --------------------------------------------------------------------------------
;  Deplacement vers la gauche TechnoPretre
; --------------------------------------------------------------------------------
xPositionDeplacementGauche := 1519 
yPositionDeplacementGauche := 1308

xPositionRelativePourInvocationTourelleGauche :=  900 
yPositionRelativePourInvocationTourelleGauche := 0

nbDeplacementGauchePourPremierDeplacement := 30

