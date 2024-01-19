;B ve C portune ba�l� birer seven segment disp ile 0-99 aras� say�c�

	include "P16F877.INC"

	ORG 0x00

BCF STATUS, RP1
BSF STATUS, RP0
CLRF TRISC
BCF STATUS, RP0 ;bank0 se�ildi
CLRF PORTC

BCF STATUS, RP1
BSF STATUS, RP0
CLRF TRISB
BCF STATUS, RP0 ;bank0 se�ildi
CLRF PORTB

SAY EQU 0x20 ;Birler basama��
SAY2 EQU 0x21 ;Onlar basama
N EQU 0x22
M EQU 0x23


DEVAM ;ANAD�NG�
	
	INCF SAY,F
	MOVF SAY,W ;SAY DE�ER�N� W YE KOPYALA/ATA : W=SAY
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
	
	CALL GEC�K

GOTO DEVAM

;GEC�KME FONK.(alt program)
GEC�K 
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
		;Say�lar�n asci kodlar�	
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