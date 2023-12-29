;PORTB -> 0. pina ba�l� led kontrol�

;k�t�phane 
INCLUDE "P16F877.INC"

N EQU H'0020' ;kullan�c� de�i�keni 1
M EQU H'0021' ;kullan�c� de�i�keni 2 

ORG 0x00

;PORT AYARLARI
BCF  STATUS,RP1       ;RP1=0
BSF  STATUS,RP0       ;RP0=1 : 01 Bank01
CLRF TRISB          ;TRISB=0
BCF  STATUS,RP0       ;RP0=0 : 00 Bank0
CLRF PORTB          ;PORTB=0

  Devam
	;YAKMA
	BSF PORTB,RB0
	CALL Gecikme2

	;SONDURME
	BCF PORTB,RB0
	CALL Gecikme2
  GOTO Devam


;alt program
Gecikme2
	MOVLW d'255'
	MOVWF N
	SAY1 ; BEKLEME

			;�� ��E DONGU
			MOVLW d'255'
			MOVWF M
			SAY2 ; BEKLEME
				DECFSZ M,F
			GOTO SAY2

		DECFSZ N,F
	GOTO SAY1
RETURN

END












