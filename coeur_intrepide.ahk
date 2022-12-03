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
	
	venteBleusVertsViolets()
	Return


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
			RechercheCoffrePourOuverture()
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


RechercheCoffrePourOuverture(){
	global
;on commence par le coin en bas a droite
	
	Sleep 1000
	MouseMove, 1653, 2011,5
	Sleep 100
	Click, 1653, 2011 
	
	Sleep 1000
	MouseMove, 1457, 118,5
	Sleep 100
	Click, 1457, 118
	Sleep 300
	
	Log("Ouverture de la ligne 8")
	ouvertureDuCoffre(1067,1786)
	Sleep 200
	ouvertureDuCoffre(948,1786)
	Sleep 200
	ouvertureDuCoffre(835,1786)
	Sleep 200
	ouvertureDuCoffre(712,1786)
	Sleep 200
	ouvertureDuCoffre(588,1786)
	Sleep 200
	ouvertureDuCoffre(471,1786)
	Sleep 200
	ouvertureDuCoffre(348,1786)
	Sleep 200
	ouvertureDuCoffre(229,1786)
	Sleep 200

	Log("Ouverture de la ligne 7")
	ouvertureDuCoffre(1067,1665)
	Sleep 200
	ouvertureDuCoffre(948,1665)
	Sleep 200
	ouvertureDuCoffre(835,1665)
	Sleep 200
	ouvertureDuCoffre(712,1665)
	Sleep 200
	ouvertureDuCoffre(588,1665)
	Sleep 200
	ouvertureDuCoffre(471,1665)
	Sleep 200
	ouvertureDuCoffre(348,1665)
	Sleep 200
	ouvertureDuCoffre(229,1665)
	Sleep 200

	Log("Ouverture de la ligne 6")
	ouvertureDuCoffre(1067,1545)
	Sleep 200
	ouvertureDuCoffre(948,1545)
	Sleep 200
	ouvertureDuCoffre(835,1545)
	Sleep 200
	ouvertureDuCoffre(712,1545)
	Sleep 200
	ouvertureDuCoffre(588,1545)
	Sleep 200
	ouvertureDuCoffre(471,1545)
	Sleep 200
	ouvertureDuCoffre(348,1545)
	Sleep 200
	ouvertureDuCoffre(229,1545)
	Sleep 200

	Log("Ouverture de la ligne 5")
	ouvertureDuCoffre(1067,1423)
	Sleep 200
	ouvertureDuCoffre(948,1423)
	Sleep 200
	ouvertureDuCoffre(835,1423)
	Sleep 200
	ouvertureDuCoffre(712,1423)
	Sleep 200
	ouvertureDuCoffre(588,1423)
	Sleep 200
	ouvertureDuCoffre(471,1423)
	Sleep 200
	ouvertureDuCoffre(348,1423)
	Sleep 200
	ouvertureDuCoffre(229,1423)
	Sleep 200

	Log("Ouverture de la ligne 4")
	ouvertureDuCoffre(1067,1312)
	Sleep 200
	ouvertureDuCoffre(948,1312)
	Sleep 200
	ouvertureDuCoffre(835,1312)
	Sleep 200
	ouvertureDuCoffre(712,1312)
	Sleep 200
	ouvertureDuCoffre(588,1312)
	Sleep 200
	ouvertureDuCoffre(471,1312)
	Sleep 200
	ouvertureDuCoffre(348,1312)
	Sleep 200
	ouvertureDuCoffre(229,1312)
	Sleep 200

	Log("Ouverture de la ligne 3")
	ouvertureDuCoffre(1067,1190)
	Sleep 200
	ouvertureDuCoffre(948,1190)
	Sleep 200
	ouvertureDuCoffre(835,1190)
	Sleep 200
	ouvertureDuCoffre(712,1190)
	Sleep 200
	ouvertureDuCoffre(588,1190)
	Sleep 200
	ouvertureDuCoffre(471,1190)
	Sleep 200
	ouvertureDuCoffre(348,1190)
	Sleep 200
	ouvertureDuCoffre(229,1190)
	Sleep 200

	Log("Ouverture de la ligne 2")
	ouvertureDuCoffre(1067,1075)
	Sleep 200
	ouvertureDuCoffre(948,1075)
	Sleep 200
	ouvertureDuCoffre(835,1075)
	Sleep 200
	ouvertureDuCoffre(712,1075)
	Sleep 200
	ouvertureDuCoffre(588,1075)
	Sleep 200
	ouvertureDuCoffre(471,1075)
	Sleep 200
	ouvertureDuCoffre(348,1075)
	Sleep 200
	ouvertureDuCoffre(229,1075)
	Sleep 200

	Log("Ouverture de la ligne 1")
	ouvertureDuCoffre(1067,956)
	Sleep 200
	ouvertureDuCoffre(948,956)
	Sleep 200
	ouvertureDuCoffre(835,956)
	Sleep 200
	ouvertureDuCoffre(712,956)
	Sleep 200
	ouvertureDuCoffre(588,956)
	Sleep 200
	ouvertureDuCoffre(471,956)
	Sleep 200
	ouvertureDuCoffre(348,956)
	Sleep 200
	ouvertureDuCoffre(229,956)
	Sleep 200
	
	MouseMove, 3745, 106 ,5
	Sleep 300
	Click 3745, 106
	Sleep 2000 	
	
	
	
	return	

}

ouvertureDuCoffre(x,y){
	global
	Log("selection du coffre " x " " y)
	MouseMove, x, y,5
	Sleep 100
	Click, x,y 
	Sleep 100
	SetWindowLocation()
	;verification est ce bien un coffre
	
	Log("point milieu")
	xPos := 1278
	ypos := 381
	MouseMove, xPos, ypos,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos, ypos, Slow RGB	
	Log("Position: " xPos ", " yPos " --- Colour: " DetectedColour " recherche : 0x61553D" )
	if (DetectedColour != 0x61553D){
		Log ("mauvaise couleur")
		return
	}
	
	Log("point gauche")
	xPos := 1278-25
	ypos := 381	
	MouseMove, xPos, ypos,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos, ypos, Slow RGB	
	Log("Position: " xPos ", " yPos " --- Colour: " DetectedColour " recherche : 0x6D5940" )
	if (DetectedColour != 0x6D5940){
		Log ("mauvaise couleur")
		return
	}
	Log("point droit")
	xPos := 1278+25
	ypos := 381	
	MouseMove, xPos, ypos,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos, ypos, Slow RGB	
	Log("Position: " xPos ", " yPos " --- Colour: " DetectedColour " recherche : 0x433428" )
	if (DetectedColour != 0x433428){
		Log ("mauvaise couleur")
		return
	}
		
	Log("point haut")
	xPos := 1278
	ypos := 381-40	
	MouseMove, xPos, ypos,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos, ypos, Slow RGB	
	Log("Position: " xPos ", " yPos " --- Colour: " DetectedColour " recherche : 0x503F31" )
	if (DetectedColour != 0x503F31){
		Log ("mauvaise couleur")
		return
	}

	Log("point bas")
	xPos := 1278
	ypos := 381+40	
	MouseMove, xPos, ypos,5
	Sleep 100
	PixelGetColor, DetectedColour, xPos, ypos, Slow RGB	
	Log("Position: " xPos ", " yPos " --- Colour: " DetectedColour " recherche : 0x0C0300" )
	if (DetectedColour != 0x0C0300){
		Log ("mauvaise couleur")
		return
	}

	Log ("Ouverture de coffre " x " " y)
	MouseMove, x, y,5
	Sleep 100
	Click Right
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
	MouseMove, 1832, 1680 ,5
	Sleep 300
	Click 1832, 1701
	Sleep 1000 
	
	MouseMove, 1198, 826 ,5
	Sleep 300
	Click 1198, 826
	Sleep 1000 
	
	Send {Enter}
	Sleep 3000
	
	MouseMove, 3745, 106 ,5
	Sleep 300
	Click 3745, 106
	Sleep 2000 
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
