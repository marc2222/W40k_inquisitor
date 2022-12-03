#NoEnv
#SingleInstance,Prompt

;#Include configuration_techno.ahk


; If you feel your clicks are off by a tad bit you can adjust the
; margins here, for example winHeightOffset -40 works for some.
winHeightOffset := 0
winWidthOffset := 0

;mission coeur intrepide
	xPositionVuegenerale := 2165 
	yPositionVuegenerale := 2014

	xPositionMissionsSpeciales := 2140 
	yPositionMissionsSpeciales := 119

	xPositionAscenseur := 1230 
	yPositionMAscenseur := 1532

	xPositionCoeur := 1230 
	yPositionCoeur := 1532
	
	xPositionContinuer := 3511 
	yPositionContinuerr := 1823




; Ensure mouse coords are always fetched via screen size 
; and not relative to the active window
CoordMode Mouse, Screen
CoordMode Pixel, Screen

; --------------------------------------------------------------------------------
; LOST ARK CHAOS BOT - FARMS 1 ROOM AND LEAVES
; --------------------------------------------------------------------------------

; IN-GAME SETTINGS !! IMPORTANT
; **Screen**: Windowed Mode,
; **Resolution**: 1920x1080 (16:9)
; **HUD Size: 100%**
; I use 150% windows scaling on a 4k monitor but the above... should work regardless.


; Don't change any of these...
gameWidth := 1920
gameHeight := 1080
winWidth := 0
winHeight := 0
startTime := 0

SetWindowLocation()
InBattle := false

gameFound := false

gameName := "Warhammer: Inquisitor - Martyr"
; --------------------------------------------------------------------------------
; INITIALIZE KEYS
; --------------------------------------------------------------------------------


;=============================================================================
;===                  definition des touches du bot                        ===
;=============================================================================
F1::
	LogReset()
	Log("erwan vu qu'il corrige tout  v0.0.1 Techno")

	SetTimer, BattleLoop, -100
	return


F3::
	SetWindowLocation()

	; Output the current mouse coordinates
	MouseGetPos, MouseX, MouseY

	xpos := MouseX - winWidth
	ypos := MouseY - winHeight

	DetectedColour := GetPixelColor(xpos, ypos)
	PixelGetColor, MouseColour, %MouseX%, %MouseY%, Slow RGB

	Log("Position: " xpos ", " ypos " --- Colour: " DetectedColour "(" MouseColour ")")
	return

F5::
	WinGet, windows, list

	Loop, %windows%
	{
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
	startTime := Unix()
	FocusGame()
	if(gameFound){
		Sleep, 1000	
		ClickCenter()
		Log("game focussed")

		Sleep 1000	

		; boucle 
		Loop,
		{
			OpenCoeurIntrepide()		
			parcours()
			ValidationQuitter()
			
			OpenCoeurIntrepide()		
			parcours()
			ValidationQuitter()
			
			OpenCoeurIntrepide()		
			parcours()
			ValidationQuitter()

			;inventaire()
			vente()
			;recyclage()
		}
	} else {
		MsgBox 0,,''%gameName%''`nN'a aucune instance
	}

	return

;=============================================================================
;===                 Fonction de jeu                                       ===
;=============================================================================

InvoqueAll() {
	global
	Log("Changement d'arme")
	Click, 1877, 1335
	Sleep, 700
	;MouseMove, 1585, 1196 ,5
	;Sleep 300
	Send {a down}{a up}
	Sleep, 700
	;MouseMove, 1689, 967 ,5
	;Sleep 300
	Send {q down}{q up}
	Sleep, 700
	;MouseMove, 1890, 917 ,5
	;Sleep 300
	Send {s down}{s up}
	Sleep, 700
	;MouseMove, 2128, 995 ,5
	;Sleep 300
	Send {f down}{f up}
	Sleep, 700
	;MouseMove, 2216, 1285 ,5
	;Sleep 300
	Click, 2216, 1285, Right
	Sleep, 700
	;MouseMove, 1585, 1196 ,5
	;Sleep 300
	Send {a down}{a up}
	Sleep,500
	return
	
	
}

OpenCoeurIntrepide() {
	global
	SetWindowLocation()

	Log("Open coeur intrepide...")
	Log("Ouverture du tableau des mission")	
	Click, 2165 2014
	Sleep,200
	Log("Selection de l'onglet missions pseciales")	
	Click, 2140 119
	Sleep,200
	Log("déplacementde la souris pour scroll")	
	MouseMove 1260,1537,10
	Sleep,200
	Log("scroll 1")	
	MouseClick, WheelDown,,, 10
	Sleep,200
	Log("scroll 2")	
	MouseClick, WheelDown,,, 10
	Sleep,200
	Log("scroll 3")	
	MouseClick, WheelDown,,, 10
	Sleep,200
	Log("scroll 4")	
	MouseClick, WheelDown,,, 10
	Sleep,200
	Log("scroll 5")	
	MouseClick, WheelDown,,, 10
	Sleep,200
	Log("scroll 6")	
	MouseClick, WheelDown,,, 10
	Sleep,200
	Log("scroll 7")	
	MouseClick, WheelDown,,, 10
	Sleep,200
	Log("click sur coeur intrepide")	
	;Click 1260 1611
	Click 1260 1537
	Log("Attente du dialogue")	
	Sleep,5000
	Log("clic sur continuer")	
	Click 3511 1823
	Log("Attente lancement de partie")	
	Sleep,20000

	return
}

parcours(){
	InvoqueAll()
	PremierDeplacementHaut()
	PremierDeplacementDroite()
	montee()
	deplacementGauche()
	Sleep 2000
}

PremierDeplacementHaut(){
	Log("go to start position haut")	
	nbLoop=0
	Loop,
	{
		Click 1913, 976
		Sleep 1500
		MouseMove 0,900,10,R
		Sleep 1500
		Send {f down}{f up}
		Sleep 1000
		nbLoop += 1

	} until nbLoop > 7		
	return
}

PremierDeplacementDroite(){
	Log("go to start position Droite")	
	nbLoop=0
	Loop,
	{
		Click 2224, 1274
		Sleep 1500
		MouseMove -900,0,10,R
		Sleep 1500
		Send {f down}{f up}
		Sleep 1000
		nbLoop += 1
	} until nbLoop > 9	
	
	return
}

montee(){
	Log("début montée")
	nbLoop=0
	Loop,
	{
		Click 1913, 976
		Sleep 1500
		MouseMove, 1913, 1613,0
		Sleep 500		
		Send {f down}{f up}
		Sleep,1500
		nbLoop += 1

	} until nbLoop > 30

	Log("fin montée")
}
deplacementGauche(){
	Log("début deplacement gauche")
	nbLoop=0
	Loop,
	{
		Click 1519, 1308
		Sleep 1500
		MouseMove 900,0,10,R
		Sleep 500		
		Send {f down}{f up}
		Sleep,1500
		nbLoop += 1

	} until nbLoop > 30
	
	
	Log("fin gauche")

}
ValidationQuitter(){
	Sleep 9000	
	Click 3507, 1292
	Sleep 20000
	Send {Enter}
	
}

inventaire(){
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

vente(){
	MouseMove, 841, 619 ,5
	Sleep 100
	Click 841, 619
	Sleep 4000	
	
	MouseMove, 1203, 1065 ,5
	Sleep 100
	Click 1203, 1065
	Sleep 2000
	
	MouseMove, 1204, 1181 ,5
	Sleep 100
	Click 1204, 1181
	Sleep 2000
	
	MouseMove, 1201, 1286 ,5
	Sleep 100
	Click 1201, 1286
	Sleep 2000
	
	MouseMove, 3745, 106 ,5
	Sleep 300
	Click 3745, 106
	Sleep 2000 
	
	MouseMove, 1893, 1882 ,5
	Sleep 300
	Click 1893, 1882
	Sleep 1000 
	
	MouseMove, 1856, 1490 ,5
	Sleep 300
	Click 1856, 1490
	Sleep 1000 
}

recyclage(){
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

	; negate 10 because of game cursor 
	width  := x + winWidth
	height := y + winHeight

	PixelGetColor, DetectedColour, width, height, Slow RGB
	return DetectedColour
}

ClickCenter(){
	global
	centerX := Floor(winWidth/2)
	centerY := Floor(winHeight/2)
	Click %centerX%, %centerY%
	Log("Click center of screen : " centerX "-" centerY)
}
