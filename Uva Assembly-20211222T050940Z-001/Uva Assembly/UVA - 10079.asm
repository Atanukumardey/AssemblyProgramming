INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
    
    N DB ? 
    ANS1 DB ?
    ANS2 DB ?
    ANS3 DB ?
    

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV N,AL
    
    ; ((N * (N+1))/2) + 1 
    
    MOV BL, N
    ADD BL, 1
    MOV ANS1, BL
    
    MOV AL, N
    MOV AH, 00
    MUL ANS1
    MOV ANS2, AL  
    
    MOV BL, 2
    MOV AL, ANS2
    MOV AH, 00
    DIV BL
    MOV ANS3, AL  
    
    MOV BL, ANS3
    ADD BL, 1
    
    MOV DL, BL
    
    PRINTN
    
    MOV AH, 2
    ADD DL, 48
    INT 21H
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN    