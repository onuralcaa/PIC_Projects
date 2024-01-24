include "P16F877.INC"

    ORG 0x00

BCF STATUS, RP1
BSF STATUS, RP0
CLRF TRISC
BCF STATUS, RP0 ; Bank 0 seçildi
CLRF PORTC
CLRF SAY ; Sayac deðiþkeni sýfýrlanýyor

SAY EQU 0x20 ; Sayac deðiþkeni
N EQU 0x21
M EQU 0x22

DEVAM: 
MOVF SAY,W  
CALL SEVSEG
MOVWF PORTC
CALL GECIK   

INCF SAY,F  

MOVF SAY,W
SUBLW 0x10  
BTFSS STATUS,Z
GOTO DEVAM
CLRF SAY

GOTO DEVAM


; GECIKME FONKSIYONU (alt program)
GECIK 
    movlw .255 
    movwf N
DONGU1
    movlw .255 
    movwf M
DONGU2
    decfsz M,F        
    goto DONGU2
    decfsz N,F        
    goto DONGU1
    return


; 7 SEGMENT KOD ÇEVÝRME FONKSIYONU (alt program)
SEVSEG
        ADDWF PCL,F
        RETLW 0x3F ; 0
        RETLW 0x06 ; 1
        RETLW 0x5B ; 2
        RETLW 0x4F ; 3
        RETLW 0x66 ; 4
        RETLW 0x6D ; 5
        RETLW 0x7D ; 6
        RETLW 0x07 ; 7
        RETLW 0x7F ; 8
        RETLW 0x6F ; 9
END
