;B ve C portune baðlý birer seven segment disp ile 0-99 arasý sayýcý

	include "P16F877.INC"

	ORG 0x00

BCF STATUS, RP1
BSF STATUS, RP0
CLRF TRISC
BCF STATUS, RP0 ;bank0 seçildi
CLRF PORTC

BCF STATUS, RP1
BSF STATUS, RP0
CLRF TRISB
BCF STATUS, RP0 ;bank0 seçildi
CLRF PORTB

SAY EQU 0x20 ;Birler basamaðý
SAY2 EQU 0x21 ;Onlar basama
N EQU 0x22
M EQU 0x23


DEVAM ;ANADÖNGÜ
	
	INCF SAY,F
	MOVF SAY,W ;SAY DEÐERÝNÝ W YE KOPYALA/ATA : W=SAY
	SUBLW d'10'
	BTFSS STATUS,Z
	GOTO DISP
	MOVLW h'00'	
	MOVWF SAY
	GOTO DISP
	GOTO DEVAM
		
 
	DISP
	CALL SEVSEG
	MOVWF PORTB	
	
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
		RETLW H'6F' ;9
		RETLW H'7F' ;8
		RETLW H'07' ;7
		RETLW H'7D' ;6
		RETLW H'6D' ;5
		RETLW H'66' ;4
		RETLW H'4F' ;3
		RETLW H'5B' ;2
		RETLW H'06' ;1
		RETLW H'3F' ;0
END