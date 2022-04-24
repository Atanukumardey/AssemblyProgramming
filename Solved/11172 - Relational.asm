.model small

.stack 100h

.data

input_t dw ?
input_a dw ?
input_b dw ?
isnegative dw ?

enx db "enter x: $"
println  db 10,13,"$"

.code  


printnewline proc 
    
    lea dx, println
    mov ah, 09h
    int 21h
     
    ret
    ;end newline
               
printSpace proc
    mov dl, 32
    mov ah, 02h
    int 21h 
    
    ret
    ;end printSpace
    
getNum proc
    
    mov ax, 00h
    mov isnegative, ax  ; making flag 0 indecating positive number
    
    mov bx, 0Ah
    mov cx, 00h 
    
    while_getnum:  
        
        ;got the value in al-> AX(ah, al)
        
        mov ah, 01h
        int 21h
        
        cmp al, 0Dh      ; checking carriage return
        je exit_getNum 
        
        cmp al, 020h ; checking space
        je exit_getNum
                  
        
        ;for negative number input
        cmp al, 02Dh
        je checkNegative
        
        mov ah, 0 
        sub ax, 030h
        
        push ax
        mov ax, cx
        
        mul bx
         
        mov cx, ax
        pop ax
        add cx,ax
             
        jmp while_getnum
          
   
        exit_getNum:  
        
        ; make negative if negative flag is true
        mov ax, isnegative 
        cmp ax, 1
        je makeNegative
        mov ax, 00h
        mov bx, 00h
        ret 
               
        checkNegative:   
        ; converting the number to negative   
        mov ax, 01h
        mov isnegative, ax ; making flag to 1 indecating negative number
        mov ax, 00h
        jmp while_getnum
        
        makeNegative:
        neg cx
        mov ax, 00h
        mov isnegative, ax
        mov ax, 00h
        jmp exit_getNum  
        
        ;returns value by cx
        ;end getNum
         
             
printNum proc 
    
    ;param cx (operates on the value of cx)
                 
    mov dx, 0 
    mov bx, 10
    mov ax, cx
    mov cx, 0  
    
    ;checking negative number
    cmp ax, 0
    jl negativeNumber
    
    cmp ax, 0
    je print_zero 
    
    whilenum:  
        
        cmp ax,0
        je print_printnum
        
        div bx
        
        add dx,48
        
        push dx
        add cx, 1 
               
        xor dx,dx
        
        jmp whilenum 
        
    print_printnum: 
    
        pop dx
        mov ah, 02h
        int 21h
        
        loop print_printnum 

        
    exit_printNum:
        ret 
        
    negativeNumber:    
        push ax
        mov dl, 02Dh 
        mov ah, 02h
        int 21h
        pop ax
        neg ax ; making the number positive   
        mov dx, 00h
        jmp whilenum
        
    print_zero:
        mov dx, 030h
        mov ah, 02h
        int 21h
        
        jmp exit_printNum
        
        
        ;returns void
        ;end printNum
    
             

main proc
    mov ax, @data
    mov ds, ax

    call getNum        
    mov input_t, cx 
    call printnewline
    
    mov cx, input_t
    
    while_main:
    dec cx
    mov input_t, cx 
    
    call getNum 
    mov input_a, cx
    call getNum
    mov input_b, cx
    
    call printnewline
    
    mov cx, input_b
    mov ax, input_a
    
    cmp ax, cx
    je printequal
    
    cmp ax, cx
    jl  printless
    
    cmp ax, cx
    jg printgreater
    
    resume:
    call printnewline 
    mov cx, input_t
    cmp cx,0
    jle exit
    
    jmp while_main
    
    
    call printnewline 
    
    mov cx,input_t
     
    call printNum
    
    exit:
    mov ah, 04ch
    int 21h
    
    printgreater:  
    mov dx, 03eh
    mov ah, 02h
    int 21h
    jmp resume
    
    printequal: 
    mov dx, 03dh
    mov ah, 02h
    int 21h   
    jmp resume
    
    printless:
    mov dx, 03ch
    mov ah, 02h
    int 21h  
    jmp resume
    
  
    main endp
end main
    
    