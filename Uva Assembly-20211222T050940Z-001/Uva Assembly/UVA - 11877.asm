INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    N DB ?
    K DB ?
    C DB ?
    U DB ? 
    P DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV N, AL
    
    PRINTN
    
    MOV BL, 0
    MOV C, BL
    MOV BL, N
    MOV U, BL
    
    LOOP_1:
        MOV BL, 3
        CMP U, BL
        JL EXIT_LOOP
        
        MOV BL, 3
        MOV AL, U
        MOV AH, 00
        DIV BL
        MOV P, AL
        
        MOV BL, P
        ADD C, BL
        
        MOV BL, 3
        SUB BL, 1
        
        MOV AL, P
        MOV AH, 00
        MUL BL
        
        SUB U, AL
        
        JMP LOOP_1    
        
    EXIT_LOOP:
    
    MOV AH, 2
    MOV DL, C
    ADD DL, 48
    INT 21H
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN