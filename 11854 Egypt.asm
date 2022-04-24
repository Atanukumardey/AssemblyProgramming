.model small

.stack 200h

.data

                                         ;;; problem variables

input_t dw ?  ; initial input


;;;; array      
inputarray dw 06h dup(0)  ;5 -> array_size+2 last: (how many byte long the array is)     for 'dw' len = num_of_ele*2   (ask question)
array_len dw 03h
;;;;;;;;  


                                            ;;; problem variables
                                            
                            
                                            ;;;;; template variables          

counter dw ?  ; for loop
isnegative dw ?                            

println  db 10,13,'$'
RIGHT db "right",10,13,'$'
WRONG db "wrong",10,13,'$'
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
        xor ax,ax
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
    mov cx, array_len
	
    while_array_input:
	cmp cx, 0	
	je input_end
	
    dec cx
    mov counter, cx 
    
    ;taking input in array
    mov cx, 00h	
    call getNum 
    mov inputarray[si], cx  

    mov dx, 08h
    call printChar
    mov cx,0
    call printNum 
    mov dx, 08h
    call printChar
    mov dx, 20h
    call printChar
	
	;2byte input
	add si, 02h
	
	mov cx, counter
	
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

	while_main:  
        
        mov cx, 00h
        call array_take_input
        mov si, 00h
        mov si, OFFSET inputarray

        cmp inputarray[si], 0
        jne validinput
        add si, 02h
        cmp inputarray[si], 0
        jne validinput
        add si, 02h
        cmp inputarray[si], 0
        jne validinput

        jmp exit

        validinput: 
        ;call printnewline
        call bubble_sort

        ;a^2
        mov si, OFFSET inputarray
        mov ax, inputarray[si]
        mov bx, ax
        mul bx
        mov inputarray[si], ax

        add si, 02h

        ;b^2
        mov ax, inputarray[si]
        mov bx, ax
        mul bx
        mov inputarray[si], ax

        add si, 02h

        ;c^2
        mov ax, inputarray[si]
        mov bx, ax
        mul bx
        mov inputarray[si], ax

        ;a^2+b^2
        mov si, OFFSET inputarray
        mov ax, inputarray[si]
        add si, 02h
        mov bx, inputarray[si]
        add ax,bx 


        add si, 02h
        mov cx, inputarray[si]
        cmp ax, cx
        jne wrongtriangle
        
        mov dx, OFFSET RIGHT
        call printString
        
        return_to_main:
        
    jmp while_main 
    
    
        wrongtriangle:
        mov dx, OFFSET WRONG
        call printString 
        jmp  return_to_main

    exit:
        mov ah, 04ch
        int 21h
  
    main endp
end main
    
    