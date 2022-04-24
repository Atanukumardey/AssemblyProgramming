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
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV A, AL 
    
    PRINT " "
    
    INT 21H
    SUB AL, 48
    MOV B, AL   
    
    PRINT " "
    
    INT 21H
    SUB AL, 48
    MOV C, AL 
    
    PRINTN
    
    ;CHECK
    
    MOV BL, A
    ADD BL, B
    CMP BL, C
    JLE INV
    
    MOV BL, B
    ADD BL, C
    CMP BL, A
    JLE INV
    
    MOV BL, A
    ADD BL, C
    CMP BL, B
    JLE INV
    
    JMP EXIT_INV
    
    INV:
        PRINT "Invalid"
        JMP EXIT
        
    EXIT_INV:   
    
    MOV BL, B
    CMP A, BL
    JNE NEXT1
    
    MOV BL, C
    CMP A, BL
    JNE NEXT2
    
    PRINT "Equilateral"
    JMP EXIT
    
    NEXT2: 
        PRINT "Isosceles"
        JMP EXIT
    
    NEXT1:  
    
    MOV BL, C
    CMP B, BL
    JNE NEXT3
    
    PRINT "Isosceles"
    JMP EXIT 
    
    NEXT3:
    
    MOV BL, C
    CMP A, BL
    JNE NEXT4
    
    PRINT "Isosceles"
    JMP EXIT     
    
    NEXT4:
    
    PRINT "Scalene"
     
    EXIT:
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN