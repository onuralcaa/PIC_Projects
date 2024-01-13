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

	SAY EQU 0x20 ; Birler basamaðý
	SAY2 EQU 0x21 ; Onlar basamaðý
	N EQU 0x22
	M EQU 0x23


	DEVAM ; ANADÖNGÜ
	
		INCF SAY,F
		MOVF SAY,W ; SAY deðerini W'ye kopyala/ata: W = SAY
		SUBLW d'10'
		BTFSS STATUS,Z
		GOTO DISP
		MOVLW d'00'
		MOVWF SAY
		INCF SAY2,F ; Onlar basamaðýný artýr
		BTFSC STATUS,Z ; Birler basamaðý 10'a eþitse
		GOTO RESET
		GOTO DISP	
	RESET
		MOVLW d'00'
		MOVWF SAY2
	DISP
		MOVF SAY2,W ; Onlar basamaðýndaki deðeri W kaydediciye yükle
		CALL SEVSEG
		IORWF PORTC,F ; PortC'ye birler ve onlar basamaðýndaki segmentleri yaz
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
		; Sayýlarýn ASCII kodlarý	
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