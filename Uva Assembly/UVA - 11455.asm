INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    A DB ?
    B DB ?
    C DB ?
    D DB ?

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
    
    PRINT " "
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV D, AL
    
    PRINTN
    
    SQUARE:  
        MOV BL, B
        CMP A, BL
        JNE RECTANGLE
        
        MOV BL, C
        CMP B, BL
        JNE RECTANGLE  
        
        MOV BL, D
        CMP C, BL
        JNE RECTANGLE
        
        PRINT "square" 
        JMP EXIT
    
    
    RECTANGLE:  
    
        STEP1:  
            MOV BL, B
            CMP A, BL
            JNE STEP2
            
            MOV BL, C
            CMP D, BL
            JNE STEP2
            
            PRINT "rectangle"
            JMP EXIT
          
        STEP2:  
            MOV BL, C
            CMP A, BL
            JNE STEP3
            
            MOV BL, D
            CMP B, BL
            JNE STEP3
            
            PRINT "rectangle"
            JMP EXIT   
        
        STEP3:  
            MOV BL, D
            CMP A, BL
            JNE QUADRANGLE
            
            MOV BL, C
            CMP B, BL
            JNE QUADRANGLE
            
            PRINT "rectangle"
            JMP EXIT  
        
    
    QUADRANGLE:
    
        STEP11:
            MOV BL, A
            ADD BL, B
            ADD BL, C
            
            CMP BL, D
            JL BANANA
            
       
            MOV BL, A
            ADD BL, C
            ADD BL, D
            
            CMP BL, B
            JL BANANA
                
                
            MOV BL, A
            ADD BL, B
            ADD BL, D
            
            CMP BL, C
            JL BANANA
            
            
            MOV BL, B
            ADD BL, C
            ADD BL, D
            
            CMP BL, A
            JL BANANA
            
            PRINT "quadrangle"
            JMP EXIT
          
          
    BANANA:
        PRINT "banana"
    
    EXIT:
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN