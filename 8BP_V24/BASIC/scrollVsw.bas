1 MODE 0
10 FOR i=1 TO 100:PRINT "A";:NEXT
20 FOR i=1 TO 100:PRINT "F";:NEXT     
30 CALL &4000
31 PEN RND*13
35 i=i MOD 4+1: IF i=1 THEN GOSUB 100    
40 GOTO 30
100 PEN RND*13 
110 LOCATE RND*11+9,2:PRINT "H"
120 RETURN