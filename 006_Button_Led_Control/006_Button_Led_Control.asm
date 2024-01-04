; porta[0] ya ba�l� butona bas�l�nca portb[0] ya ba�l� ledin yak�lmas�

	include "P16F877.INC"
	 
	org 0x100

;PORT AYARLARI
bcf STATUS, RP1
bsf STATUS, RP0 ; 01 :BANK1 E GE�
clrf TRISB

;giri� olarak kullanmay� sa�lar (a portunu giri� olarak ayarlamak i�in �zel durum)
;di�er portlarda bu �zel durum yok.
MOVLW 0x06
movwf ADCON1

clrf TRISA
bsf TRISA, 0  ;RA0 giri� olarak ayarland�.
bcf STATUS, RP0 ; 00 :BANK0 A GE�

;port s�f�rlama
clrf PORTA
clrf PORTB

AnaDongu
	bcf PORTB, RB0   ; LED OFF
	devam1
		btfsc PORTA, RA0  ;RA0=0 m� ?
	goto devam1
	bsf PORTB, RB0   ; LED ON
	
	;bas�l� tutma durumu
	devam2
		btfss PORTA, RA0  ;RA0=1 mi ?
	goto devam2

goto AnaDongu
END
