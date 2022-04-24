INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    A DB ?
    B DB ?
    C DB ?
    

.CODE
                                                        
MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV A,AL
    
    PRINT " " 
    
     
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV B,AL
    
    PRINT " "
    
     
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV C,AL
    
    PRINTN 
    
    MOV AL,A
    MOV AH,00
    MUL A
    MOV A, AL 
    
     
    MOV AL,B
    MOV AH,00
    MUL B
    MOV B, AL 
    
     
    MOV AL,C
    MOV AH,00
    MUL C
    MOV C, AL 
    
    MOV BL,A
    ADD BL,B
    
    
    CMP BL,C
    JNE NO 
    PRINT "right"
    JMP EXIT
    
    NO:
        PRINT "WRONG"
    
    EXIT:
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN