                                               .model small
.stack 100h
.data

    m0 dw "         !!!!!! Welcome to our Restaurant !!!!!!    $"
    m1 dw 10,13,10,13, "What would you like to order ? Please Select :$"
    m2 dw 10,13,10,13, "1.Rice 100/- 2.Vegetable 50/- 3.Soup 20/- $"
    m3 dw 10,13,10,13, "Select the menu number:  $"
    m8 dw 10,13,10,13, "SORRY!!!There are no more than 10 items.$"
     
    m4 dw 10,13,10,13, "Press <1> : Have-In  $"
    m9 dw 10,13,10,13, "Press <2> : Take-Away  $"
    m5 dw 10,13,10,13, "Enter quantity:  $" 
    m6 dw 10,13,10,13, "Total price:  $"
    m7 dw 10,13,10,13, "      *****THANK YOU*****     $"
    m10 dw 10,13,10,13, "                                                                    $"
    m13 dw 10,13,10,13, "To Re-odrer : Press <1>$",
    m14 dw 10,13,10,13, "To Exit : Press Any Other Key  $",    
    
    m11 dw 10,13,10,13, "Order is Packed ! $"
    m15 dw 10,13,10,13, "What would you prefer : Have-In OR Take-Away ? $"    
    m16 dw 10,13,10,13, "Packing Charges : 30/-$"    
    
    m51 dw 10,13,10,13, "Have a discount coupon? If yes press 1, else press 2.  $"    
    m52 dw 10,13,10,13, "You have discount coupon of : $"
    m55 dw 10,13,10,13, "                              1. 30 % $"
    m56 dw 10,13,10,13, "                              2. 50 % $"
    m57 dw 10,13,10,13, "                              3. 70 %   $"
    m53 dw 10,13,10,13, "You have been offered discount of Rupees:  $"   
    m54 dw 10,13,10,13, "Your final Price after discount is:  $"   
    
            
    r dw 0                                                     
    v db 0
    s dw 0
    rprice dw 100
    vprice dw 50
    sprice dw 20
    
    
    charges dw 30    
    count dw 0      
    
    coupond1 dw 30 
    coupond2 dw 50
    coupond3 dw 70   
    
    perc dw 100
    
.code
    main proc
        
        mov ax,@data
        mov ds,ax
        
        mov ah,9
        Lea dx,m0
        int 21h  
        
        start:
            
            mov ah,9
            Lea dx,m10
            int 21h
                
            mov ah,9
            Lea dx,m15
            int 21h
            
            mov ah,9
            Lea dx,m16
            int 21h        
                     
            mov ah,9
            Lea dx,m4
            int 21h
            
            mov ah,9
            Lea dx,m9
            int 21h
            
                     
            mov ah,1
            int 21h
            cmp al,32h
            je l4
            jmp menu 
        
        l4:  
            inc count    
        
        
        
        menu:
         
            mov ah,9
            Lea dx,m1
            int 21h
             
            mov ah,9
            Lea dx,m2
            int 21h
            
            mov ah,9
            Lea dx,m3
            int 21h
            
            mov ah,1
            int 21h        
            
            cmp al,31h
            je rice_
            cmp al,32h
            je veg_
            cmp al,33h
            je soup_
         
        
        
        invalid_choice:
        
        
            mov ah,9
            Lea dx,m8
            int 21h 
               
            mov ah,9
            Lea dx,m13
            int 21h
            
            mov ah,9
            Lea dx,m14
            int 21h
            
            mov ah,1
            int 21h
            
            cmp al,31h
            je start
            
            mov ah,9
            Lea dx,m7
            int 21h
            
            
            mov ah,4ch
            int 21h
           
        
         
        
        veg_:
        
            mov ah,9
            Lea dx,m5
            int 21h
            
            xor ax,ax            
            
            call indec
    
            mul vprice 
            
                       
            cmp count,0
            jg pack
                       
            mov bx,ax
            
            
            
            jmp totalprice          
            
            
            
            
        
        rice_:
        
            mov ah,9
            Lea dx,m5
            int 21h 
            
            xor ax,ax
            
            call indec  
            
            mul rprice
            
            cmp count,0
            jg pack 
            
            mov bx,ax
            
            jmp totalprice   
            
            
            
            
        soup_:    
            mov ah,9
            Lea dx,m5
            int 21h 
            
            xor ax,ax
            
            call indec
           
            mul sprice
            
            cmp count,0
            jg pack
            
            mov bx,ax
            
            jmp totalprice 
            
        
            
            
        totalprice:
                    
            mov ah,9
            Lea dx,m51
            int 21h 
            
            
            mov ah,1
            int 21h
            
            cmp al,31h
            je couponY
            
                
                    
            mov ah,9
            Lea dx,m6
            int 21h 
            
            xor ax,ax
           
            mov ax,bx
            
            call outdec  
            
            jmp Final
             
         
         
         couponY:
         
            mov ah,9
            Lea dx,m52
            int 21h 
            
            mov ah,9
            Lea dx,m55
            int 21h
            
            mov ah,9
            Lea dx,m56
            int 21h
            
            mov ah,9
            Lea dx,m57
            int 21h
            
            mov ah,1
            int 21h
            
            cmp al,31h
            je coupon1
            
            cmp al,32h
            je coupon2 
            
            cmp al,33h
            je coupon3
         
        
                         
                               
        coupon1:
        
            xor ax,ax
            mov ax,bx
            
            mov cx,ax
            mul coupond1
           
            div perc
            
            mov bx,ax
            
            mov ah,9
            Lea dx,m53
            int 21h
            
            xor ax,ax
            mov ax,bx
            call outdec
            
            
            mov ah,9
            Lea dx,m54 
            int 21h 
            
            mov ax,cx
            sub ax,bx
            call outdec
            
            jmp Final 
            
            
               
            
        coupon2:
        
            xor ax,ax
            mov ax,bx
            
            mov cx,ax
            mul coupond2
           
            div perc
            
            mov bx,ax
            
            mov ah,9
            Lea dx,m53
            int 21h
            
            xor ax,ax
            mov ax,bx
            call outdec
            
            
            mov ah,9
            Lea dx,m54 
            int 21h 
            
            mov ax,cx
            sub ax,bx
            call outdec
            
            jmp Final 
        
        
        coupon3:
        
            xor ax,ax
            mov ax,bx
            
            mov cx,ax
            mul coupond3
           
            div perc
            
            mov bx,ax
            
            mov ah,9
            Lea dx,m53
            int 21h
            
            xor ax,ax
            mov ax,bx
            call outdec
            
            
            mov ah,9
            Lea dx,m54 
            int 21h 
            
            mov ax,cx
            sub ax,bx
            call outdec
            
            jmp Final 
                    
                       
                     
        pack:  
        
            adc ax,1Eh
            
            
            dec count
            jnz pack
            mov bx,ax
            
            mov ah,9
            Lea dx,m11
            int 21h
            
            jmp totalprice
             
            
            
            
        Final: 
        
            mov ah,9
            Lea dx,m13
            int 21h
            
            mov ah,9
            Lea dx,m14
            int 21h
            
            mov ah,1
            int 21h
            
            cmp al,31h
            je start
            
            mov ah,9
            Lea dx,m7
            int 21h   
            
                         
        
         Exit: 
         
            mov ah,4ch
            int 21h
         
                
                
         indec:
        
            push bx
                        
            mov ah,2
            mov dl, ' '
            int 21h
            
            xor bx,bx
            
            mov ah,1
            int 21h
            
            and ax, 000fh
            push ax
            
            mov ax,10
            mul bx
            pop bx
            add bx,ax
            
            mov ah,1
            int 21h 
            
            mov ax,bx
                          
            pop bx
            ret
             
                  
        outdec:
            
             push bx
             push cx
             push dx
             
              
             xor cx,cx    
             mov bx,10
             
             
             output:
                 xor dx,dx
                 div bx
                 push dx
                 inc cx
                 or ax,ax
                 jne output
                 
             mov ah,2
             
             display:
                 pop dx
                 or dl,30h
                 int 21h
                 loop display
             
             pop dx
             pop cx
             pop bx
             
             ret    
                  
                  
        main endp
    end main
