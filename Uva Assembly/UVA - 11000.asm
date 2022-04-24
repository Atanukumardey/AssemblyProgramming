INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
    
    N DB ?
    M DB ?
    T DB ?
    MP DB ?
  
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
    MOV M, BL
    MOV BL, 1
    MOV T, BL
    
    MOV CL, N
    MOV CH, 00
    
    LOOP1:
        
        MOV BL, M
        MOV MP, BL
        
        MOV BL, T
        MOV M, BL
        
        MOV BL, 0
        ADD BL, M
        ADD BL, MP  
        ADD BL, 1
        MOV T, BL 
        
        LOOP LOOP1
        
    MOV DL, M
    ADD DL, 48
    MOV AH, 2
    INT 21H
    
    PRINT " "
    
    MOV DL, T
    ADD DL, 48
    MOV AH, 2
    INT 21H
        
    EXIT:
    
        MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN