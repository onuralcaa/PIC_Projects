;D portune baðlý 8 adet led ile binary sayma iþlemi

	include "P16F877.INC"

	ORG 0x00

BCF STATUS, RP1
BSF STATUS, RP0
CLRF TRISB
BCF STATUS, RP0 ;bank0 seçildi
CLRF PORTB

SAY EQU 0x20
N EQU 0x21
M EQU 0x22

MOVLW H'00'
MOVWF SAY

DEVAM ;ANADÖNGÜ
	MOVF SAY,W ;SAY DEÐERÝNÝ W YE KOPYALA/ATA : W=SAY
	ANDLW B'00001111' ;SAYININ(W) 15 i GEÇMEMESÝNÝ SAÐLAYAN AND ÝÞLEMÝ

	CALL SEVSEG
	MOVWF PORTB ;PORTA GÖNDER
	INCF SAY,F ;SAY = SAY+1
	
	CALL GECÝK		

GOTO DEVAM

;GECÝKME FONK.(alt program)
GECÝK 
	movlw .255 
	movwf N
	say1
	movlw .255 
	movwf M
	say2
		decfsz M,F
	goto say2
	decfsz N,F		

	goto say1
return

SEVSEG
		ADDWF PCL,F
		;Sayýlarýn asci kodlarý
		RETLW H'3F' ;0
		RETLW H'06' ;1
		RETLW H'5B' ;2
		RETLW H'4F' ;3
		RETLW H'66' ;4
		RETLW H'6D' ;5
		RETLW H'7D' ;6
		RETLW H'07' ;7
		RETLW H'7F' ;8
		RETLW H'6F' ;9
		RETLW H'77' ;A
		RETLW H'7C' ;b
		RETLW H'39' ;C
		RETLW H'5E' ;D
		RETLW H'79' ;e
		RETLW H'71' ;F
 
END