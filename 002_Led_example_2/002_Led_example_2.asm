;PORTB -> 0. pina baðlý led kontrolü

;define tanýmlamalarý
STATUS EQU H'0003'
PORTB EQU H'0006'
TRISB EQU H'0086'
N EQU H'0020'


ORG 0x00

;PORT AYARLARI
BCF  STATUS,6       ;RP1=0
BSF  STATUS,5       ;RP0=1 : 01 Bank01
CLRF TRISB          ;TRISB=0
BCF  STATUS,5       ;RP0=0 : 00 Bank0
CLRF PORTB          ;PORTB=0

  Devam
	;YAKMA
	BSF PORTB,0
	MOVLW d'255'
	MOVWF N
	SAY1 ; BEKLEME
		DECFSZ N,1
	GOTO SAY1

	;SONDURME
	BCF PORTB,0
	MOVLW d'255'
	MOVWF N
	SAY2 ; BEKLEME
		DECFSZ N,1
	GOTO SAY2
  GOTO Devam
END












