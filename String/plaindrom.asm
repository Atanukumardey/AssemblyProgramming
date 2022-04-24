.model small
.stack 200h

data segment
    str1 db   "abbaa$"    
    msg db "NOT$"  
    MSSG db "YES$"
    str2 db   10 dup('$')
ends

code segment
    main proc
        start:
              mov  ax,@DATA
              mov  ds,ax  
              mov  es,ax
    
              
              LEA  SI, str1+3
              LEA  DI, str2
              STD
    
              MOV  cx,4  
                
              MOVE:
                
              MOVSB 
              ADD DI,2       ; process decreases DI by 1 and adding 2 to it points to next valid index
              LOOP MOVE   
              
              LEA SI,str1
              LEA DI,str2
              MOV cx,4
              
              checkplain:
              MOV DX,[SI]
              cmp DX,[DI]
              jne printwrong 
              INC SI
              INC DI
              loop checkplain  
              
              LEA DX, MSSG 
              mov  ah,09h
              int  21h
              jmp exit
              resume:
              
    
              ;LEA  dx, str2
              ;mov  ah,09h
              ;int  21h
              exit:
              mov  ah, 04ch
              int  21h    
              
              printwrong:
              LEA DX, msg 
              mov  ah,09h
              int  21h
              jmp resume 
              
              
              endp
ends
