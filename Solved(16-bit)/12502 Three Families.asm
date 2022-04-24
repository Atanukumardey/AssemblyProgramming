.model small

.stack 200h

.data

; problem variables
input_t dw ?  ; initial input
fa_t dw ?
fb_t dw ?
money dw ?
;;;
                            
                                            ;;;;; template variables          
                            
counter dw ?  ; for loop


isnegative dw ?

println  db 10,13,'$'

                                            ;;;;; template varibales end
     

.code  

printString proc
    mov ah, 09h
    int 21h
    ret
    ;end printString

printnewline proc 
    
    lea dx, println
    call printString
     
    ret
    ;end newline

printChar proc
    mov ah, 02h
    int 21h 
    
    ret

printSpace proc
    mov dl, 32
    call printChar
    
    ret
    ;end printSpace
    
getNum proc
    
    mov ax, 00h
    mov isnegative, ax  ; making flag 0 indecating pobxtive number
    
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
        
        ;cmp al, 08h
        ;je handlebackspace
                  
        
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
        neg ax ; making the number pobxtive   
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

	
	while_main:
    cmp cx, 00h
    jle exit
	
    call getNum
    mov  fa_t,cx

    call getNum 
    mov  fb_t,cx

    call getNum
    mov  money,cx

    mov ax, money
    mov bx, fa_t
    add bx, fb_t

    xor dx, dx 
    div bx 

    mov money, ax ;money/(a+b)

    mov ax, fa_t
    mov dx, 00h
    mul money

    mov counter,ax ;a*money/(a+b)

    mov ax, fa_t
    mov bx, fb_t

    sub ax, bx ; a-b
    mov dx, 00h
    mul money  ;(a-b)*money/(a+b)
    add ax, counter

    mov cx, ax 
    call printNum
    call printnewline

    mov cx, input_t
    dec cx
    mov input_t, cx

    jmp while_main

    exit:
    mov ah, 04ch
    int 21h
  
    main endp
end main
    
    