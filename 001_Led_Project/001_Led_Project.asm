;PORTB -> 0. pina baðlý led kontrolü
ORG 0x00
;PORT AYARLARI
BCF  h'03',6      ;RP1=0
BSF h'03',5       ;RP0=1 : 01 Bank01
CLRF h'86'        ;TRISB=0
BCF h'03',5       ;RP0=0 : 00 Bank0
CLRF h'06'        ;PORTB=0

  Devam
	;YAKMA
	BSF h'06',0
	MOVLW d'255'
	MOVWF 0x20
	SAY1 ; BEKLEME
		DECFSZ 0x20,1
	GOTO SAY1

	;SONDURME
	BCF h'06',0
	MOVLW d'255'
	MOVWF 0x20
	SAY2 ; BEKLEME
		DECFSZ 0x20,1
	GOTO SAY2

  GOTO Devam
END












