IMAGE_LIST
;---------------------------------------------------------------------------------------------
;pondremos aqui una lista de las imagenes que queremos usar sin especificar la direccion de memoria desde basic
; de este modo el comando |SETUPSP,<id>,9,<address> se transforma en |SETUPSP,<id>,9,<numero>
; la ventaja de no usar direcciones de memoria en basic es que si ampliamos los graficos o se reensamblan en 
; direcciones diferentes, el numero que asignemos no cambiara
; NO tienen que tener todas un numero, solo aquellas que vamos a usar con |setupsp, id, 9,<num>
; se empiezan a numerar en 16
; podemos usar hasta 255 imagenes especificadas de este modo 
; no hace falta que la lista tenga 255 elementos. es de longitud variable, incluso puede estar vacia
;----------------------------------------------------------------------------------------------
dw SOLDADO_R0; 16
dw SOLDADO_R1;17 piernas abiertas
dw SOLDADO_R2;18
dw SOLDADO_L0;19
dw SOLDADO_L1;20 piernas abiertas
dw SOLDADO_L2;21
dw SOLDADO_R1_UP;22
dw SOLDADO_R1_DOWN;23
dw SOLDADO_L1_UP;24
dw SOLDADO_L1_DOWN;25
dw DISPARO;26
; ahora las imagenes
IMAGE0

; si no vas a usar el comando PRINTAT,  sino simplemente los caracteres del amstrad, entonces
; puedes comentar la siguientes 3 lineas
_ALPHABET_BEGIN
read "alphabet_default.asm"
_ALPHABET_END

;------ BEGIN SPRITE --------
DISPARO
db 6 ; ancho
db 8 ; alto
db 0,0 , 0 , 0 , 0 ,0
db 0,0 , 16 , 32 , 0 ,0
db 0,0 , 100 , 152 , 0 ,0
db 0,0 , 100 , 152 , 0 ,0
db 0,0 , 100 , 152 , 0 ,0
db 0,0 , 16 , 32 , 0 ,0
db 0,0 , 0 , 0 , 0 ,0
db 0,0 , 0 , 0 , 0 ,0
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_R0
db 6 ; ancho
db 24 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 56 , 48 , 32 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 12 , 36 , 112 , 240 , 0 
db 0 , 164 , 240 , 229 , 207 , 0 
db 0 , 69 , 207 , 207 , 207 , 0 
db 0 , 80 , 207 , 207 , 218 , 0 
db 0 , 0 , 229 , 207 , 248 , 0 
db 0 , 0 , 80 , 240 , 240 , 0 
db 0 , 16 , 48 , 48 , 80 , 0 
db 0 , 16 , 37 , 48 , 90 , 0 
db 0 , 16 , 15 , 26 , 79 , 0 
db 0 , 16 , 37 , 48 , 79 , 0 
db 0 , 0 , 37 , 37 , 0 , 0 
db 0 , 0 , 48 , 37 , 0 , 0 
db 0 , 0 , 16 , 15 , 0 , 0 
db 0 , 0 , 32 , 16 , 32 , 0 
db 0 , 0 , 48 , 16 , 48 , 0 
db 0 , 0 , 60 , 60 , 60 , 0 
db 0 , 0 , 0 , 0 , 0 , 0
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_R1
db 6 ; ancho
db 24 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 56 , 48 , 32 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 240 , 240 , 0 
db 0 , 88 , 240 , 229 , 218 , 0 
db 0 , 164 , 207 , 207 , 207 , 0 
db 0 , 69 , 207 , 207 , 207 , 0 
db 0 , 80 , 207 , 207 , 218 , 0 
db 0 , 0 , 229 , 207 , 248 , 0 
db 0 , 16 , 48 , 48 , 240 , 0 
db 0 , 16 , 37 , 48 , 80 , 0 
db 0 , 16 , 15 , 26 , 79 , 0 
db 0 , 16 , 37 , 48 , 79 , 0 
db 0 , 80 , 37 , 37 , 90 , 0 
db 0 , 0 , 48 , 37 , 0 , 0 
db 0 , 0 , 176 , 15 , 0 , 0 
db 0 , 48 , 80 , 15 , 176 , 0 
db 0 , 48 , 160 , 80 , 48 , 0 
db 0 , 16 , 112 , 16 , 112 , 0 
db 0 , 0 , 60 , 60 , 60 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_R1_UP
db 6 ; ancho
db 29 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 56 , 48 , 32 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 240 , 240 , 0 
db 0 , 88 , 240 , 229 , 218 , 0 
db 0 , 164 , 207 , 207 , 207 , 0 
db 0 , 69 , 207 , 207 , 207 , 0 
db 0 , 80 , 207 , 207 , 218 , 0 
db 0 , 0 , 229 , 207 , 248 , 0 
db 0 , 16 , 48 , 48 , 240 , 0 
db 0 , 16 , 37 , 48 , 80 , 0 
db 0 , 16 , 15 , 26 , 79 , 0 
db 0 , 16 , 37 , 48 , 79 , 0 
db 0 , 80 , 37 , 37 , 90 , 0 
db 0 , 0 , 48 , 37 , 0 , 0 
db 0 , 0 , 176 , 15 , 0 , 0 
db 0 , 48 , 80 , 15 , 176 , 0 
db 0 , 48 , 160 , 80 , 48 , 0 
db 0 , 16 , 112 , 16 , 112 , 0 
db 0 , 0 , 60 , 60 , 60 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_R1_down
db 6 ; ancho
db 29 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 56 , 48 , 32 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 240 , 240 , 0 
db 0 , 88 , 240 , 229 , 218 , 0 
db 0 , 164 , 207 , 207 , 207 , 0 
db 0 , 69 , 207 , 207 , 207 , 0 
db 0 , 80 , 207 , 207 , 218 , 0 
db 0 , 0 , 229 , 207 , 248 , 0 
db 0 , 16 , 48 , 48 , 240 , 0 
db 0 , 16 , 37 , 48 , 80 , 0 
db 0 , 16 , 15 , 26 , 79 , 0 
db 0 , 16 , 37 , 48 , 79 , 0 
db 0 , 80 , 37 , 37 , 90 , 0 
db 0 , 0 , 48 , 37 , 0 , 0 
db 0 , 0 , 176 , 15 , 0 , 0 
db 0 , 48 , 80 , 15 , 176 , 0 
db 0 , 48 , 160 , 80 , 48 , 0 
db 0 , 16 , 112 , 16 , 112 , 0 
db 0 , 0 , 60 , 60 , 60 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_R2
db 6 ; ancho
db 24 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 56 , 48 , 32 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 52 , 48 , 48 , 48 , 0 
db 0 , 12 , 36 , 112 , 240 , 0 
db 0 , 164 , 240 , 229 , 207 , 0 
db 0 , 69 , 207 , 207 , 207 , 0 
db 0 , 80 , 207 , 207 , 218 , 0 
db 0 , 0 , 229 , 207 , 248 , 0 
db 0 , 0 , 80 , 240 , 240 , 0 
db 0 , 16 , 48 , 48 , 80 , 0 
db 0 , 16 , 37 , 48 , 90 , 0 
db 0 , 16 , 15 , 26 , 90 , 0 
db 0 , 16 , 37 , 48 , 90 , 0 
db 0 , 0 , 37 , 37 , 0 , 0 
db 0 , 0 , 48 , 37 , 138 , 0 
db 0 , 0 , 16 , 79 , 138 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 16 , 32 , 0 , 0 
db 0 , 0 , 16 , 32 , 0 , 0 
db 0 , 0 , 16 , 48 , 0 , 0 
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_L0
db 6 ; ancho
db 24 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 48 , 52 , 32 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 240 , 176 , 24 , 12 , 0 
db 0 , 207 , 218 , 240 , 88 , 0 
db 0 , 207 , 207 , 207 , 138 , 0 
db 0 , 229 , 207 , 207 , 160 , 0 
db 0 , 244 , 207 , 218 , 0 , 0 
db 0 , 240 , 240 , 160 , 0 , 0 
db 0 , 160 , 48 , 48 , 32 , 0 
db 0 , 165 , 48 , 26 , 32 , 0 
db 0 , 143 , 37 , 15 , 32 , 0 
db 0 , 143 , 48 , 26 , 32 , 0 
db 0 , 0 , 26 , 26 , 0 , 0 
db 0 , 0 , 26 , 48 , 0 , 0 
db 0 , 0 , 15 , 32 , 0 , 0 
db 0 , 16 , 32 , 16 , 0 , 0 
db 0 , 48 , 32 , 48 , 0 , 0 
db 0 , 60 , 60 , 60 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_L1
db 6 ; ancho
db 24 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 48 , 52 , 32 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 240 , 240 , 48 , 56 , 0 
db 0 , 229 , 218 , 240 , 164 , 0 
db 0 , 207 , 207 , 207 , 88 , 0 
db 0 , 207 , 207 , 207 , 138 , 0 
db 0 , 229 , 207 , 207 , 160 , 0 
db 0 , 244 , 207 , 218 , 0 , 0 
db 0 , 240 , 48 , 48 , 32 , 0 
db 0 , 160 , 48 , 26 , 32 , 0 
db 0 , 143 , 37 , 15 , 32 , 0 
db 0 , 143 , 48 , 26 , 32 , 0 
db 0 , 165 , 26 , 26 , 160 , 0 
db 0 , 0 , 26 , 48 , 0 , 0 
db 0 , 0 , 15 , 112 , 0 , 0 
db 0 , 112 , 15 , 160 , 48 , 0 
db 0 , 48 , 160 , 80 , 48 , 0 
db 0 , 176 , 32 , 176 , 32 , 0 
db 0 , 60 , 60 , 60 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_L1_UP
db 6 ; ancho
db 29 ; alto
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 48 , 52 , 32 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 240 , 240 , 48 , 56 , 0 
db 0 , 229 , 218 , 240 , 164 , 0 
db 0 , 207 , 207 , 207 , 88 , 0 
db 0 , 207 , 207 , 207 , 138 , 0 
db 0 , 229 , 207 , 207 , 160 , 0 
db 0 , 244 , 207 , 218 , 0 , 0 
db 0 , 240 , 48 , 48 , 32 , 0 
db 0 , 160 , 48 , 26 , 32 , 0 
db 0 , 143 , 37 , 15 , 32 , 0 
db 0 , 143 , 48 , 26 , 32 , 0 
db 0 , 165 , 26 , 26 , 160 , 0 
db 0 , 0 , 26 , 48 , 0 , 0 
db 0 , 0 , 15 , 112 , 0 , 0 
db 0 , 112 , 15 , 160 , 48 , 0 
db 0 , 48 , 160 , 80 , 48 , 0 
db 0 , 176 , 32 , 176 , 32 , 0 
db 0 , 60 , 60 , 60 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_L1_DOWN
db 6 ; ancho
db 29 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 48 , 52 , 32 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 240 , 240 , 48 , 56 , 0 
db 0 , 229 , 218 , 240 , 164 , 0 
db 0 , 207 , 207 , 207 , 88 , 0 
db 0 , 207 , 207 , 207 , 138 , 0 
db 0 , 229 , 207 , 207 , 160 , 0 
db 0 , 244 , 207 , 218 , 0 , 0 
db 0 , 240 , 48 , 48 , 32 , 0 
db 0 , 160 , 48 , 26 , 32 , 0 
db 0 , 143 , 37 , 15 , 32 , 0 
db 0 , 143 , 48 , 26 , 32 , 0 
db 0 , 165 , 26 , 26 , 160 , 0 
db 0 , 0 , 26 , 48 , 0 , 0 
db 0 , 0 , 15 , 112 , 0 , 0 
db 0 , 112 , 15 , 160 , 48 , 0 
db 0 , 48 , 160 , 80 , 48 , 0 
db 0 , 176 , 32 , 176 , 32 , 0 
db 0 , 60 , 60 , 60 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 

;------ END SPRITE --------
;------ BEGIN SPRITE --------
SOLDADO_L2
db 6 ; ancho
db 24 ; alto
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 48 , 48 , 0 , 0 
db 0 , 16 , 48 , 52 , 32 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 48 , 48 , 48 , 56 , 0 
db 0 , 240 , 176 , 24 , 12 , 0 
db 0 , 207 , 218 , 240 , 88 , 0 
db 0 , 207 , 207 , 207 , 138 , 0 
db 0 , 229 , 207 , 207 , 160 , 0 
db 0 , 244 , 207 , 218 , 0 , 0 
db 0 , 240 , 240 , 160 , 0 , 0 
db 0 , 160 , 48 , 48 , 32 , 0 
db 0 , 165 , 48 , 26 , 32 , 0 
db 0 , 165 , 37 , 15 , 32 , 0 
db 0 , 165 , 48 , 26 , 32 , 0 
db 0 , 0 , 26 , 26 , 0 , 0 
db 0 , 69 , 26 , 48 , 0 , 0 
db 0 , 69 , 143 , 32 , 0 , 0 
db 0 , 0 , 0 , 0 , 0 , 0 
db 0 , 0 , 16 , 32 , 0 , 0 
db 0 , 0 , 16 , 32 , 0 , 0 
db 0 , 0 , 48 , 32 , 0 , 0 
;------ END SPRITE --------




;------ BEGIN IMAGE --------
CARTEL3
db 15 ; ancho
db 24 ; alto
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 132 , 12 , 12 , 12 , 12 , 12 , 12 , 12 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 13 , 15 , 15 , 15 , 15 , 15 , 15 , 14 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 207 , 207 , 207 , 207 , 207 , 207 , 143 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 155 , 207 , 51 , 207 , 51 , 103 , 143 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 38 , 103 , 12 , 103 , 12 , 77 , 15 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 77 , 13 , 77 , 77 , 77 , 77 , 143 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 25 , 13 , 25 , 77 , 25 , 77 , 143 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 38 , 39 , 12 , 103 , 12 , 77 , 143 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 77 , 13 , 77 , 77 , 77 , 207 , 15 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 77 , 13 , 25 , 77 , 77 , 207 , 15 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 25 , 13 , 12 , 207 , 77 , 207 , 143 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 142 , 15 , 207 , 207 , 207 , 207 , 143 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 79 , 207 , 143 , 207 , 207 , 207 , 207 , 15 , 72 , 192 , 192 , 192 
db 192 , 192 , 192 , 197 , 79 , 79 , 207 , 207 , 207 , 143 , 142 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 14 , 192 , 192 , 192 , 192 , 192  
;------ END IMAGE --------

;------ BEGIN SPRITE --------
CARTEL2
db 10 ; ancho
db 20 ; alto
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 132 , 12 , 12 , 12 , 12 , 72 , 192 , 192 
db 192 , 192 , 77 , 207 , 207 , 207 , 207 , 12 , 192 , 192 
db 192 , 192 , 207 , 207 , 207 , 207 , 207 , 142 , 192 , 192 
db 192 , 192 , 207 , 207 , 207 , 207 , 207 , 142 , 192 , 192 
db 192 , 192 , 142 , 77 , 12 , 142 , 77 , 142 , 192 , 192 
db 192 , 192 , 142 , 77 , 6 , 142 , 77 , 142 , 192 , 192 
db 192 , 192 , 139 , 71 , 12 , 142 , 77 , 142 , 192 , 192 
db 192 , 192 , 142 , 77 , 6 , 142 , 207 , 142 , 192 , 192 
db 192 , 192 , 142 , 77 , 12 , 142 , 207 , 142 , 192 , 192 
db 192 , 192 , 207 , 207 , 207 , 207 , 207 , 142 , 192 , 192 
db 192 , 192 , 197 , 207 , 207 , 207 , 207 , 12 , 192 , 192 
db 192 , 192 , 192 , 142 , 192 , 192 , 142 , 192 , 192 , 192 
db 192 , 192 , 192 , 142 , 192 , 192 , 142 , 192 , 192 , 192 
db 192 , 192 , 192 , 142 , 192 , 192 , 142 , 192 , 192 , 192 
db 192 , 192 , 192 , 142 , 192 , 192 , 142 , 192 , 192 , 192 
;------ END SPRITE --------
;------ BEGIN IMAGE --------
CARTEL1
db 5 ; ancho
db 10 ; alto
db 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 
db 192 , 192 , 192 , 192 , 192 
db 192 , 207 , 207 , 142 , 192 
db 192 , 207 , 207 , 142 , 192 
db 192 , 207 , 207 , 142 , 192 
db 192 , 207 , 207 , 142 , 192 
db 192 , 77 , 77 , 72 , 192 
db 192 , 197 , 197 , 72 , 192 
db 192 , 197 , 197 , 192 , 192 
;------ END IMAGE --------



_3D_ZOOM_IMAGES
;=================================================
; limites aplicables a todas las imagenes con zoom
; para estos limites se considera el horizonte como el 0 y hacia abajo va creciendo hasta 200
;_ZOOM_LIMIT_B
;db 50


_ZOOM_LIMIT_A
db 120; entre 0 y limitA se pone imagen 3
;db 100
;db 150
_ZOOM_LIMIT_B
;db 100
db 50
;db 80; entre este limite y el limite A, se pone imagen 2
; mas cerca que limit B se pone imagen 1
;=================================================


CARTEL_ZOOM
db 1; ancho simbolico
db 1; alto simbolico
dw CARTEL1, CARTEL2, CARTEL3



;=================================================
_3D_ZOOM_IMAGES_END
;=================================================

;=================================================================
_3D_SEGMENTS
;=================================================================
; el ancho es el de la scanline
; el alto es el alto real
; luego va el dx, que puede ser positivo ( inclinado a izquierda) o negativo (inclinado a derecha)
; finalmente podria ir un dy que indique alto de patron de repeticion
db 0; esto es para que la primera imagen de tipo segmento sea > _3D_SEGMENTS
;--------------------------------------------------------------------


; SEGMENTOS LATERAL IZQUIERDO
;
;----------------- SEGMENTOS RECTOS --------------------------------
SEGMENT_L0
db 20; ancho
db 50; alto
db 0; dx
db 192,192,192,192, 192,192,192,192 ,192,240,240, 0, 0, 0, 0, 0, 0, 0, 0, 0
;-------------------------------------------------------------------
SEGMENT_R0
db 20; ancho
db 50; alto
db 0; dx
db 0, 0, 0, 0, 0, 0, 0, 0, 0,240,240, 192,192,192,192, 192,192,192,192 ,192
;-------------------------------------------------------------------
;----------------- SEGMENTOS A LA DERECHA --------------------------------
SEGMENT_LD20
db 20; ancho
db 50; alto
db -20; dx
db 192,192,192,192, 192,192,192,192 ,192,240,240, 0, 0, 0, 0, 0, 0, 0, 0, 0
;-------------------------------------------------------------------
SEGMENT_RD20
db 20; ancho
db 50; alto
db -20; dx
db 0, 0, 0, 0, 0, 0, 0, 0, 0,240,240, 192,192,192,192, 192,192,192,192 ,192
;-------------------------------------------------------------------
;----------------- SEGMENTOS A LA IZQUIERDA --------------------------------
SEGMENT_LI20
db 20; ancho
db 50; alto
db 20; dx
db 192,192,192,192, 192,192,192,192 ,192,240,240, 0, 0, 0, 0, 0, 0, 0, 0, 0
;-------------------------------------------------------------------
SEGMENT_RI20
db 20; ancho
db 50; alto
db 20; dx
db 0, 0, 0, 0, 0, 0, 0, 0, 0,240,240, 192,192,192,192, 192,192,192,192 ,192
;-------------------------------------------------------------------


_FINGRAPH