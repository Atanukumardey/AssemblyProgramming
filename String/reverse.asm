.model small
.stack 200h

data segment
    str1 db   "hello world$"
    str2 db   20 dup('$')
ends

code segment
    main proc
        start:
              mov  ax,@DATA
              mov  ds,ax  
              mov  es,ax
    
              
              LEA  SI, str1+10
              LEA  DI, str2
              STD
    
              MOV  cx,11   
                
              MOVE:
                
              MOVSB 
              ADD DI,2
              LOOP MOVE
    
              LEA  dx, str2
              mov  ah,09h
              int  21h
    
              mov  ah, 04ch
              int  21h
              endp
ends
