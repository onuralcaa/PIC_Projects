include "P16F877.INC"

ORG 0x00

; Banka 1'e geçiþ yap (STATUS register'ýnýn RP0 bitini set et)
BSF STATUS, RP0
; PORTC ve PORTD'yi çýkýþ olarak ayarla
CLRF TRISC
CLRF TRISD
; Banka 0'a geri dön (STATUS register'ýnýn RP0 bitini temizle)
BCF STATUS, RP0

; PORTC ve PORTD'nin içeriðini temizle
CLRF PORTC
CLRF PORTD

SAY EQU 0x20 ; Birler basamaðý
SAY2 EQU 0x21 ; Onlar basamaðý
N EQU 0x22
M EQU 0x23

MAIN_LOOP ; ANADÖNGÜ

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
    MOVWF PORTC ; Onlar basamaðýný PORTC'ye yaz

    MOVF SAY,W ; Birler basamaðýný W kaydediciye yükle
    CALL SEVSEG
    MOVWF PORTD ; Birler basamaðýný PORTD'ye yaz

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
