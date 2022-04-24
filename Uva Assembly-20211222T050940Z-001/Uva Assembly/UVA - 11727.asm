INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
    
    a DB ?
    b DB ?
    c DB ?
    MAX DB ?
    MIN DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV a,AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV b,AL 
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV c,AL   
    
    PRINTN
    
    
    ;MAXIMUM
    MOV BL, 0
    MOV MAX, BL
    
    MOV BL, a
    CMP BL, MAX
    JNG NEXT1
   
    MOV MAX, BL
    
    NEXT1:
    MOV BL, b
    CMP BL, MAX
    JNG NEXT2
    
    MOV MAX, BL
    
    NEXT2:
    MOV BL, c
    CMP BL, MAX
    JNG NEXT3
     
    MOV MAX, BL
        
                    
    NEXT3:
    ;MINIMUM    
    MOV BL, 100
    MOV MIN, BL
    
    MOV BL, a
    CMP BL, MIN
    JNL NEXT4
   
    MOV MIN, BL
    
    NEXT4:
    MOV BL, b
    CMP BL, MIN
    JNL NEXT5
    
    MOV MIN, BL
    
    NEXT5:
    MOV BL, c
    CMP BL, MIN
    JNL NEXT6
        
    MOV MIN, BL
     
    NEXT6: 
    
    
    ;a
    MOV BL, a
    CMP BL, MAX 
    JE EXIT_A
    
    CMP BL, MIN
    JE EXIT_A
    
    MOV AH, 2
    MOV DL, a
    ADD DL, 48
    INT 21H  
    
    JMP EXIT
    
    EXIT_A:
    
    ;b
    MOV BL, b
    CMP BL, MAX 
    JE EXIT_B
    
    CMP BL, MIN
    JE EXIT_B
    
    MOV AH, 2
    MOV DL, b
    ADD DL, 48
    INT 21H  
    
    JMP EXIT
    
    EXIT_B:
    
    ;c
    MOV BL, c
    CMP BL, MAX 
    JE EXIT_C
    
    CMP BL, MIN
    JE EXIT_C
    
    MOV AH, 2
    MOV DL, c
    ADD DL, 48
    INT 21H    
    
    JMP EXIT
    
    EXIT_C:
    
    EXIT:
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN    