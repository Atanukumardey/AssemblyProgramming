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
    
    MOV AL, N
    MOV AH, 00
    MOV BL, 2
    DIV BL 
    
    MOV DL, AL
    ADD DL, 48
    MOV AH, 2
    INT 21H
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN