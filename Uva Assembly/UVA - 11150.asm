INCLUDE 'EMU8086.INC'  
.MODEL SMALL
.STACK 100H
.DATA 

    N DB ?
    SUM DB ?
    QOU DB ?
    REM DB ?  
    DRINKED DB ?
    EMPTY_BOT DB ?

.CODE
                                                        
MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;cin>>n;
    ;ll drinked = n;
    ;ll empty_bot = n;
    ;while(empty_bot > 2) {
    ;    drinked += empty_bot/3;
    ;    empty_bot = (empty_bot/3 + empty_bot%3);
    ;}
    ;if(empty_bot == 2)
    ;    drinked++;
    ;
    ;cout<<drinked nl 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV N, AL    
    
    PRINTN 
    
    MOV BL, N
    MOV DRINKED, BL
    MOV EMPTY_BOT, BL
    
    LOOP1:
        CMP EMPTY_BOT, 2
        JLE EXIT_LOOP
        
        MOV AL, EMPTY_BOT
        MOV AH, 00
        MOV BL, 3
        DIV BL 
        MOV QOU, AL
        MOV REM, AH
        
        MOV BL, QOU
        ADD DRINKED, BL
        
        MOV BL, QOU
        ADD BL, REM
        MOV EMPTY_BOT, BL
        
        JMP LOOP1
        
    EXIT_LOOP:
    
    CMP EMPTY_BOT, 2
    JNE NEXT
    
    INC DRINKED
    
    NEXT:
        
        MOV DL, DRINKED
        ADD DL, 48
        MOV AH, 2
        INT 21H
    
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN