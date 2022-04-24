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
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV B, AL
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV C, AL 
    
    PRINTN
  
    
    TRIANGLE:
    
            MOV BL, A
            ADD BL, B
            
            CMP BL, C
            JLE NO
            
       
            MOV BL, A
            ADD BL, C 
            
            CMP BL, B
            JLE NO
                
                
            MOV BL, B
            ADD BL, C
            
            CMP BL, A
            JLE NO
            
            
            PRINT "OK"
            JMP EXIT
          
          
    NO:
        PRINT "WRONG!!"
    
    EXIT:
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN