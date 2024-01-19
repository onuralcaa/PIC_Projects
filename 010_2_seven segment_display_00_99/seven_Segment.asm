include "P16F877.INC"

ORG 0x00

; Banka 1'e ge�i� yap (STATUS register'�n�n RP0 bitini set et)
BSF STATUS, RP0
; PORTC ve PORTD'yi ��k�� olarak ayarla
CLRF TRISC
CLRF TRISD
; Banka 0'a geri d�n (STATUS register'�n�n RP0 bitini temizle)
BCF STATUS, RP0

; PORTC ve PORTD'nin i�eri�ini temizle
CLRF PORTC
CLRF PORTD

SAY EQU 0x20 ; Birler basama��
SAY2 EQU 0x21 ; Onlar basama��
N EQU 0x22
M EQU 0x23

MAIN_LOOP ; ANAD�NG�

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
    MOVWF PORTC ; Onlar basama��n� PORTC'ye yaz

    MOVF SAY,W ; Birler basama��n� W kaydediciye y�kle
    CALL SEVSEG
    MOVWF PORTD ; Birler basama��n� PORTD'ye yaz

    CALL GECIK

GOTO MAIN_LOOP

;GECIKME FONK. (alt program)
GECIK 
    movlw .255 
    movwf N
DELAY_LOOP1
    movlw .255 
    movwf M
DELAY_LOOP2
    decfsz M,F    
    goto DELAY_LOOP2
    decfsz N,F        
    goto DELAY_LOOP1
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
