
org 33500;
;=====================================================================
; secuencias de animacion 
;=====================================================================
; debe ser una tabla fija y no variable
; cada secuencia contiene las direcciones de frames de animacion ciclica
; cada secuencia son 8 direcciones de memoria de imagen
; numero par porque las animaciones suelen ser un numero par
; un cero significa fin de secuencia, aunque siempre se gastan 8 words /secuencia
; al encontrar un cero se comienza de nuevo. 
; si no hay cero, tras el frame 8 se comienza de nuevo
 
; la secuencia cero es que no hay secuencia. 
; empezamos desde la secuencia 1

;--------------secuencias de animacion  --------
_SEQUENCES_LIST
dw SOLDADO_R0,SOLDADO_R2,SOLDADO_R1,SOLDADO_R2,0,0,0,0 ;1
dw SOLDADO_L0,SOLDADO_L2,SOLDADO_L1,SOLDADO_L2,0,0,0,0 ;2
dw SOLDADO_R0_UP,0,0,0,0,0,0,0;3
dw SOLDADO_R0_DOWN,0,0,0,0,0,0,0;4
dw SOLDADO_L0_UP,0,0,0,0,0,0,0;5
dw SOLDADO_L0_DOWN,0,0,0,0,0,0,0;6
dw BIRD_UP,BIRD_UP,BIRD_DW,BIRD_DW,0,0,0,0;7

; reserva de memoria para creacion de secuencias desde BASIC
;------------------------------------------------------------
ds 256; 256 bytes es una reserva para poder crear hasta 16 secuencias de animacion desde BASIC
	; si no vas a crear secuencias desde basic puedes borrar (o comentar) esta reserva
	; si deseas reservar hasta 31 , deberas poner "ds 496", ya que 16*31=496

_MACRO_SEQUENCES
;--------MACRO SECUENCIAS ----------------------
; son grupos de secuencias, una para cada direccion
; el significado es:
; still, left, right, up, up-left, up-right, down, down-left, down-right
; se numeran desde 32 en adelante
;db 0,2,1,3,5,3,4,6,4;32 --> secuencias del soldado , id=32. la siguiente seria la 33
db 0,2,1,3,3,3,4,4,4;32 --> secuencias del soldado , id=32. la siguiente seria la 33
db 0,2,1,5,5,5,6,6,6;33 --> secuencias del soldado , id=33. la siguiente seria la 33

