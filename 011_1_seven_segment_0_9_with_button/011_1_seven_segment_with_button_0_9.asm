include "P16F877.INC"

org 0x100           ; Ana program kodu i�in ba�lang�� adresi


    ; PORT AYARLARI
    bcf STATUS, RP1
    bsf STATUS, RP0     ; Bank 1
    clrf TRISC          ; PORTC ��k�� olarak ayarla
    movlw 0x06
    movwf ADCON1        ; A portunu dijital olarak ayarla
    bsf TRISA, 0        ; RA0 giri� olarak ayarland�.
    bcf STATUS, RP0     ; Bank 0

    SAY EQU 0x20        ; Sayac de�i�keni
    N EQU 0x21          ; Gecikme i�in kullan�lacak de�i�kenler
    M EQU 0x22          ; Gecikme i�in kullan�lacak de�i�kenler

    clrf PORTA
    clrf PORTC          ; PORTC'yi s�f�rla (seven segment display'i s�f�rla)
    clrf SAY            ; SAY de�i�kenini s�f�rla

ANA_DONGU: 
    BTFSC PORTA, 0      ; RA0 pinini kontrol et (Buton bas�l� m�?)
    CALL BUTON_BASILDI  ; E�er butona bas�ld�ysa alt program� �a��r
    GOTO ANA_DONGU

BUTON_BASILDI:
    CALL GECIK          ; Buton debouncing i�in gecikme
    BTFSC PORTA, 0      ; Buton hala bas�l� m� kontrol et
    RETURN              ; Hala bas�l�ysa ana d�ng�ye d�n
    INCF SAY, F         ; SAY de�i�kenini artt�r
    MOVF SAY, W         ; SAY de�i�kenini W kaydedicisine y�kle
    ANDLW b'00001111'   ; Sadece d���k nibble'� al (0-9 aras�)
    CALL SEVSEG         ; SEVSEG fonksiyonunu �a��r
    MOVWF PORTC         ; W kaydedicisindeki de�eri PORTC'ye y�kle
    MOVF SAY, W         ; SAY'� tekrar W'ye y�kle
    XORLW .10           ; W ile 10'u XOR'la ve sonucu W'ye yaz
    BTFSC STATUS, Z     ; E�er sonu� s�f�r ise (W == 10 ise)
    CLRF SAY            ; SAY'� s�f�rla
    RETURN

GECIK:
    movlw D'255'        ; Gecikme s�resi
    movwf N
DONGU_N:
    movlw D'255'
    movwf M
DONGU_M:
    decfsz M, F        
    goto DONGU_M
    decfsz N, F        
    goto DONGU_N
    return

SEVSEG:
    addwf PCL, F        ; PCL'ye W kaydedicisini ekle (tabloya atla)
RET_TABLO:
    retlw b'00111111'   ; 0
    retlw b'00000110'   ; 1
    retlw b'01011011'   ; 2
    retlw b'01001111'   ; 3
    retlw b'01100110'   ; 4
    retlw b'01101101'   ; 5
    retlw b'01111101'   ; 6
    retlw b'00000111'   ; 7
    retlw b'01111111'   ; 8
    retlw b'01101111'   ; 9
    ; Tablo burada sonlan�yor, daha fazla de�er ekleyebilirsiniz.

    end
