INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
 
N DB ? 
M DB ?
N_1 DB ? 
N_M DB ?
N_M_1 DB ?
ANS1 DB ?
ANS2 DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV M,AL   
    
    PRINT " "
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV N,AL 
    
    PRINTN 
    
    MOV BL, N
    SUB BL, 1
    MOV N_1, BL
    
    MOV BL, N
    SUB BL, M 
    MOV N_M, BL
    SUB BL, 1
    MOV N_M_1, BL  
    
    ;;
    
    MOV AL, N_1
    MOV AH, 00
    MUL N
    
    MOV BL, 2
    MOV AH, 00
    DIV BL 
    MOV ANS1, AL 
    
    ;;
    
    MOV AL, N_M_1
    MOV AH, 00
    MUL N_M
    
    MOV BL, 2
    MOV AH, 00
    DIV BL 
    MOV ANS2, AL 
    
    MOV BL, ANS1
    SUB BL, ANS2
    
    MOV DL, BL
    ADD DL, 48
    MOV AH, 2
    INT 21H
    
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN