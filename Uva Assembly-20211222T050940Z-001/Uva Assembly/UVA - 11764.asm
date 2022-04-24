INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    X DB ?
    Y DB ?
    N DB ?
    SUM DB ?
    L DB ?
    H DB ?

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
    MOV L, BL
    MOV H, BL  
    
    MOV CL, N
    MOV CH, 00
    
    LOOP1:
        MOV AH, 1
        INT 21H
        SUB AL, 48
        MOV X, AL 
        
        PRINT " "
        
        CMP CL, N
        JE NEXT  
        
        MOV BL, X
        CMP Y, BL
        JG LOW
        JL HIGH
        
        JMP NEXT
        
        LOW:
            INC L
            JMP NEXT
               
        HIGH:
            INC H
        
        
        
        NEXT:
            MOV Y, AL
            
        LOOP LOOP1  
    
    PRINTN    
        
    MOV DL, H
    ADD DL, 48
    MOV AH, 2
    INT 21H  
    
    PRINT " "
    
    MOV DL, L
    ADD DL, 48
    MOV AH, 2
    INT 21H    
      
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN