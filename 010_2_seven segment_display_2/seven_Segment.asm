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

	SAY EQU 0x20 ; Birler basama��
	SAY2 EQU 0x21 ; Onlar basama��
	N EQU 0x22
	M EQU 0x23


	DEVAM ; ANAD�NG�
	
		INCF SAY,F
		MOVF SAY,W ; SAY de�erini W'ye kopyala/ata: W = SAY
		SUBLW d'10'
		BTFSS STATUS,Z
		GOTO DISP
		MOVLW d'00'
		MOVWF SAY
		INCF SAY2,F ; Onlar basama��n� art�r
		BTFSC STATUS,Z ; Birler basama�� 10'a e�itse
		GOTO RESET
		GOTO DISP	
	RESET
		MOVLW d'00'
		MOVWF SAY2
	DISP
		MOVF SAY2,W ; Onlar basama��ndaki de�eri W kaydediciye y�kle
		CALL SEVSEG
		IORWF PORTC,F ; PortC'ye birler ve onlar basama��ndaki segmentleri yaz
		MOVWF PORTB	
	
		CALL GECIK

	GOTO DEVAM

	;GECIKME FONK. (alt program)
	GECIK 
		movlw .255 
		movwf N
	say1
		movlw .255 
		movwf M

		decfsz N,F		

		goto say1
	return

	SEVSEG
		ADDWF PCL,F
		; Say�lar�n ASCII kodlar�	
		RETLW H'3F' ; 0
		RETLW H'06' ; 1
		RETLW H'5B' ; 2
		RETLW H'4F' ; 3
		RETLW H'66' ; 4
		RETLW H'6D' ; 5
		RETLW H'7D' ; 6
		RETLW H'07' ; 7
		RETLW H'7F' ; 8
		RETLW H'6F' ; 9
END