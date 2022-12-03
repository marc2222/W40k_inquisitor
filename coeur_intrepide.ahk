#NoEnv
#SingleInstance,Prompt

#Include configuration.ahk

CoordMode Mouse, Screen
CoordMode Pixel, Screen

SetWindowLocation()

;=============================================================================
;===                  definition des touches du bot                        ===
;=============================================================================
;F1 pour Demmarer le bot
F1::
	LogReset()
	Log("Marc V1.0 technopretre")
	SetTimer, BattleLoop, -100
	return

;F3 pour avoir la position de la souris
F3::
	SetWindowLocation()

	; Output the current mouse coordinates
	MouseGetPos, MouseX, MouseY

	xpos2 := MouseX - winWidth
	ypos2 := MouseY - winHeight

	DetectedColour := GetPixelColor(MouseX, MouseY)
	PixelGetColor, MouseColour, %MouseX%, %MouseY%, Slow RGB

	Log("Position: " MouseX ", " MouseY " --- Colour: " DetectedColour "(" MouseColour ")")
	return

;F5 pour avoir la liste des executable et trouver le nom du jeu
F5::
	WinGet, windows, list

	Loop, %windows%{
		id := windows%A_Index%
		WinGet, process, ProcessName, ahk_id %id%
		WinGetTitle, title, ahk_id %id%
		FileAppend, %process% %title% %id%`n, *
		MsgBox process :  %process% `n Titre :  %title% `n
	}

	if WinExist("Warhammer: Inquisitor - Martyr"){
			MsgBox trouvé
		}
	else{
		MsgBox raté
	}
	ExitApp

;ESC pour quitter le BOT
Escape::
	Log("Bot duration: " Duration())
	MsgBox Stopped! Duration: %duration%
	ExitApp
	Return

;=============================================================================
;===                 Boucle Principale                                     ===
;=============================================================================


BattleLoop:
	global gameFound
	
	nbBoucleCourantAvantVente := 0
	nbBoucleCourantAvantRecyclage := 0

	startTime := Unix()
	FocusGame()

	if(Not gameFound){
		MsgBox 0,,''%gameName%''`nN'a aucune instance
		ExitApp
	}
	Sleep, 500	
	clickPersonnage()
	Log("game focussed")
	Sleep 500
	
	Loop, %nbBoucleTotale%{
		OpenCoeurIntrepide()

		if (classeJouee = "Technopretre")
			parcours_technopretre()
		else if (classeJouee = "Assassin")
			parcours_assassin()		

		quitterGameCoeurIntrepide()
		
		nbBoucleCourantAvantVente += 1
		nbBoucleCourantAvantRecyclage += 1

		if (nbBoucleCourantAvantVente = nbBoucleAvantVente ){
				venteBleusVertsViolets()
				nbBoucleCourantAvantVente :=0
		}
		if (nbBoucleCourantAvantRecyclage = nbBoucleAvantRecyclage ){
			RechercheCoffrePourOuverture(2)
			venteBleusVertsViolets()
			if (actionDeRecyclage)
				recyclage()
			nbBoucleCourantAvantRecyclage :=0
		}
	}
	Log("termine")
	return

;=============================================================================
;===                 Fonction de jeu pour tous les perso                   ===
;=============================================================================
OpenCoeurIntrepide() {
	global
	SetWindowLocation()

	Log("Open coeur intrepide...")
	Log("Ouverture du tableau des mission")	
	Click, %xPositionVuegenerale% %yPositionVuegenerale%
	Sleep,200
	Log("Selection de l'onglet missions pseciales")	
	Click, %xPositionMissionsSpeciales% %yPositionMissionsSpeciales%
	Sleep,200
	Log("déplacementde la souris pour scroll")	
	MouseMove %xPositionMissionCoeur% , %yPositionMissionCoeur%,10
	Sleep,200
	Loop, 7 {
		Log("scroll ")	
		MouseClick, WheelDown,,, 10
		Sleep,200
	}
	Log("click sur coeur intrepide")	
	Click %xPositionMissionCoeur% %yPositionMissionCoeur%
	Log("Attente du dialogue")	
	Sleep,5000
	Log("clic sur continuer")	
	Click %xPositionContinuer% %yPositionContinuer%
	Log("Attente lancement de partie")	
	Sleep,20000
	return
}

quitterGameCoeurIntrepide(){
	global
	Sleep 11000	
	Click 3507, 1292
	Sleep 20000
	Send {Enter}	
}

RechercheCoffrePourOuverture(nbOngletAOuvrir){
	global
	Click, %xSelectionPersonnage%, %ySelectionPersonnage% 	
	Sleep 1000
	
	Click, %xSelectionOngletInventaire%, %ySelectionOngletInventaire%
	Sleep 1000

	xOnglet := xPositionDuPremierOnglet
	yOnglet := yPositionDuPremierOnglet
	loop,%nbOngletAOuvrir%{
		xPositionObjetCourant := xPositionDuPremierObjet
		yPositionObjetCourant := yPositionDuPremierObjet
		Loop,8 {
			Loop, 8{
				ouvertureDuCoffre(xPositionObjetCourant,yPositionObjetCourant)
				Sleep, 200
				xPositionObjetCourant -= xDeltaObjet
			}
			xPositionObjetCourant := xPositionDuPremierObjet
			yPositionObjetCourant -= yDeltaObjet
		}
		xOnglet += xDeltaOnglet
		Click %xOnglet%,%yOnglet%
		Sleep, 1000
	}
	
	Click %xSelectionVenteCroix%, %ySelectionVenteCroix%
	Sleep 2000 		
	return	

}

ouvertureDuCoffre(x,y){
	global
	Log("selection du coffre " x " " y)
	Click, %x%,%y% 
	Sleep 200
	;verification est ce bien un coffre	
	xPos3 := xPositionObjectSelectionne
	yPos3 := yPositionObjectSelectionne
	Log("point milieu" xPos3  ", "yPos3)
	MouseMove, xPos3, yPos3,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos3, yPos3, Slow RGB	
	Log("Position: " xPos3 ", " yPos3 " --- Colour: " DetectedColour " recherche : 0x61553D" )
	if (DetectedColour != 0x61553D){
		Log("mauvaise couleur")
		return
	}
	
	
	xPos3 := xPositionObjectSelectionne-xDelta
	yPos3 := yPositionObjectSelectionne
	Log("point gauche" xPos3  ", "yPos3)
	MouseMove, xPos3, yPos3,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos3, xPos3, Slow RGB	
	Log("Position: " xPos3 ", " yPos3 " --- Colour: " DetectedColour " recherche : 0x070B09" )
	if (DetectedColour != 0x070B09){
		Log("mauvaise couleur")
		return
	}

	
	xPos3  := xPositionObjectSelectionne+xDelta
	yPos3 := yPositionObjectSelectionne	
	Log("point droit" xPos3  ", "yPos3)
	MouseMove, xPos3, yPos3,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos3, xPos3, Slow RGB	
	Log("Position: " xPos3 ", " yPos3 " --- Colour: " DetectedColour " recherche : 0x040807" )
	if (DetectedColour != 0x040807){
		Log("mauvaise couleur")
		return
	}
		
	xPos3  := xPositionObjectSelectionne
	yPos3 := yPositionObjectSelectionne-yDelta	
	Log("point haut" xPos3  ", "yPos3)
	MouseMove, xPos3, yPos3,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos3, xPos3, Slow RGB
	Log("Position: " xPos3 ", " yPos3 " --- Colour: " DetectedColour " recherche : 0x090E0B" )
	if (DetectedColour != 0x090E0B){
		Log("mauvaise couleur")
		return
	}

	Log("point bas")
	xPos3  := xPositionObjectSelectionne
	yPos3 := yPositionObjectSelectionne+yDelta	
	MouseMove, xPos3, yPos3,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos3, xPos3, Slow RGB
	Log("Position: " xPos3 ", " yPos3 " --- Colour: " DetectedColour " recherche : 0x090E0B" )
	if (DetectedColour != 0x090E0B){
		Log("mauvaise couleur")
		return
	}

	Log("Ouverture de coffre " x " " y)	
	Click %x%,%y%,Right
	Sleep 3000
	Send {Enter}
	Sleep 1000	
}

venteBleusVertsViolets(){
	global
	Click %xSelectionVendeur%, %ySelectionVendeur%
	Sleep 4000	

	Click %xSelectionVenteBleu%, %ySelectionVenteBleu%
	Sleep 2000
	
	Click %xSelectionVenteVert%, %ySelectionVenteVert%
	Sleep 2000
	
	Click %xSelectionVenteViolet%, %ySelectionVenteViolet%
	Sleep 2000
	
	Click %xSelectionVenteCroix%, %ySelectionVenteCroix%
	Sleep 2000 

	Click %xRetourPositionCentraleApresVente%, %yRetourPositionCentraleApresVente%
	Sleep 4000 
}

recyclage(){
	global
	Click %xSelectionRecycleur%, %ySelectionRecycleur%
	Sleep 3000	

	Click %xSelectionRecyclageMarron%, %ySelectionRecyclageMarron%
	Sleep 500 
	
	Send {Enter}
	Sleep 3000
	
	Click %xSelectionVenteCroix%, %ySelectionVenteCroix%
	Sleep 1000 

	Click %xRetourPositionCentraleApresRecycleur%, %yRetourPositionCentraleApresRecycleur%
	Sleep 3000
}

;=============================================================================
;===                 Fonction de jeu pour Technopretre                     ===
;=============================================================================
parcours_technopretre(){
	global
	InvoqueAll_technopretre()
	Log("Deplacement Haut")
	DeplacementEtInvoque_technopretre(nbDeplacementHautPourPremierDeplacement,xPositionDeplacementHaut,yPositionDeplacementHaut,tempsAttenteAvantInvoqueTourelle,xPositionRelativePourInvocationTourelleHaut,yPositionRelativePourInvocationTourelleHaut,tempsAttenteAvantRecommencerInvoqueTourelle)
	Log("Deplacement Droite")
	DeplacementEtInvoque_technopretre(nbDeplacementDroitePourPremierDeplacement,xPositionDeplacementDroite, yPositionDeplacementDroite,tempsAttenteAvantInvoqueTourelle,xPositionRelativePourInvocationTourelleDroite,yPositionRelativePourInvocationTourelleDroite,tempsAttenteAvantRecommencerInvoqueTourelle)
	Log("Deplacement Haut")
	DeplacementEtInvoque_technopretre(nbDeplacementHautPourDeuxiemeDeplacement,xPositionDeplacementHaut,yPositionDeplacementHaut,tempsAttenteAvantInvoqueTourelle,xPositionRelativePourInvocationTourelleHaut,yPositionRelativePourInvocationTourelleHaut,tempsAttenteAvantRecommencerInvoqueTourelle)
	Log("Deplacement Gauche")
	DeplacementEtInvoque_technopretre(nbDeplacementGauchePourPremierDeplacement,xPositionDeplacementGauche, yPositionDeplacementGauche,tempsAttenteAvantInvoqueTourelle,xPositionRelativePourInvocationTourelleGauche,yPositionRelativePourInvocationTourelleGauche,tempsAttenteAvantRecommencerInvoqueTourelle)
}

InvoqueAll_technopretre() {
	global
	Log("Changement d'arme")
	;positionnement de la souris
	clickPersonnage()
	Sleep, 700

	;changmeent d'arme
	Send {a down}{a up}
	Sleep, 700

	;invocation de la besiole du q
	Send {q down}{q up}
	Sleep, 700

	;invocation de la besiole du s
	Send {s down}{s up}
	Sleep, 700

	;invocation de la besiole du f
	Send {f down}{f up}
	Sleep, 700

	;invocation de la besiole du click droit
	centerX := Floor(winWidth/2)
	centerY := Floor(winHeight/2)
	Click %centerX%, %centerY%, Right

	Sleep, 700

	;retour a l'arme principale
	Send {a down}{a up}
	Sleep,500
	return
}

DeplacementEtInvoque_technopretre(nbBoucle,xDep,yDep,t1,xRel,yrel,t2){
	global
	Log("deplacement:" nbBoucle "()" xDep "()" yDep "()" t1 "()" xRel "()"  yrel "()" t2)	
	Loop, %nbBoucle%	{
		Click %xDep%, %yDep%
		Sleep %t1%
		MouseMove %xRel%,%yrel%,10,R
		Sleep %t1%
		Send {f down}{f up}
		Sleep %t2%
	}	
}

;=============================================================================
;===                 Fonction de jeu pour Assassin                        ===
;=============================================================================
parcours_assassin(){
}

;=============================================================================
;===                        Fonction de Log/diverses                       ===
;=============================================================================
Log(text) {
	global

	FormatTime, CurrentDateTime,, dd-MM-yy HH:mm:ss
	FileAppend, [%CurrentDateTime%] %text% `n, ./log.txt
}

LogReset() {
	FileDelete, ./log.txt
}

Unix() {
	unix -= 19700101000000, S
	return unix
}

Duration() {
	global

	; Calculate bot duration
	finishTime := Unix()
	duration := finishTime - startTime
	duration := FormatDuration(duration)
}

FormatDuration(s) {
	w = day.hour.minute.second

	loop parse, w, .
		s -= (t := s // (x := 60 ** (e := 4 - a_index) - 129600 * (e = 3))) * x
		, t ? m .= t . " " . a_loopfield . chr(115 * (t != 1)) . chr(32 * !!e)

	return m ? m : "0 seconds"
}

FocusGame() {
	global gameName
	Log("recherche de la fenetre du jeu")
	global gameFound := WinExist(gameName)
	if (gameFound){
    	WinActivate ; Use the window found by WinExist.
		SetWindowLocation()
		Log("Windows activé, Id = " gameFound)
	}
	else{
		Log("Jeu non trouvé")
	}
	return 
}

SetWindowLocation() {
	global
	WinGetPos,,, winWidth, winHeight
}

GetPixelColor(x, y) {
	global
	SetWindowLocation()	

	PixelGetColor, DetectedColour, x, y, Slow RGB
	return DetectedColour
}

clickPersonnage(){
	Click 1911, 1303
}
