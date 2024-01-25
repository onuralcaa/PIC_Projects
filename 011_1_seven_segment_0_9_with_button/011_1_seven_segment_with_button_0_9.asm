include "P16F877.INC"

org 0x100           ; Ana program kodu için baþlangýç adresi


    ; PORT AYARLARI
    bcf STATUS, RP1
    bsf STATUS, RP0     ; Bank 1
    clrf TRISC          ; PORTC çýkýþ olarak ayarla
    movlw 0x06
    movwf ADCON1        ; A portunu dijital olarak ayarla
    bsf TRISA, 0        ; RA0 giriþ olarak ayarlandý.
    bcf STATUS, RP0     ; Bank 0

    SAY EQU 0x20        ; Sayac deðiþkeni
    N EQU 0x21          ; Gecikme için kullanýlacak deðiþkenler
    M EQU 0x22          ; Gecikme için kullanýlacak deðiþkenler

    clrf PORTA
    clrf PORTC          ; PORTC'yi sýfýrla (seven segment display'i sýfýrla)
    clrf SAY            ; SAY deðiþkenini sýfýrla

ANA_DONGU: 
    BTFSC PORTA, 0      ; RA0 pinini kontrol et (Buton basýlý mý?)
    CALL BUTON_BASILDI  ; Eðer butona basýldýysa alt programý çaðýr
    GOTO ANA_DONGU

BUTON_BASILDI:
    CALL GECIK          ; Buton debouncing için gecikme
    BTFSC PORTA, 0      ; Buton hala basýlý mý kontrol et
    RETURN              ; Hala basýlýysa ana döngüye dön
    INCF SAY, F         ; SAY deðiþkenini arttýr
    MOVF SAY, W         ; SAY deðiþkenini W kaydedicisine yükle
    ANDLW b'00001111'   ; Sadece düþük nibble'ý al (0-9 arasý)
    CALL SEVSEG         ; SEVSEG fonksiyonunu çaðýr
    MOVWF PORTC         ; W kaydedicisindeki deðeri PORTC'ye yükle
    MOVF SAY, W         ; SAY'ý tekrar W'ye yükle
    XORLW .10           ; W ile 10'u XOR'la ve sonucu W'ye yaz
    BTFSC STATUS, Z     ; Eðer sonuç sýfýr ise (W == 10 ise)
    CLRF SAY            ; SAY'ý sýfýrla
    RETURN

GECIK:
    movlw D'255'        ; Gecikme süresi
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
    ; Tablo burada sonlanýyor, daha fazla deðer ekleyebilirsiniz.

    end
