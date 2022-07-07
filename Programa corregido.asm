	list p=16f84
	include p16f84a.inc
	__config _XT_OSC & _WDT_OFF & _PWRTE_ON

	errorlevel -302			; Para omitir los mensajes por selección de bancos.

	CBLOCK 0x0c
	R_ContA						; Contadores para los retardos.
	R_ContB
	R_ContC
	ENDC

	org		0x00			; Vector de Reset

Inicio
	bsf		STATUS,RP0		; Seleccionar el banco 1	
	movlw	b'10000'		; Configuro puerto A como salida
	movwf	TRISA		
	movlw	b'00001111'		; Parte alta del Puerto B como salidas y parte baja como entradas.
	movwf	TRISB
	bcf		STATUS,RP0		; Seleccionar banco 0
	clrf 	PORTA			; Limpio puerto A
	clrf	PORTB			; Limpiar Puerto B

Programa
	btfsc	PORTB,0			; Verificar Pulsador en RB0 (Salta si es 0)
	goto	Check_1			; Si no es 0 salta a Check_1 para comprobar el siguiente pulsador.
	call	Antirrebote		; Ir a rutina antirrebote
	call	Funcion1			; Ir a rutina de encendido de LED's
Check_1
	btfsc	PORTB,1			; Igual a lo comentado arriba para los siguientes pulsadores.
	goto	Check_2
	call	Antirrebote
	call	Funcion2
Check_2
	btfsc	PORTB,2
	goto	Check_3
	call	Antirrebote
	call	Funcion3
Check_3
	btfsc	PORTB,3
	goto	Programa
	call	Antirrebote
	call	Funcion4
	call	Antirrebote

	goto	Programa

Funcion1
	movlw	b'11110000'		; Poner en 1 los bits 4,5,6 y 7 del puerto B
	movwf	PORTB
	movlw	b'11111'		; Poner en 1 los bits 0,1,2 y 3 del puerto A
	movwf	PORTA
	call Retardo_2s
	movlw	b'00000000'		; Poner en 0 el puerto B
	movwf	PORTB
	movlw	b'10000'		; Poner en 0 el puerto A
	movwf	PORTA
	call Retardo_2s
	goto Funcion1
	return

Funcion2
	movlw	b'00110000'		; Poner en 1 los bits 4 y 5 del puerto B
	movwf PORTB
	movlw	b'10011'		; Poner en 1 los bits 0 y 1 del puerto A
	movwf	PORTA
	call Retardo_500ms
	movlw	b'00000000'		; Poner en 0 el puerto B
	movwf PORTB
	movlw	b'10000'		; Poner en 0 el puerto A
	movwf	PORTA
	call Retardo_500ms
	movlw	b'00110000'		
	movwf PORTB
	movlw	b'10011'
	movwf	PORTA
	call Retardo_500ms
	movlw	b'00000000'		
	movwf PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_1s
	movlw	b'11000000'		
	movwf PORTB
	movlw	b'11100'
	movwf	PORTA
	call Retardo_500ms
	movlw	b'00000000'		
	movwf PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_500ms
	movlw	b'11000000'		
	movwf PORTB
	movlw	b'11100'
	movwf	PORTA
	call Retardo_500ms
	movlw	b'00000000'		
	movwf PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_1s
	goto Funcion2
	return

Funcion3
	movlw	b'00010000'			; Poner en 1 el bit 4 del puerto B
	movwf	PORTB
	movlw	b'10001'			; Poner en 1 el bit 0 del puerto A
	movwf	PORTA
	call Retardo_1s
	movlw	b'00000000'			; Poner en 0 el puerto B
	movwf	PORTB
	movlw	b'10000'			; Poner en 0 el puerto A
	movwf	PORTA
	call Retardo_500ms
	movlw	b'00100000'	
	movwf	PORTB
	movlw	b'10010'
	movwf	PORTA
	call Retardo_1s
	movlw	b'00000000'		
	movwf	PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_500ms
	movlw	b'01000000'	
	movwf	PORTB
	movlw	b'10100'
	movwf	PORTA
	call Retardo_1s
	movlw	b'00000000'		
	movwf	PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_500ms
	movlw	b'10000000'	
	movwf	PORTB
	movlw	b'11000'
	movwf	PORTA
	call Retardo_1s
	movlw	b'00000000'		
	movwf	PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_500ms
	goto Funcion3
	return

Funcion4
	movlw	b'00110000'			; Poner en 1 los bits 4 y 5 del puerto B
	movwf	PORTB
	movlw	b'10000'			; Poner en 0 el puerto A
	movwf	PORTA
	call Retardo_1s
	movlw	b'00000000'			; Poner en 0 el puerto B
	movwf	PORTB
	movlw	b'10000'			; Poner en 0 el puerto A
	movwf	PORTA
	call Retardo_500ms
	movlw	b'11000000'	
	movwf	PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_1s
	movlw	b'00000000'	
	movwf	PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_500ms
	movlw	b'00000000'	
	movwf	PORTB
	movlw	b'10011'
	movwf	PORTA
	call Retardo_1s
	movlw	b'00000000'	
	movwf	PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_500ms
	movlw	b'00000000'	
	movwf	PORTB
	movlw	b'11100'
	movwf	PORTA
	call Retardo_1s
	movlw	b'00000000'	
	movwf	PORTB
	movlw	b'10000'
	movwf	PORTA
	call Retardo_500ms
	goto Funcion4
	return

; Rutina para esperar hasta que se suelte el pulsador activo.
Antirrebote
	btfss	PORTB,0			; Verifica el estado de RB0 (Salta si es 1)
	goto	Antirrebote		; Si no es 1, hacer un bucle hasta que sea 1
	btfss	PORTB,1			; Igual a lo comentado arriba.
	goto	Antirrebote
	btfss	PORTB,2
	goto	Antirrebote
	btfss	PORTB,3
	goto	Antirrebote
	return

;Rutina para comprobar el estado de los pulsadores dentro de la rutina de retardo
Comprobar_Estado
	btfss PORTB,0
	goto Check_1
	btfss PORTB,1
	goto Check_2
	btfss PORTB,2
	goto Check_3
	btfss PORTB,3
	goto Programa
	return

Retardo_20s						; La llamada "call" aporta 2 ciclos máquina.
	movlw	d'200'				; Aporta 1 ciclo máquina. Este es el valor de "N".
	goto	Retardo_1Decima		; Aporta 2 ciclos máquina.
Retardo_10s						; La llamada "call" aporta 2 ciclos máquina.
	movlw	d'100'				; Aporta 1 ciclo máquina. Este es el valor de "N".
	goto	Retardo_1Decima		; Aporta 2 ciclos máquina.
Retardo_5s						; La llamada "call" aporta 2 ciclos máquina.
	movlw	d'50'				; Aporta 1 ciclo máquina. Este es el valor de "N".
	goto	Retardo_1Decima		; Aporta 2 ciclos máquina.
Retardo_2s						; La llamada "call" aporta 2 ciclos máquina.
	movlw	d'20'				; Aporta 1 ciclo máquina. Este es el valor de "N".
	goto	Retardo_1Decima		; Aporta 2 ciclos máquina.
Retardo_1s						; La llamada "call" aporta 2 ciclos máquina.
	movlw	d'10'				; Aporta 1 ciclo máquina. Este es el valor de "N".
	goto	Retardo_1Decima		; Aporta 2 ciclos máquina.
Retardo_500ms					; La llamada "call" aporta 2 ciclos máquina.
	movlw	d'5'				; Aporta 1 ciclo máquina. Este es el valor de "N".
;
; El próximo bloque "Retardo_1Decima" tarda:
; 1 + N + N + MxN + MxN + KxMxN + (K-1)xMxN + MxNx2 + (K-1)xMxNx2 +
;   + (M-1)xN + Nx2 + (M-1)xNx2 + (N-1) + 2 + (N-1)x2 + 2 =
; = (2 + 4M + 4MN + 4KM) ciclos máquina. Para K=249, M=100 y N=1 supone 100011
; ciclos máquina que a 4 MHz son 100011 µs = 100 ms = 0,1 s = 1 décima de segundo.
;
Retardo_1Decima
	movwf	R_ContC				; Aporta 1 ciclo máquina.
R1Decima_BucleExterno2
	movlw	d'30'				; Aporta Nx1 ciclos máquina. Este es el valor de "M".
	movwf	R_ContB				; Aporta Nx1 ciclos máquina.
R1Decima_BucleExterno
	movlw	d'222'				; Aporta MxNx1 ciclos máquina. Este es el valor de "K".
	movwf	R_ContA				; Aporta MxNx1 ciclos máquina.
R1Decima_BucleInterno          
	call Comprobar_Estado					; Aporta KxMxNx12 ciclos máquina.
	decfsz	R_ContA,F			; (K-1)xMxNx1 cm (si no salta) + MxNx2 cm (al saltar).
	goto	R1Decima_BucleInterno	; Aporta (K-1)xMxNx2 ciclos máquina.
	decfsz	R_ContB,F			; (M-1)xNx1 cm (cuando no salta) + Nx2 cm (al saltar).
	goto	R1Decima_BucleExterno	; Aporta (M-1)xNx2 ciclos máquina.
	decfsz	R_ContC,F			; (N-1)x1 cm (cuando no salta) + 2 cm (al saltar).
	goto	R1Decima_BucleExterno2	; Aporta (N-1)x2 ciclos máquina.
	return						; El salto del retorno aporta 2 ciclos máquina.

	end