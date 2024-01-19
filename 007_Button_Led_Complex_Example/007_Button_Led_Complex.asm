;PORTB -> 0. pina baðlý led kontrolü

include "P16F877.INC"

ORG 0x00
;PORT AYARLARI
BCF STATUS, RP1 
BSF STATUS, RP0
CLRF TRISB   ;TRISB=0

MOVLW 0x06
MOVWF ADCON1

CLRF TRISA   ;TRISA=0
BSF TRISA, 0
BCF STATUS, RP0

;port sýfýrlama
CLRF PORTA
CLRF PORTB

N EQU H'0020'

AnaDongu

	dongu1
		BTFSC PORTA,RA0
	GOTO dongu1
	BSF PORTB,RB0
	CALL Gecikme

	dongu2
		BTFSC PORTA,RA0
	GOTO dongu2
	BCF PORTB,RB0
	CALL Gecikme

	goto AnaDongu
;alt program
Gecikme
	MOVLW d'125'
	MOVWF N
	SAY1 ; BEKLEME
		DECFSZ N,1
	GOTO SAY1
RETURN

END















