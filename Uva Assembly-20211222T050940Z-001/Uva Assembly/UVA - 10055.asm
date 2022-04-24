INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
    
    H DB ?
    O DB ?      
    ANS DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 1
    INT 21H  
    SUB AL, 48
    MOV H, AL  
    
    PRINT " "
    
    INT 21H  
    SUB AL, 48
    MOV O, AL 
    
    PRINTN
    
    ; ANS = O-H 
    
    MOV BL, O
    SUB BL, H
    MOV ANS, BL
    
    MOV AH, 2
    MOV DL, ANS
    ADD DL, 48
    INT 21H
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN