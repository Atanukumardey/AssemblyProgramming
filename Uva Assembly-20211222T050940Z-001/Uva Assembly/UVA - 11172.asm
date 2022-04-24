INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 
    
    a DB ?
    b DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV a,AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV b,AL
    
    PRINTN 
    
    MOV BL, b
    
    CMP a, BL     
    
    JG GREATER
    JL LOWER
    JE EQUAL 
    
     
          
    GREATER:
        MOV AH, 2
        MOV DL, 62
        INT 21H
        
        JMP EXIT
    
    LOWER:       
        MOV AH, 2
        MOV DL, 60
        INT 21H
        
        JMP EXIT
    
    EQUAL:  
        MOV AH, 2
        MOV DL, 61
        INT 21H
          
        JMP EXIT  
    
    EXIT:
    
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN    