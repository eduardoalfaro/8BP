10 MEMORY 24499
20 ON BREAK GOSUB 230
30 CALL &6B78: CALL &BC02
40 MODE 0: DEFINT a-z
50 PAPER 8:PEN 10: WINDOW 1,20,1,12:CLS
60 c$="PSEUDO 3D"
70 LOCATE 6,3:PRINT "PSEUDO 3D"
80 PAPER 1: WINDOW 1,20,13,25:CLS
90 |3D,1,31,0
100 GOSUB 160
110 Y=0:X=5:|PRINTSPALL,0,0,0
120 |MAP2SP,Y,X:|PRINTSPALL
130 y=4+y MOD 450
140 GOTO 120
150 REM paleta
160 INK 0,13:INK 1,18
170 INK 8,2
180 INK 5,26
190 INK 10,25
200 INK 11,25
210 INK 2,0
220 RETURN
230 |MUSICOFF:MODE 1:CALL &BC02: PEN 1:PAPER 0