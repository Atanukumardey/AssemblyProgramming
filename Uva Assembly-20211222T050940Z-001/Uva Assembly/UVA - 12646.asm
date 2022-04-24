INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    A DB ?
    B DB ?
    C DB ?
        
.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV A, AL 
    
    PRINT " "
    
    INT 21H
    SUB AL, 48
    MOV B, AL   
    
    PRINT " "
    
    INT 21H
    SUB AL, 48
    MOV C, AL 
    
    PRINTN
    
    ;CHECK
    
    MOV BL, B
    CMP A, BL
    JNE NEXT1
    
    MOV BL, C
    CMP A, BL
    JE NEXT1 
    
    PRINT "C"
    JMP EXIT
    
    NEXT1: 
    
    MOV BL, C
    CMP B, BL
    JNE NEXT2
    
    MOV BL, A
    CMP B, BL
    JE NEXT2 
    
    PRINT "A"
    JMP EXIT
    
    NEXT2: 
    
    MOV BL, C
    CMP A, BL
    JNE NEXT3
    
    MOV BL, B
    CMP A, BL
    JE NEXT3 
    
    PRINT "B"
    JMP EXIT
    
    NEXT3:
    
    PRINT "*"
    
    EXIT:
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN