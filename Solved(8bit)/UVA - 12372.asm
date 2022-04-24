INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    L DB ?
    H DB ?
    W DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV L, AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV H, AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV W, AL
    
    PRINTN
    
    CMP L, 9
    JG BAD
    
    CMP H, 9
    JG BAD
    
    CMP W, 9
    JG BAD
    
    PRINT "GOOD"
    JMP EXIT
    
    BAD:
        PRINT "BAD"
        
    EXIT:
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN