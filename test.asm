.model small
.stack 200h

data segment
    str1 db   "Enter string:$"
    str2 db   13,10,"String output is $"
    Arr  db   10 dup('$')
ends

code segment
main proc
    start:
         ; mov  ax, @DATA
          ;mov  ds, ax 
          
          mov ax, 'CD'   
          mov ax,si
          mov BYTE PTR [SI],3  
          mov ax, WORD PTR [SI]

          mov ax, 0000h
          mov bx, 0ffffh
          mov cx, 8001h
          mov dx, 0000h   
          mov cx, ds:[di]    
          
          ADD AX,CX
          ADD BX, AX
          SUB BX,1h
          INC BL
          NEG DX
          DIV CX
          TEST DX,DX

          mov  ah, 04CH
          int  21h
          endp  endp  endp
    end main 
ends

