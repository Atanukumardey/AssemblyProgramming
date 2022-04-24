INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    X DB ?
    Y DB ?
    N DB ?
    SUM DB ?

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
    MOV X, BL
    
    MOV BL, 1
    MOV Y, BL
    
    MOV CL, N
    MOV CH, 00
    
    LOOP1:
        MOV BL, 0
        ADD BL, X
        ADD BL, Y
   
        MOV SUM, BL   
        
        MOV BL, Y
        MOV X, BL
        
        MOV BL, SUM
        MOV Y, BL
        
        LOOP LOOP1
        
    MOV DL, SUM
    ADD DL, 48
    MOV AH, 2
    INT 21H            
    
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN