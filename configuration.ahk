; --------------------------------------------------------------------------------
; configuration Générale
; --------------------------------------------------------------------------------

gameName := "Warhammer: Inquisitor - Martyr"
nbBoucleTotale := 50 
nbBoucleAvantVente := 3 ; 0 veut dire pas de vente
nbBoucleAvantRecyclage := 0 ; 0 veut dire pas de recyclage
actionDeRecyclage := False ;True False
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

xSelectionVenteBleu := 1203
ySelectionVenteBleu := 1065
		
xSelectionVenteVert := 1203
ySelectionVenteVert := 1181

xSelectionVenteViolet := 1203
ySelectionVenteViolet := 1286

xSelectionVenteCroix := 3745
ySelectionVenteCroix := 106

xRetourPositionCentraleApresVente := 3109
yRetourPositionCentraleApresVente := 2005

; --------------------------------------------------------------------------------
; ouverture des coffres
; --------------------------------------------------------------------------------
xSelectionPersonnage := 1653
ySelectionPersonnage := 2011

xSelectionOngletInventaire := 1457
ySelectionOngletInventaire := 118

xPositionObjectSelectionne := 1278
yPositionObjectSelectionne := 381
xDelta := 25
yDelta := 40

xPositionDuPremierOnglet := 233
yPositionDuPremierOnglet := 838
xDeltaOnglet := 100

xPositionDuPremierObjet := 1067
yPositionDuPremierObjet := 1786
xDeltaObjet := 120
yDeltaObjet := 120


; --------------------------------------------------------------------------------
; Recyclage
; --------------------------------------------------------------------------------
xSelectionRecycleur := 420
ySelectionRecycleur := 1835

xSelectionRecyclageMarron := 1206
ySelectionRecyclageMarron := 827

xRetourPositionCentraleApresRecycleur := 2600
yRetourPositionCentraleApresRecycleur := 1043

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

