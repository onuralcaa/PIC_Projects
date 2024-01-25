;D portune baðlý 8 adet led ile binary sayma iþlemi

	include "P16F877.INC"

	org 0x00

bcf STATUS, RP1
bsf STATUS, RP0
clrf TRISD
bcf STATUS, RP0 ;bank0 seçildi
clrf PORTD
N equ 0x20
M equ 0x21

devam;anadongu
	movlw h'00'
	movwf PORTD
	say
		call gecikme
		incfsz PORTD, F ;bir arttýr, sýfýr kontrolü yap (0 olduðunda 2 alt satýra geçer)
	goto say


GOTO devam

;GECÝKME FONK.(alt program)
gecikme 
	movlw .255 
	movwf N
	say1
	movlw .255 
	movwf M
	say2
		decfsz M,F
	goto say2
	decfsz N,F		

	goto say1
return

 
END