;D portune ba�l� 8 adet led ile binary sayma i�lemi

	include "P16F877.INC"

	org 0x00

bcf STATUS, RP1
bsf STATUS, RP0
clrf TRISD
bcf STATUS, RP0 ;bank0 se�ildi
clrf PORTD
N equ 0x20
M equ 0x21

devam;anadongu
	movlw h'00'
	movwf PORTD
	say
		call gecikme
		incfsz PORTD, F ;bir artt�r, s�f�r kontrol� yap (0 oldu�unda 2 alt sat�ra ge�er)
	goto say


GOTO devam

;GEC�KME FONK.(alt program)
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