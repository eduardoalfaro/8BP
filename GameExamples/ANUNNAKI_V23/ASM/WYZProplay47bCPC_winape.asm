; CPC PSG proPLAYER V 0.2 - WYZ 09.09.2015


; ENSAMBLAR CON AsMSX 



; LOS DATOS QUE HAY QUE VARIAR :
; * BUFFER DE SONIDO DONDE SE DECODIFICA TOTALMENTE EL ARCHIVO MUS
; * N� DE CANCION. 
; * TABLA DE CANCIONES




;______________________________________________________


INICIO:		CALL    ROUT
		
		LD	HL,PSG_REG
		LD	DE,PSG_REG_SEC
		LD	BC,14
		LDIR	
		CALL    REPRODUCE_SONIDO
		CALL    PLAY
		
	
          	;CALL	REPRODUCE_EFECTO
                
         	     

  		RET		
                
      	

;REPRODUCE EFECTOS DE SONIDO 

REPRODUCE_SONIDO:

		LD      HL,INTERR   
                BIT     2,(HL)          ;ESTA ACTIVADO EL EFECTO?
                RET     Z
                LD      HL,(PUNTERO_SONIDO)
                LD      A,(HL)
                CP      &FF
                JR      Z,FIN_SONIDO
                LD	DE,(SFX_L)
                LD      (DE),A
                INC     HL
                LD      A,(HL)
                RRCA
                RRCA
                RRCA
                RRCA
                AND     %00001111
                LD	DE,(SFX_H)
                LD      (DE),A
                LD      A,(HL)
                AND     %00001111
                LD	DE,(SFX_V)
                LD      (DE),A
                
                INC     HL
                LD      A,(HL)
                LD	B,A
                BIT	7,A				;09.08.13 BIT MAS SIGINIFICATIVO ACTIVA ENVOLVENTES
                JR	Z,NO_ENVOLVENTES_SONIDO
                LD	A,&12
                LD	(DE),A
                INC	HL
                LD      A,(HL)
                LD	(PSG_REG_SEC+11),A
                INC	HL
                LD      A,(HL)
                LD	(PSG_REG_SEC+12),A
                INC	HL
                LD      A,(HL)
                CP	1
                JR	Z,NO_ENVOLVENTES_SONIDO		;NO ESCRIBE LA ENVOLVENTE SI SU VALOR ES 1
                LD	(PSG_REG_SEC+13),A                


NO_ENVOLVENTES_SONIDO:

		LD	A,B
		RES	7,A
		AND     A
                JR      Z,NO_RUIDO
                LD      (PSG_REG_SEC+6),A
                LD      A,(SFX_MIX)
                JR      SI_RUIDO
NO_RUIDO: 	XOR	A
		LD      (PSG_REG_SEC+6),A
		LD      A,%10111000
SI_RUIDO:       LD      (PSG_REG_SEC+7),A
       
                INC     HL
                LD      (PUNTERO_SONIDO),HL
                RET
FIN_SONIDO:     LD      HL,INTERR
                RES     2,(HL)
       		LD	A,(ENVOLVENTE_BACK)		;NO RESTAURA LA ENVOLVENTE SI ES 0
       		AND	A
       		JR	Z,FIN_NOPLAYER
       		;xor	a ; ***
       		LD	(PSG_REG_SEC+13),A			;08.13 RESTAURA LA ENVOLVENTE TRAS EL SFX
       		
FIN_NOPLAYER:	LD      A,%10111000
       		LD      (PSG_REG_SEC+7),A

                RET                        
		


;VUELCA BUFFER DE SONIDO AL PSG

ROUT:		LD	A,(PSG_REG+13)			
                AND	A			;ES CERO?
                JR	Z,NO_BACKUP_ENVOLVENTE
                LD	(ENVOLVENTE_BACK),A	;08.13 / GUARDA LA ENVOLVENTE EN EL BACKUP


NO_BACKUP_ENVOLVENTE:

		
		
;VUELCA BUFFER DE SONIDO AL PSG

        	XOR 	A
		LD 	HL,PSG_REG_SEC
LOUT:
		CALL 	WRITEPSGHL
		INC 	A
		CP 	13
		JR 	NZ,LOUT
		LD	A,(HL)
		AND 	A
		RET 	Z
		LD	A,13
		CALL 	WRITEPSGHL
		XOR	A
		LD      (PSG_REG+13),A
		LD      (PSG_REG_SEC+13),A
		RET

;; A = REGISTER
;; (HL) = VALUE
WRITEPSGHL:
		LD 	B,&F4              
		OUT 	(C),A              
		LD 	BC,&F6C0           
		OUT 	(C),C              
		DEFB 	&ED                
		DEFB 	&71                
		LD 	B,&F5              
		OUTI                       
		LD 	BC,&F680           
		OUT 	(C),C              
		DEFB 	&ED                
		DEFB 	&71                
		RET

;INICIA EL SONIDO N� (A)

INICIA_SONIDO:  LD      HL,TABLA_SONIDOS
                CALL    EXT_WORD
                LD      (PUNTERO_SONIDO),HL
                LD      HL,INTERR
                SET     2,(HL)
                RET
;PLAYER OFF

PLAYER_OFF:	XOR	A			;***** IMPORTANTE SI NO HAY MUSICA ****
		LD	(INTERR),A
		;LD	(FADE),A		;solo si hay fade out

		LD	HL,PSG_REG
		LD	DE,PSG_REG+1
		LD	BC,14
		LD	(HL),A
		LDIR
		
		LD      A,%10111000		; **** POR SI ACASO ****
		LD      (PSG_REG+7),A
		
		LD	HL,PSG_REG
		LD	DE,PSG_REG_SEC
		LD	BC,14
		LDIR		

		CALL	ROUT
		RET


;CARGA UNA CANCION
;IN [A]=N� DE CANCION

CARGA_CANCION:  LD      HL,INTERR       ;CARGA CANCION
		
                SET     1,(HL)          ;REPRODUCE CANCION
                LD      HL,SONG
                LD      (HL),A          ;N� A. 

                

;DECODIFICAR
;IN-> INTERR 0 ON
;     SONG

;CARGA CANCION SI/NO

DECODE_SONG:    LD      A,(SONG)

;LEE CABECERA DE LA CANCION
;BYTE 0=TEMPO

                LD      HL,TABLA_SONG
                CALL    EXT_WORD
                LD      A,(HL)
                LD      (TEMPO),A
		XOR	A
		LD	(TTEMPO),A
                
;HEADER BYTE 1
;(-|-|-|-|  3-1 | 0  )
;(-|-|-|-|FX CHN|LOOP)

                INC	HL		;LOOP 1=ON/0=OFF?
                LD	A,(HL)
                BIT	0,A
                JR	Z,NPTJP0
                PUSH	HL
                LD	HL,INTERR
                SET	4,(HL)
                POP	HL
                
              
             
;SELECCION DEL CANAL DE EFECTOS DE RITMO

NPTJP0:         AND	%00000110 
		RRA
		;LD	(SELECT_CANAL_P),A

		PUSH	HL
		LD	HL,TABLA_DATOS_CANAL_SFX
		CALL    EXT_WORD
		PUSH	HL
		POP	IX
		LD	E,(IX+0)
		LD	D,(IX+1)
		LD	(SFX_L),DE

		LD	E,(IX+2)
		LD	D,(IX+3)
		LD	(SFX_H),DE

		LD	E,(IX+4)
		LD	D,(IX+5)
		LD	(SFX_V),DE

		LD	A,(IX+6)
		LD	(SFX_MIX),A
		POP	HL
		
		INC	HL		;2 BYTES RESERVADOS
                INC	HL
                INC	HL

;BUSCA Y GUARDA INICIO DE LOS CANALES EN EL MODULO MUS (OPTIMIZAR****************)

		
		LD	(PUNTERO_P_DECA),HL
		LD	E,&3F			;CODIGO INSTRUMENTO 0
		LD	B,&FF			;EL MODULO DEBE TENER UNA LONGITUD MENOR DE $FF00 ... o_O!
		
		CALL	BGICMODBC1
		LD	(PUNTERO_P_DECB),HL

		CALL	BGICMODBC1
		LD	(PUNTERO_P_DECC),HL
		
		CALL	BGICMODBC1
		LD	(PUNTERO_P_DECP),HL
		
                
;LEE DATOS DE LAS NOTAS
;[|)[|||||) LONGITUD\NOTA

INIT_DECODER:   LD      DE,(CANAL_A)
                LD      (PUNTERO_A),DE
                LD	HL,(PUNTERO_P_DECA)
                CALL    DECODE_CANAL    	;CANAL A
                LD	(PUNTERO_DECA),HL
                
                LD      DE,(CANAL_B)
                LD      (PUNTERO_B),DE
                LD	HL,(PUNTERO_P_DECB)
                CALL    DECODE_CANAL    	;CANAL B
                LD	(PUNTERO_DECB),HL
                
                LD      DE,(CANAL_C)
                LD      (PUNTERO_C),DE
                LD	HL,(PUNTERO_P_DECC)
                CALL    DECODE_CANAL    	;CANAL C 
                LD	(PUNTERO_DECC),HL
                
                LD      DE,(CANAL_P)
                LD      (PUNTERO_P),DE
                LD	HL,(PUNTERO_P_DECP)
                CALL    DECODE_CANAL    ;CANAL P
                LD	(PUNTERO_DECP),HL
               
                RET

;BUSCA INICIO DEL CANAL

BGICMODBC1:	XOR	A			;BUSCA EL BYTE 0
		CPIR
		
		DEC	HL
		DEC	HL
		LD	A,E			;ES EL INSTRUMENTO 0??
		CP	(HL)
		INC	HL
		INC	HL
		JR	Z,BGICMODBC1

		DEC	HL
		DEC	HL
		DEC	HL
		LD	A,E			;ES VOLUMEN 0??
		CP	(HL)
		INC	HL
		INC	HL
		INC	HL
		JR	Z,BGICMODBC1
		RET

;DECODIFICA NOTAS DE UN CANAL
;IN (DE)=DIRECCION DESTINO
;NOTA=0 FIN CANAL
;NOTA=1 SILENCIO
;NOTA=2 PUNTILLO
;NOTA=3 COMANDO I

DECODE_CANAL:   LD      A,(HL)
                AND     A               ;FIN DEL CANAL?
                JR      Z,FIN_DEC_CANAL
                CALL    GETLEN

                CP      %00000001       ;ES SILENCIO?
                JR      NZ,NO_SILENCIO
                SET     6,A
                JR      NO_MODIFICA
                
NO_SILENCIO:    CP      %00111110       ;ES PUNTILLO?
                JR      NZ,NO_PUNTILLO
                OR      A
                RRC     B
                XOR     A
                JR      NO_MODIFICA

NO_PUNTILLO:    CP      %00111111       ;ES COMANDO?
                JR      NZ,NO_MODIFICA
                BIT     0,B             ;COMADO=INSTRUMENTO?
                JR      Z,NO_INSTRUMENTO   
                LD      A,%11000001     ;CODIGO DE INSTRUMENTO      
                LD      (DE),A
                INC     HL
                INC     DE
                LD      A,(HL)          ;N� DE INSTRUMENTO
                LD      (DE),A
                INC     DE
                INC	HL
                LD      A,(HL)          ;VOLUMEN RELATIVO DEL INSTRUMENTO
                LD      (DE),A
                INC     DE
                INC	HL
                JR      DECODE_CANAL
                
NO_INSTRUMENTO: BIT     2,B
                JR      Z,NO_ENVOLVENTE
                LD      A,%11000100     ;CODIGO ENVOLVENTE
                LD      (DE),A
                INC     DE
                INC	HL
                LD	A,(HL)
                LD	(DE),A
                INC	DE
                INC	HL
                JR      DECODE_CANAL
     
NO_ENVOLVENTE:  BIT     1,B
                JR      Z,NO_MODIFICA           
                LD      A,%11000010    ;CODIGO EFECTO
                LD      (DE),A                  
                INC     HL                      
                INC     DE                      
                LD      A,(HL)                  
                CALL    GETLEN   
                
NO_MODIFICA:    LD      (DE),A
                INC     DE
                XOR     A
                DJNZ    NO_MODIFICA
		SET     7,A
		SET 	0,A
                LD      (DE),A
                INC     DE
                INC	HL
                RET			;** JR      DECODE_CANAL
                
FIN_DEC_CANAL:  SET     7,A
                LD      (DE),A
                INC     DE
                RET

GETLEN:         LD      B,A
                AND     %00111111
                PUSH    AF
                LD      A,B
                AND     %11000000
                RLCA
                RLCA
                INC     A
                LD      B,A
                LD      A,%10000000
DCBC0:          RLCA
                DJNZ    DCBC0
                LD      B,A
                POP     AF
                RET
                
                

        
                
;PLAY __________________________________________________


PLAY:          	LD      HL,INTERR       ;PLAY BIT 1 ON?
                BIT     1,(HL)
                RET     Z
;TEMPO          
                LD      HL,TTEMPO       ;CONTADOR TEMPO
                INC     (HL)
                LD      A,(TEMPO)
                CP      (HL)
                JR      NZ,PAUTAS
                LD      (HL),0
                
;INTERPRETA      
                LD      IY,PSG_REG
                LD      IX,PUNTERO_A
                LD      BC,PSG_REG+8
                CALL    LOCALIZA_NOTA
                LD      IY,PSG_REG+2
                LD      IX,PUNTERO_B
                LD      BC,PSG_REG+9
                CALL    LOCALIZA_NOTA

		;---------------------------------------desactivo canal c
		LD      IY,PSG_REG+4
                LD      IX,PUNTERO_C
                LD      BC,PSG_REG+10
                CALL    LOCALIZA_NOTA
		
                LD      IX,PUNTERO_P    ;EL CANAL DE EFECTOS ENMASCARA OTRO CANAL
                CALL    LOCALIZA_EFECTO              

;PAUTAS 
                
PAUTAS:         LD      IY,PSG_REG+0
                LD      IX,PUNTERO_P_A
                LD      HL,PSG_REG+8
                CALL    PAUTA           ;PAUTA CANAL A
                LD      IY,PSG_REG+2
                LD      IX,PUNTERO_P_B
                LD      HL,PSG_REG+9
                CALL    PAUTA           ;PAUTA CANAL B

		;canal C desactivado
		;-------------------------------------------------desactivo canal c---------------
                LD      IY,PSG_REG+4
                LD      IX,PUNTERO_P_C
                LD      HL,PSG_REG+10
                CALL    PAUTA           ;PAUTA CANAL C                

                RET
                

               


;LOCALIZA NOTA CANAL A
;IN (PUNTERO_A)

;LOCALIZA NOTA CANAL A
;IN (PUNTERO_A)

LOCALIZA_NOTA:  LD      L,(IX+PUNTERO_A-PUNTERO_A)	;HL=(PUNTERO_A_C_B)
                LD      H,(IX+PUNTERO_A-PUNTERO_A+1)
                LD      A,(HL)
                AND     %11000000      			;COMANDO?
                CP      %11000000
                JR      NZ,LNJP0

;BIT(0)=INSTRUMENTO
                
COMANDOS:       LD      A,(HL)
                BIT     0,A             		;INSTRUMENTO
                JR      Z,COM_EFECTO

                INC     HL
                LD      A,(HL)          		;N� DE PAUTA
                INC     HL
                LD	E,(HL)				
                
                PUSH	HL				;;TEMPO ******************
                LD	HL,TEMPO
                BIT	5,E
                JR	Z,NO_DEC_TEMPO
                DEC	(HL)
NO_DEC_TEMPO:	BIT	6,E
		JR	Z,NO_INC_TEMPO
		INC	(HL)
NO_INC_TEMPO:	RES	5,E				;SIEMPRE RESETEA LOS BITS DE TEMPO		
		RES	6,E
		POP	HL
                
		LD      (IX+VOL_INST_A-PUNTERO_A),E	;REGISTRO DEL VOLUMEN RELATIVO
                INC	HL
                LD      (IX+PUNTERO_A-PUNTERO_A),L
                LD      (IX+PUNTERO_A-PUNTERO_A+1),H
                LD      HL,TABLA_PAUTAS
                CALL    EXT_WORD
                LD      (IX+PUNTERO_P_A0-PUNTERO_A),L
                LD      (IX+PUNTERO_P_A0-PUNTERO_A+1),H
                LD      (IX+PUNTERO_P_A-PUNTERO_A),L
                LD      (IX+PUNTERO_P_A-PUNTERO_A+1),H
                LD      L,C
                LD      H,B
                RES     4,(HL)        			;APAGA EFECTO ENVOLVENTE
                XOR     A
                LD      (PSG_REG_SEC+13),A
                LD	(PSG_REG+13),A
                ;LD	(ENVOLVENTE_BACK),A		;08.13 / RESETEA EL BACKUP DE LA ENVOLVENTE
                JR      LOCALIZA_NOTA

COM_EFECTO:     BIT     1,A             		;EFECTO DE SONIDO
                JR      Z,COM_ENVOLVENTE

                INC     HL
                LD      A,(HL)
                INC     HL
                LD      (IX+PUNTERO_A-PUNTERO_A),L
                LD      (IX+PUNTERO_A-PUNTERO_A+1),H
                CALL    INICIA_SONIDO
                RET

COM_ENVOLVENTE: BIT     2,A
                RET     Z               		;IGNORA - ERROR            
           
                INC     HL
                LD	A,(HL)			;CARGA CODIGO DE ENVOLVENTE
                LD	(ENVOLVENTE),A
                INC     HL
                LD      (IX+PUNTERO_A-PUNTERO_A),L
                LD      (IX+PUNTERO_A-PUNTERO_A+1),H
                LD      L,C
                LD      H,B
                LD	(HL),%00010000          	;ENCIENDE EFECTO ENVOLVENTE
                JR      LOCALIZA_NOTA
                
              
LNJP0:          LD      A,(HL)
                INC     HL
                BIT     7,A
                JR      Z,NO_FIN_CANAL_A	;
                BIT	0,A
                JR	Z,FIN_CANAL_A

FIN_NOTA_A:	LD      E,(IX+CANAL_A-PUNTERO_A)
		LD	D,(IX+CANAL_A-PUNTERO_A+1)	;PUNTERO BUFFER AL INICIO
		LD	(IX+PUNTERO_A-PUNTERO_A),E
		LD	(IX+PUNTERO_A-PUNTERO_A+1),D
		LD	L,(IX+PUNTERO_DECA-PUNTERO_A)	;CARGA PUNTERO DECODER
		LD	H,(IX+PUNTERO_DECA-PUNTERO_A+1)
		PUSH	BC
                CALL    DECODE_CANAL    		;DECODIFICA CANAL
                POP	BC
                LD	(IX+PUNTERO_DECA-PUNTERO_A),L	;GUARDA PUNTERO DECODER
                LD	(IX+PUNTERO_DECA-PUNTERO_A+1),H
                JP      LOCALIZA_NOTA
                
FIN_CANAL_A:    LD	HL,INTERR			;LOOP?
                BIT	4,(HL)              
                JR      NZ,FCA_CONT
                POP	AF
                JP	PLAYER_OFF
                

FCA_CONT:	LD	L,(IX+PUNTERO_P_DECA-PUNTERO_A)	;CARGA PUNTERO INICIAL DECODER
		LD	H,(IX+PUNTERO_P_DECA-PUNTERO_A+1)
		LD	(IX+PUNTERO_DECA-PUNTERO_A),L
		LD	(IX+PUNTERO_DECA-PUNTERO_A+1),H
		JR      FIN_NOTA_A
                
NO_FIN_CANAL_A: LD      (IX+PUNTERO_A-PUNTERO_A),L        	;(PUNTERO_A_B_C)=HL GUARDA PUNTERO
                LD      (IX+PUNTERO_A-PUNTERO_A+1),H
                AND     A               		;NO REPRODUCE NOTA SI NOTA=0
                JR      Z,FIN_RUTINA
                BIT     6,A             		;SILENCIO?
                JR      Z,NO_SILENCIO_A
                LD	A,(BC)
                AND	%00010000
                JR	NZ,SILENCIO_ENVOLVENTE
                
                XOR     A
                LD	(BC),A				;RESET VOLUMEN DEL CORRESPODIENTE CHIP
                ;LD	(IY+0),A
                ;LD	(IY+1),A
		RET
		
SILENCIO_ENVOLVENTE:
		LD	A,&FF
                LD	(PSG_REG+11),A
                LD	(PSG_REG+12),A               
                XOR	A
                LD	(PSG_REG+13),A                               
                LD	(IY+0),A
                LD	(IY+1),A
                RET

NO_SILENCIO_A:  LD	(IX+REG_NOTA_A-PUNTERO_A),A	;REGISTRO DE LA NOTA DEL CANAL         
		CALL    NOTA            		;REPRODUCE NOTA
                LD      L,(IX+PUNTERO_P_A0-PUNTERO_A)     ;HL=(PUNTERO_P_A0) RESETEA PAUTA 
                LD      H,(IX+PUNTERO_P_A0-PUNTERO_A+1)
                LD      (IX+PUNTERO_P_A-PUNTERO_A),L       ;(PUNTERO_P_A)=HL
                LD      (IX+PUNTERO_P_A-PUNTERO_A+1),H
FIN_RUTINA:     RET


;LOCALIZA EFECTO
;IN HL=(PUNTERO_P)

LOCALIZA_EFECTO:LD      L,(IX+0)       ;HL=(PUNTERO_P)
                LD      H,(IX+1)
                LD      A,(HL)
                CP      %11000010
                JR      NZ,LEJP0

                INC     HL
                LD      A,(HL)
                INC     HL
                LD      (IX+00),L
                LD      (IX+01),H
                CALL    INICIA_SONIDO
                RET
            
              
LEJP0:          INC     HL
                BIT     7,A
                JR      Z,NO_FIN_CANAL_P	;
                BIT	0,A
                JR	Z,FIN_CANAL_P
FIN_NOTA_P:	LD      DE,(CANAL_P)
		LD	(IX+0),E
		LD	(IX+1),D
		LD	HL,(PUNTERO_DECP)	;CARGA PUNTERO DECODER
		PUSH	BC
		CALL    DECODE_CANAL    	;DECODIFICA CANAL
		POP	BC
                LD	(PUNTERO_DECP),HL	;GUARDA PUNTERO DECODER
                JP      LOCALIZA_EFECTO
                
FIN_CANAL_P:	LD	HL,(PUNTERO_P_DECP)	;CARGA PUNTERO INICIAL DECODER
		LD	(PUNTERO_DECP),HL
		JR      FIN_NOTA_P
                
NO_FIN_CANAL_P: LD      (IX+0),L        ;(PUNTERO_A_B_C)=HL GUARDA PUNTERO
                LD      (IX+1),H
                RET

; PAUTA DE LOS 3 CANALES
; IN[IX] PUNTERO DE LA PAUTA
;    (HL) REGISTRO DE VOLUMEN
;    (IY) REGISTROS DE FRECUENCIA

; FORMATO PAUTA	
;	    7    6     5     4   3-0                        3-0  
; BYTE 1 (LOOP|OCT-1|OCT+1|ORNMT|VOL) - BYTE 2 ( | | | |PITCH/NOTA)

PAUTA:          BIT     4,(HL)        ;SI LA ENVOLVENTE ESTA ACTIVADA NO ACTUA PAUTA
                RET     NZ

		LD	A,(IY+0)
		LD	B,(IY+1)
		OR	B
		RET	Z


                PUSH	HL
           
PCAJP4:         LD      L,(IX+0)
                LD      H,(IX+1)         
		LD	A,(HL)
		
		BIT     7,A		;LOOP / EL RESTO DE BITS NO AFECTAN
                JR      Z,PCAJP0
                AND     %00011111       ;M�XIMO LOOP PAUTA (0,32)X2!!!-> PARA ORNAMENTOS
                RLCA			;X2
                LD      D,0
                LD      E,A
                SBC     HL,DE
                LD      A,(HL)

PCAJP0:		BIT	6,A		;OCTAVA -1
		JR	Z,PCAJP1
		LD	E,(IY+0)
		LD	D,(IY+1)

		AND	A
		RRC	D
		RR	E
		LD	(IY+0),E
		LD	(IY+1),D
		JR	PCAJP2
		
PCAJP1:		BIT	5,A		;OCTAVA +1
		JR	Z,PCAJP2
		LD	E,(IY+0)
		LD	D,(IY+1)

		AND	A
		RLC	E
		RL	D
		LD	(IY+0),E
		LD	(IY+1),D		




PCAJP2:		LD	A,(HL)
		BIT	4,A
		JR	NZ,PCAJP6	;ORNAMENTOS SELECCIONADOS

		INC     HL		;______________________ FUNCION PITCH DE FRECUENCIA__________________		
		PUSH	HL
		LD	E,A
		LD	A,(HL)		;PITCH DE FRECUENCIA
		LD	L,A
		AND	A
		LD	A,E
		JR	Z,ORNMJP1

                LD	A,(IY+0)	;SI LA FRECUENCIA ES 0 NO HAY PITCH
                ADD	A,(IY+1)
                AND	A
                LD	A,E
                JR	Z,ORNMJP1
                

		BIT	7,L
		JR	Z,ORNNEG
		LD	H,&FF
		JR	PCAJP3
ORNNEG:		LD	H,0
		
PCAJP3:		LD	E,(IY+0)
		LD	D,(IY+1)
		ADC	HL,DE
		LD	(IY+0),L
		LD	(IY+1),H
		JR	ORNMJP1


PCAJP6:		INC	HL		;______________________ FUNCION ORNAMENTOS__________________	
		
		PUSH	HL
		PUSH	AF
		LD	A,(IX+REG_NOTA_A-PUNTERO_P_A)	;RECUPERA REGISTRO DE NOTA EN EL CANAL
		LD	E,(HL)		;
		ADC	E		;+- NOTA 
		CALL	TABLA_NOTAS
		POP	AF	
		
		
ORNMJP1:	POP	HL
		
		INC	HL
                LD      (IX+0),L
                LD      (IX+1),H
PCAJP5:         POP	HL
		LD	B,(IX+VOL_INST_A-PUNTERO_P_A)	;VOLUMEN RELATIVO
		ADD	B
		JP	P,PCAJP7
		LD	A,1		;NO SE EXTIGUE EL VOLUMEN
PCAJP7:         AND	%00001111	;VOLUMEN FINAL MODULADO
                LD      (HL),A
                RET



;NOTA  REPRODUCE UNA NOTA
;IN (A)=CODIGO DE LA NOTA
;   (IY)=REGISTROS DE FRECUENCIA


NOTA:		LD      L,C
                LD      H,B
                BIT     4,(HL)
     		LD      B,A
                JR	NZ,EVOLVENTES
      		LD	A,B
TABLA_NOTAS:    LD      HL,DATOS_NOTAS		;BUSCA FRECUENCIA
		CALL	EXT_WORD
		LD      (IY+0),L
                LD      (IY+1),H
                RET




;IN (A)=CODIGO DE LA ENVOLVENTE
;   (IY)=REGISTRO DE FRECUENCIA

EVOLVENTES:     LD      HL,DATOS_NOTAS
		;SUB	12
		RLCA                    ;X2
                LD      D,0
                LD      E,A
                ADD     HL,DE
                LD	E,(HL)
		INC	HL
		LD	D,(HL)
		
		PUSH	DE
		LD	A,(ENVOLVENTE)		;FRECUENCIA DEL CANAL ON/OFF
		RRA
		JR	NC,FRECUENCIA_OFF
		LD      (IY+0),E
                LD      (IY+1),D
		JR	CONT_ENV
				
FRECUENCIA_OFF:	LD 	DE,&0000
		LD      (IY+0),E
                LD      (IY+1),D
					;CALCULO DEL RATIO (OCTAVA ARRIBA)
CONT_ENV:	POP	DE
		PUSH	AF
		PUSH	BC
		AND	%00000011
		LD	B,A
		;INC	B
		
		;AND	A			;1/2
		RR	D
		RR	E
CRTBC0:		;AND	A			;1/4 - 1/8 - 1/16
		RR	D
		RR	E
		DJNZ	CRTBC0
		LD	A,E
                LD      (PSG_REG+11),A
                LD	A,D
                AND	%00000011
                LD      (PSG_REG+12),A
		POP	BC
                POP	AF			;SELECCION FORMA DE ENVOLVENTE
                
                RRA
                AND	%00000110		;$08,$0A,$0C,$0E
                ADD	8                
                LD      (PSG_REG+13),A
           
                RET


;EXTRAE UN WORD DE UNA TABLA
;IN(HL)=DIRECCION TABLA
;   (A)= POSICION
;OUT(HL)=WORD

EXT_WORD:       LD      D,0
                RLCA
                LD      E,A
                ADD     HL,DE
                LD      E,(HL)
                INC     HL
                LD      D,(HL)
                EX      DE,HL
                RET
                
;TABLA DE DATOS DEL SELECTOR DEL CANAL DE EFECTOS DE RITMO

TABLA_DATOS_CANAL_SFX:

		DW	SELECT_CANAL_A,SELECT_CANAL_B,SELECT_CANAL_C


;BYTE 0 SFX_L	
;BYTE 1 SFX_H	
;BYTE 2 SFX_V	
;BYTE 3 SFX_MIX

SELECT_CANAL_A:	DW	PSG_REG_SEC+0,PSG_REG_SEC+1,PSG_REG_SEC+8
		DB	%10110001
		
SELECT_CANAL_B:	DW	PSG_REG_SEC+2,PSG_REG_SEC+3,PSG_REG_SEC+9
		DB	%10101010
		
SELECT_CANAL_C:	DW	PSG_REG_SEC+4,PSG_REG_SEC+5,PSG_REG_SEC+10
		DB	%10011100


INTERR:          DB     	00      ;INTERRUPTORES 1=ON 0=OFF
                                        ;BIT 0=CARGA CANCION ON/OFF
                                        ;BIT 1=PLAYER ON/OFF
                                        ;BIT 2=EFECTOS ON/OFF
                                        ;BIT 3=SFX ON/OFF
                                        ;BIT 4=LOOP
;CONTROL DE LAS INTERRUPCIONES

HOOK:            DB     00

;MUSICA **** EL ORDEN DE LAS VARIABLES ES FIJO ******



SONG:            DB     00        ;DB N� DE CANCION
TEMPO:           DB     00        ;DB TEMPO
TTEMPO:          DB     00        ;DB CONTADOR TEMPO

PUNTERO_A:       DW     00        ;DW PUNTERO DEL CANAL A
PUNTERO_B:       DW     00        ;DW PUNTERO DEL CANAL B
PUNTERO_C:       DW     00        ;DW PUNTERO DEL CANAL C

CANAL_A:         DW     00      ;DW DIRECION DE INICIO DE LA MUSICA A
CANAL_B:         DW     00      ;DW DIRECION DE INICIO DE LA MUSICA B
CANAL_C:         DW     00      ;DW DIRECION DE INICIO DE LA MUSICA C

PUNTERO_P_A:     DW     00      ;DW PUNTERO PAUTA CANAL A
PUNTERO_P_B:     DW     00      ;DW PUNTERO PAUTA CANAL B
PUNTERO_P_C:     DW     00      ;DW PUNTERO PAUTA CANAL C

PUNTERO_P_A0:    DW     00      ;DW INI PUNTERO PAUTA CANAL A
PUNTERO_P_B0:    DW     00      ;DW INI PUNTERO PAUTA CANAL B
PUNTERO_P_C0:    DW     00      ;DW INI PUNTERO PAUTA CANAL C

PUNTERO_P_DECA:	DW     00	;DW PUNTERO DE INICIO DEL DECODER CANAL A
PUNTERO_P_DECB:	DW     00	;DW PUNTERO DE INICIO DEL DECODER CANAL B
PUNTERO_P_DECC:	DW     00	;DW PUNTERO DE INICIO DEL DECODER CANAL C

PUNTERO_DECA:	DW     00	;DW PUNTERO DECODER CANAL A
PUNTERO_DECB:	DW     00	;DW PUNTERO DECODER CANAL B
PUNTERO_DECC:	DW     00	;DW PUNTERO DECODER CANAL C       

REG_NOTA_A:	DB     00		;DB REGISTRO DE LA NOTA EN EL CANAL A
VOL_INST_A:	DB     00		;DB VOLUMEN RELATIVO DEL INSTRUMENTO DEL CANAL A
REG_NOTA_B:	DB     00		;DB REGISTRO DE LA NOTA EN EL CANAL B
VOL_INST_B:	DB     00		;DB VOLUMEN RELATIVO DEL INSTRUMENTO DEL CANAL B					;VACIO
REG_NOTA_C:	DB     00		;DB REGISTRO DE LA NOTA EN EL CANAL C
VOL_INST_C:	DB     00		;DB VOLUMEN RELATIVO DEL INSTRUMENTO DEL CANAL C


;CANAL DE EFECTOS DE RITMO - ENMASCARA OTRO CANAL

PUNTERO_P:       DW     00      ;DW PUNTERO DEL CANAL EFECTOS
CANAL_P:         DW     00      ;DW DIRECION DE INICIO DE LOS EFECTOS
PUNTERO_P_DECP: DW     00	;DW PUNTERO DE INICIO DEL DECODER CANAL P
PUNTERO_DECP:	 DW     00	;DW PUNTERO DECODER CANAL P
;SELECT_CANAL_P	DB	INTERR+$36	;DB SELECCION DE CANAL DE EFECTOS DE RITMO


SFX_L:		DW     00	;DW DIRECCION BUFFER EFECTOS DE RITMO REGISTRO BAJO
SFX_H:		DW     00	;DW DIRECCION BUFFER EFECTOS DE RITMO REGISTRO ALTO
SFX_V:		DW     00	;DW DIRECCION BUFFER EFECTOS DE RITMO REGISTRO VOLUMEN
SFX_MIX:	DW     00	;DW DIRECCION BUFFER EFECTOS DE RITMO REGISTRO MIXER


;EFECTOS DE SONIDO

N_SONIDO:        DB     00      ;DB  NUMERO DE SONIDO
PUNTERO_SONIDO:  DW     00      ;DW  PUNTERO DEL SONIDO QUE SE REPRODUCE



;DB (13) BUFFERs DE REGISTROS DEL PSG

PSG_REG:         DB      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
PSG_REG_SEC:	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
ENVOLVENTE:	DB	00		;DB  FORMA DE LA ENVOLVENTE
               				;BIT 0	   FRECUENCIA CANAL ON/OFF
               				;BIT 1-2   RATIO 
               				;BIT 3-3   FORMA	
ENVOLVENTE_BACK: DB	00		;DB	BACKUP DE LA FORMA DE LA ENVOLENTE




