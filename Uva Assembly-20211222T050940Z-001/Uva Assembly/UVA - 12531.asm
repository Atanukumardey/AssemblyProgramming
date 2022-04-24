INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    N DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV N, AL
    
    PRINTN
    
    MOV BL, 6
    MOV AL, N
    MOV AH, 00
    DIV BL
    
    CMP AH, 0
    JE YES
    JNE NO
    
    YES:
        PRINT "Y"
        JMP EXIT
    
    NO:
        PRINT "N"
        
        
    EXIT:
    
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN