INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
    
    M DB ?
    N DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV M,AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV N,AL 
    
    
    ; M*N
    
    MOV AL,M
    MOV AH,00
    MUL N
    MOV BL,AL
    
    SUB BL,1
    
    MOV DL,BL
    ADD DL,48
    
    PRINTN
    
    MOV AH,2
    INT 21H
    
     
    
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN