; porta[0] ya baðlý butona basýlýnca portb[0] ya baðlý ledin yakýlmasý

	include "P16F877.INC"
	 
	org 0x100

;PORT AYARLARI
bcf STATUS, RP1
bsf STATUS, RP0 ; 01 :BANK1 E GEÇ
clrf TRISB

;giriþ olarak kullanmayý saðlar (a portunu giriþ olarak ayarlamak için özel durum)
;diðer portlarda bu özel durum yok.
MOVLW 0x06
movwf ADCON1

clrf TRISA
bsf TRISA, 0  ;RA0 giriþ olarak ayarlandý.
bcf STATUS, RP0 ; 00 :BANK0 A GEÇ

;port sýfýrlama
clrf PORTA
clrf PORTB

AnaDongu
	bcf PORTB, RB0   ; LED OFF
	devam1
		btfsc PORTA, RA0  ;RA0=0 mý ?
	goto devam1
	bsf PORTB, RB0   ; LED ON
	
	;basýlý tutma durumu
	devam2
		btfss PORTA, RA0  ;RA0=1 mi ?
	goto devam2

goto AnaDongu
END
