.model small

.stack 200h

.data

; problem variables
input_t dw ?  ; initial input
input_a dw ?
;;;
                            
                                            ;;;;; template variables          
                            
counter dw ?  ; for loop


isnegative dw ?

println  db 10,13,"$" 

                                            ;;;;; template varibales end
     

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
	
	while_main:

    ;;; put code
	
    call getNum
    cmp cx, 0
    je  print_pices_num:

    cmp cx, 0
    jl exit

    mov ax, cx  ; n
    add cx, 1   ; n+1
    mul cx      ;n(n+1)
    mov cx, 2   
    div cx      ;n(n+1)/2
    add ax, 1   ;n(n+1)/2 + 1
    mov cx, ax
    ;;;

    print_pices_num:
    call printnewline
    call printNum
    call printnewline

    jmp while_main
    
    exit:
    mov ah, 04ch
    int 21h
  
    main endp
end main
    
    