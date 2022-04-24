INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    T1 DB ?
    T2 DB ?
    F DB ?
    A DB ?
    C1 DB ?
    C2 DB ?
    C3 DB ?
    AVG DB ?

.CODE

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV T1, AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV T2, AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV F, AL
    
    PRINT " " 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV A, AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV C1, AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV C2, AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV C3, AL
    
    PRINTN
    
    MOV BL, 0
    ADD BL, C1
    ADD BL, C2
    ADD BL, C3
    
    MOV AL, BL
    MOV AH, 00
    MOV BL, 3
    DIV BL
    MOV AVG, AL
    
    MOV BL, 0
    ADD BL, T1
    ADD BL, T2
    ADD BL, F
    ADD BL, A
    ADD BL, AVG
    
    CMP BL, 90
    JGE A_
    
    CMP BL, 80
    JGE B
    
    CMP BL, 70
    JGE C
    
    CMP BL, 60
    JGE D
    
    PRINT "F"
    JMP EXIT
    
    A_:
        PRINT "A"
        JMP EXIT
        
    B:
        PRINT "B"
        JMP EXIT
        
    C:
        PRINT "C"
        JMP EXIT
    
    D:
        PRINT "D"
        JMP EXIT
    
                
    EXIT:
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN