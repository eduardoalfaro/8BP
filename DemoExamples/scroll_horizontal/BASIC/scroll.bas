10 MEMORY 25999     
11 FOR dir=42540 TO 42618 STEP 2: POKE dir,20+RND*110:POKE dir+1,RND*80:NEXT
20 MODE 0
30 ON BREAK GOSUB 280
40 CALL &6B78
50 DEFINT a-z
51 INK 0,0
52 |MUSIC,0,5
110 xo=0:yo=0  
111 x=36:y=100
120 |SETUPSP,31,0,&X100001
130 |SETUPSP,31,7,1:dir=1:' direccion inicial hacia arriba
140 |LOCATESP,31,y,x
160 |SETLIMITS,0,80,0,176: |PRINTSPALL,0,1,0
161 LOCATE 1,23 :PEN 1: PRINT "VIDAS:3 MISILES:250"
162 LOCATE 1,1:PRINT "  DEMO SCROLL 8BP"
170 col%=32:sp%=32:|COLSPALL,@sp%,@col%
180 |COLSP, 34, 0, 0: REM colision en cuanto hay un mnimo solape
190 'comienza ciclo de juego
200 IF INKEY(27)=0 THEN x=x+1: GOTO 220
210 IF INKEY(34)=0 THEN x=x-1:IF x<0 THEN x=0
220 IF INKEY(69)=0 THEN y=y+2: GOTO 240    
230 IF INKEY(67)=0 THEN y=y-2:IF y<0 THEN y=0   
240 IF xa=x AND ya=y THEN dir=0 ELSE |ANIMA,31
250 |MAP2SP,yo,xo:|COLSPALL:IF col<32 THEN END
260 |PRINTSPALL
261  ciclo=ciclo +1: IF ciclo=2 THEN  |STARS,0,5,2,0,-1:ciclo=0    
262 xo=xo+1:IF xo=210 THEN xo=100 
263 |LOCATESP,31,y,x
270 GOTO 200
280 |MUSICOFF:MODE 1: INK 0,0:PEN 1