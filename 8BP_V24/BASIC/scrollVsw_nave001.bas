10 CALL &6B78
20 MEMORY 25999
30 DEFINT a-z
40 CALL &6B78
50 |SETUPSP,0,9,&84D0
60 |PRINTSP,0,50,50
70 |SETUPSP,0,0,&1
71 x=50:y=50
80 |LOCATESP,0,y,x
90 MODE 0
100 FOR i=1 TO 100:PRINT "A";:NEXT
110 FOR i=1 TO 100:PRINT "F";:NEXT     
120 CALL 26000   
130 |PRINTSPALL,0,0,0
131 IF INKEY(67)=0 THEN y=y-2
132 IF INKEY(69)=0 THEN y=y+2
133 IF INKEY(27)=0 THEN x=x+1
134 IF INKEY(34)=0 THEN x=x-1
139 |LOCATESP,0,y,x
140 PEN RND*13
150 i=i MOD 4+1: IF i=1 THEN GOSUB 170    
160 GOTO 120
170 PEN RND*13 
180 LOCATE RND*11+9,2:PRINT "&"    
190 RETURN