; si ensamblas esto independientemente
; deberia ser al menos donde acaba el codigo de 8bp y del player, comprobando
; donde se ensambla la etiqueta _FIN_CODIGO. 
; 
; tras ensamblarlo, salvalo con save "musica.bin",b,32250,1250 
org 32250
;--------------------MUSICA------------------------------------
; tiene la limitacion de tan solo poder incluir un solo fichero de 
; instrumentos para todas las canciones
; la limitacion se solventa simplemente metiendo todos los 
; instrumentos en un solo fichero.

;archivo de instrumentos. OJO TIENE QUE SER SOLO UNO
;read	"../MUSIC/instrumentos_overwrite.mus.asm" ;
read	"../MUSIC/nibiru5.mus.asm" ;
;read	"../MUSIC/atack3.mus.asm" ;
; archivos de musica
; ojo la primera nota debe sonar en los 3 canales y ademas ya nunca se repetira
; si no hacemos sonar una primera nota, el canal se queda mudo. Parece un bug del player aunque 
; no tiene ningun efecto negativo si cumplimos esta regla.
; IMPORTANTE esta nota especial debe ser del instrumento con id=0 (edito usando WYZ tracker)
; si es de otro instrumento me da problemas.
SONG_0:
INCBIN	"../MUSIC/atack5.mus" ;

SONG_0_END:


SONG_1:
INCBIN	"../MUSIC/nibiru5.mus" ;
SONG_1_END:


org 25600; esta linea la uso porque no me cabe la tercera cancion en la zona reservada de musica
SONG_2:
INCBIN	"../MUSIC/gorgo3.mus" ;
SONG_3:
SONG_4:
SONG_5:
SONG_6:
SONG_7:
_FIN_MUSICAS