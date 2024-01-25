include "P16F877.INC"
;B portuna baðlý buton ile D portuna baðlý 8 adet ledi binary þekilde kontrol etmek.
org 0x00

; PORT ayarlarý ve deðiþkenler
    bcf STATUS, RP1
    bsf STATUS, RP0     ; Bank 1 seçimi
    clrf TRISD          ; PORTD'yi çýkýþ olarak ayarla
    bsf TRISB, 0        ; RB0 pinini giriþ olarak ayarla
    bcf STATUS, RP0     ; Bank 0'a geri dön
    clrf PORTD          ; PORTD'yi sýfýrla

N equ 0x20
M equ 0x21

ANADONGU:
    btfss PORTB, 0     ; Buton kontrolü (RB0)
    goto ANADONGU     ; Buton basýlmadýysa döngüye devam et
    call GECIK         ; Buton basýlýysa gecikme fonksiyonunu çaðýr
    incf PORTD, F      ; PORTD'deki deðeri 1 arttýr

button_kontrol:
    btfsc PORTB, 0     ; Butonun býrakýldýðýný kontrol et
    goto button_kontrol ; Buton býrakýlana kadar bekle
    call GECIK         ; Buton býrakýldýðýnda gecikme fonksiyonunu tekrar çaðýr
    goto ANADONGU     ; Ana döngüye geri dön

; GECIK alt programý
GECIK:
    movlw D'50'       ; N için baþlangýç deðeri
    movwf N
SAY1:
    movlw D'50'       ; M için baþlangýç deðeri
    movwf M

;TEK BEKLEME YETERLÝ GÖRÜLDÜ.
;SAY2:
    ;decfsz M, F        ; M'yi azalt ve sýfýr olup olmadýðýný kontrol et
    ;goto SAY2    ; M sýfýr deðilse döngüye devam et
    decfsz N, F        ; N'yi azalt ve sýfýr olup olmadýðýný kontrol et
    goto SAY1    ; N sýfýr deðilse döngüye devam et
    return             ; Gecikme tamamlandý, fonksiyondan çýk

end                     ; Program sonu
