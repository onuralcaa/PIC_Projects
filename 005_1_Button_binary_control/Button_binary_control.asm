include "P16F877.INC"
;B portuna ba�l� buton ile D portuna ba�l� 8 adet ledi binary �ekilde kontrol etmek.
org 0x00

; PORT ayarlar� ve de�i�kenler
    bcf STATUS, RP1
    bsf STATUS, RP0     ; Bank 1 se�imi
    clrf TRISD          ; PORTD'yi ��k�� olarak ayarla
    bsf TRISB, 0        ; RB0 pinini giri� olarak ayarla
    bcf STATUS, RP0     ; Bank 0'a geri d�n
    clrf PORTD          ; PORTD'yi s�f�rla

N equ 0x20
M equ 0x21

ANADONGU:
    btfss PORTB, 0     ; Buton kontrol� (RB0)
    goto ANADONGU     ; Buton bas�lmad�ysa d�ng�ye devam et
    call GECIK         ; Buton bas�l�ysa gecikme fonksiyonunu �a��r
    incf PORTD, F      ; PORTD'deki de�eri 1 artt�r

button_kontrol:
    btfsc PORTB, 0     ; Butonun b�rak�ld���n� kontrol et
    goto button_kontrol ; Buton b�rak�lana kadar bekle
    call GECIK         ; Buton b�rak�ld���nda gecikme fonksiyonunu tekrar �a��r
    goto ANADONGU     ; Ana d�ng�ye geri d�n

; GECIK alt program�
GECIK:
    movlw D'50'       ; N i�in ba�lang�� de�eri
    movwf N
SAY1:
    movlw D'50'       ; M i�in ba�lang�� de�eri
    movwf M

;TEK BEKLEME YETERL� G�R�LD�.
;SAY2:
    ;decfsz M, F        ; M'yi azalt ve s�f�r olup olmad���n� kontrol et
    ;goto SAY2    ; M s�f�r de�ilse d�ng�ye devam et
    decfsz N, F        ; N'yi azalt ve s�f�r olup olmad���n� kontrol et
    goto SAY1    ; N s�f�r de�ilse d�ng�ye devam et
    return             ; Gecikme tamamland�, fonksiyondan ��k

end                     ; Program sonu
