INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    N DB ?
    HW DB ?
    LEVEL DB ?
    

.CODE
                                                        
MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;cin>>n;
    ;ll hw = 1;
    ;ll level = 0;
    ;while(hw < n) {
    ;    hw*=2;
    ;    level++;
    ;}
    ;cout<<level nl 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV N, AL    
    
    PRINTN 
    
    MOV HW, 1
    MOV LEVEL, 0
    
    LOOP1:      
        MOV BL, N
        CMP HW, BL
        JGE EXIT_LOOP
        
        MOV AL, HW
        MOV AH, 00
        MOV BL, 2
        MUL BL
        MOV HW, AL
        
        INC LEVEL
        
        JMP LOOP1
        
    EXIT_LOOP:
    
    MOV DL, LEVEL
    ADD DL, 48
    MOV AH, 2
    INT 21H
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN