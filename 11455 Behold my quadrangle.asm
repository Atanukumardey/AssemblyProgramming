.model small

.stack 200h

.data

; problem variables
input_t dw ?  ; initial input
empty_bt dw ?
;;;
                            
                                            ;;;;; template variables          
                            
counter dw ?  ; for loop


isnegative dw ?

println  db 10,13,'$'
quadrangle db "quadrangle",10,13,'$'
rectangle db "rectangle",10,13,'$'  
square db "square",10,13,'$'
banana db "banana",10,13,'$'

                                            ;;;;; template varibales end
     
;;;; array      
inputarray dw 10 dup(0)  ;5 -> array_size+2 last: (how many byte long the array is)     for 'dw' len = num_of_ele*2   (ask question)
array_len dw 04h 
array_index dw ?
;;;;;;;;  


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
        xor ax,ax
        mov ah, 01h
        int 21h
        
        cmp al, 0Dh      ; checking carriage return
        je exit_getNum 
        
        cmp al, 20h ; checking space
        je exit_getNum
        
        ;cmp al, 08h
        ;je handlebackspace
                  
        
        ;for negative number input
        cmp al, 2Dh
        je checkNegative
        
        mov ah, 00h 
        sub ax, 30h
        
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
        mov dx, 00h
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
                 
    mov dx, 00h 
    mov bx, 0Ah
    mov ax, cx
    mov cx, 00h  
    
    ;checking negative number
    cmp ax, 00h
    jl negativeNumber
    
    cmp ax, 00h
    je print_zero 
    
    whilenum:  
        
        cmp ax,00h
        je print_printnum
        
        div bx
        
        add dx,30h
        
        push dx
        add cx, 01h 
               
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
             

bubble_sort proc 
    mov si, OFFSET inputarray
                                      
    mov cx, 00h                       ; cx as i , i=0
      
    bubble_sort_outerforloop:         ; for int i=0; i< n-1; i++
    
        mov si, OFFSET inputarray     ; input array address pointer
        
        mov bx, array_len             ; calculating n-i-1
        sub bx,cx                     ; n-i
        sub bx, 1                     ; n-i-1
        
        mov counter, bx
        mov dx, 00h                   ; dx as j , j=0
        
        bubble_sort_innerforloop:       ; for j=0; j<n-i-1; j++
           
            cmp counter, dx             ; j<n-i-1
            je exit_bubble_inner_loop
             
            mov ax, inputarray[si] 
            mov bx, inputarray[si+02h]  ; dw 2 byte 
            
            cmp ax, bx                  ; arr[j] > arr[j+1]
            jg swap_ax_bx
            
            ret_swap_ax_bx:             ; swap (arr[j], arr[j+1])
            mov inputarray[si], ax
            mov inputarray[si+02h], bx  ; dw 2 byte
            
            add si, 02h                 ; incrementing array pointer
            inc dx                      ; j++
            
            jmp bubble_sort_innerforloop
            
                                        ;inner_loop end 
            
         exit_bubble_inner_loop:
            
         inc cx                       ; i++
         cmp cx, array_len 
         je exit_bubble_sort          ; i<n-1 
         
         jmp bubble_sort_outerforloop
     
    exit_bubble_sort:
    ret       
    
    swap_ax_bx:
    xchg ax,bx
    jmp ret_swap_ax_bx
       


array_take_input proc 
    
    mov si, OFFSET inputarray 
    mov array_index, si          
    mov cx, array_len
	
    while_array_input: 
	cmp cx, 0	
	je input_end
	
    dec cx
    mov counter, cx 
    
    ;taking input in array
    mov cx, 00h	
    call getNum     
    mov si, array_index
    mov inputarray[si], cx
    
    mov dx, 08h
    call printChar
    mov cx,0
    call printNum 
    mov dx, 08h
    call printChar
    mov dx, 20h
    call printChar
    
      
    ;call printbackspace
    ;call printnewline  
	
	;2byte input
	add si, 02h  
	mov array_index, si
	
	mov cx, counter
    ;pop dx
	
	jmp while_array_input
	
	input_end: 
    
    ;taking input_b
     
     
    call printnewline
    ret

array_print_values proc 
    
    mov si, OFFSET inputarray
    mov cx, array_len
      
    while_array_number_print:
    cmp cx, 0	
	je print_end    
	
    dec cx
    mov counter, cx 

    mov cx, inputarray[si]    
	
	call printNum
	call printSpace

	add si, 02h
	
	mov cx, counter
	
	jmp while_array_number_print
	
	print_end:
    call printnewline
	ret
    



main proc
    mov ax, @data
    mov ds, ax 
    
    call getNum
    mov input_t, cx
    call printnewline

	while_main:  
        
        mov input_t, cx
        cmp cx, 00h
        je exit
        
        mov cx, 00h
        call array_take_input
        call bubble_sort 
       ; call array_print_values

        ;check if first two pair is equal

        mov cx, array_len
        dec cx
        mov ax, 00h
        mov si, OFFSET inputarray

        main_sum_for:
            mov bx, inputarray[si]
            add ax, bx
            add si, 02h
        loop main_sum_for 
        
        mov cx, inputarray[si]

        cmp ax, cx 
        jle print_banana


        mov si, OFFSET inputarray
        mov ax, inputarray[si]
        add si, 02h
        mov bx, inputarray[si] ; dw fact
        add si, 02h

        cmp ax, bx
        jne print_quadrangle

        checkrect:
        mov ax, inputarray[si] ;3rd element
        add si, 02h
        mov bx, inputarray[si] ;4th element

        cmp ax, bx 
        jne print_quadrangle

        mov si, OFFSET inputarray
        mov ax, inputarray[si]

        cmp ax,bx 
        jne print_rectangle

        mov dx, OFFSET square
        call printString

        return_main:

        mov cx, input_t
        dec cx
        mov input_t, cx

    jmp while_main

    print_rectangle:
        mov dx, OFFSET rectangle
        call printString
        jmp return_main 
        
    print_quadrangle:
        mov dx, OFFSET quadrangle
        call printString
        jmp return_main 
        
    print_banana:
        mov dx, OFFSET banana
        call printString

    exit:
        mov ah, 04ch
        int 21h
  
    main endp
end main
    
    