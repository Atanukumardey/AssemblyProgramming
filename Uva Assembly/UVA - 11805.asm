INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
 
N DB ? 
K DB ?
P DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV N,AL   
    
    PRINT " "
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV K,AL 
    
    PRINT " "
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV P,AL 
    
    PRINTN
    
    MOV BL, P
    ADD BL, K
    
    MOV AL, BL
    MOV AH, 00
    DIV N  
    
    CMP AH, 0
    JNE NEXT
    
    MOV AH, N
        
    NEXT:
    
    MOV DL, AH
    ADD DL, 48
    MOV AH, 2
    INT 21H
    
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN