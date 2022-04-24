INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
    
    v DB ?
    t DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV v, AL 
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV t, AL
    
    ; 2*t
    
    MOV AL, 2 
    MOV AH, 00
    MUL t
    MOV BL, AL
    
    ;v*(2*t)
    MOV AL, v 
    MOV AH, 00
    MUL BL
    MOV DL, AL
    
    PRINTN   
    
    
    MOV AH, 2
    ADD DL, 48
    INT 21H
    
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN