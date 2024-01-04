;Saya� ile seven segment disp kullan�m�

	include "P16F877.INC"

	org 0x100

bcf STATUS, RP1
bsf STATUS, RP0
clrf TRISB

bcf STATUS, RP0
clrf PORTB

SAY EQU H'20'
N EQU H'21'
M EQU H'22'

MOVLW H'00'
MOVWF SAY

DEVAM ;ANAD�NG�
	MOVF SAY,W ;SAY DE�ER�N� W YE ATA : W=SAY
	ANDLW B'00001111' ;SAYININ(W) 15 � GE�MEMES�N� SA�LAYAN AND ��LEM�

	CALL SEVSEG
	MOVWF PORTB ;PORTA G�NDER
	INCF SAY,F ;SAY = SAY+1
	
	CALL GEC�K		

GOTO DEVAM

	SEVSEG
		ADDWF PCL,F
		;Say�lar�n asci kodlar�
		RETLW H'3F'
		RETLW H'06'
		RETLW H'5B'
		RETLW H'4F'
		RETLW H'66'
		RETLW H'6D'
		RETLW H'7D'
		RETLW H'07'
		RETLW H'7F'
		RETLW H'6F'
		RETLW H'77'
		RETLW H'7C'
		RETLW H'39'
		RETLW H'5E'
		RETLW H'79'
		RETLW H'71'
		
GEC�K
	movlw d'255'
	movwf N
	SAY1
		MOVLW d'255'
		MOVWF M
		SAY2
			DECFSZ M,F
		GOTO SAY2
		DECFSZ N,F
	GOTO SAY1	

RETURN
END