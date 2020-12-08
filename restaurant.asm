                      .model small
.stack 100h
.data

    m0 dw "         !!!!!!Welcome in our project!!!!!!$"
    m1 dw 10,13,10,13, "Which menu do you want ??please select:$"
    m2 dw 10,13,10,13, "1.Rice 100/- 2.Vegetable 50/- 3.Soup 20/- $"
    m3 dw 10,13,10,13, "Select the menu number:$"
    m8 dw 10,13,10,13, "SORRY!!!There are no more than 3 items.$"
    m9 dw 10,13,10,13, "Enter Food name:$"
    m10 dw 10,13,10,13,"          Price:$" 
    m4 dw 10,13,10,13, "Have-In : press 1 or Take-Away : press 2 $"
    m5 dw 10,13,10,13, "Enter quantity:$" 
    m6 dw 10,13,10,13, "Total price: $"
    m7 dw 10,13,10,13, "      *****THANK YOU*****$"
    m11 dw "4.$"  
    m12 dw "/-$" 
    m13 dw 10,13,10,13, " To Re-odrer : Press <1>$",
    m14 dw 10,13,10,13, " To Exit : Press Any key$",    
    
    m15 dw 10,13,10,13, "Have-In OR Take-Away ? $"    
    m16 dw 10,13,10,13, "Packing Charges : 30/-$"
    q dw 0    
    r dw 0
    v db 0
    s dw 0
    rprice dw 100
    vprice dw 50
    sprice dw 20
    nprice dw 0
    
    charges dw 30    
    count dw 0
    
    var1 db 100 dup('$')
    
.code
    main proc
        
        mov ax,@data
        mov ds,ax
        
        mov ah,9
        Lea dx,m0
        int 21h  
        
        start:
        cmp v,0
        jg start1
                
        mov ah,9
        Lea dx,m15
        int 21h
        
        mov ah,9
        Lea dx,m16
        int 21h        
                 
        mov ah,9
        Lea dx,m4
        int 21h
                 
        mov ah,1
        int 21h
        cmp al,32h
        je l4
        jmp menu 
        
        l4:  
        
        inc count    
        
        mov ah,9
        Lea dx,m0
        int 21h
        
        
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
         
        
        
        menuadd:
        inc v
        
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
            je menu
            
            mov ah,9
            Lea dx,m7
            int 21h
        
        
        mov ah,4ch
        int 21h
           
        COMMENT @
        mov ah,9
        Lea dx,m4
        int 21h
        
        mov ah,1
        int 21h
        cmp al,32h
        je menu
                
        mov ah,9
        Lea dx,m9
        int 21h
        @           
        
        mov si,offset var1
        
        l1:
        mov ah,1
        int 21h
        cmp al,13
        je print
        mov [si],al
        inc si
        jmp l1
        
        print: 
        
        call price
        
        start1:
        
        mov ah,9
        Lea dx,m2
        int 21h
        
        mov ah,9
        Lea dx,m11
        int 21h  
        
        mov dx,offset var1
        mov ah,9
        int 21h
        
        mov ah,2
        mov dl,' '
        int 21h 
        
        xor ax,ax   
        mov ax,nprice
        call outdec
        
        mov ah,9
        Lea dx,m12
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
        
        newmenu_:
        
            mov ah,9
            Lea dx,m5
            int 21h
            
            xor ax,ax            
            
            call indec
    
            mul nprice
            
            mov bx,ax
            
            jmp totalprice
         
        
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
            
            mov bx,ax
            
            jmp totalprice 
            
        soup_:    
            mov ah,9
            Lea dx,m5
            int 21h 
            
            xor ax,ax
            
            call indec
           
            mul sprice
            
            mov bx,ax
            
            jmp totalprice 
            
        price:
        
            mov ah,9
            Lea dx,m10
            int 21h  
            
            mov ax,0
             mov bx,0
              mov cx,0
               mov dx,0
            
            input:
                and ax,000Fh
                push ax
                mov ax,10
                mul bx
                mov bx,ax
                pop ax
                add bx,ax
                
                mov ah,1
                int 21h
                
                cmp al,0Dh
                jne input
                
            add nprice,bx
            ret
               
            
            
        totalprice:
         
            mov ah,9
            Lea dx,m6
            int 21h 
            
            xor ax,ax
            
            
            mov ax,bx
            
            
            call outdec  
            
            jmp Final
             
                     
                     
        pack :  
        
            
            mov bx,ax 
            xor ax,ax
            mov ah,9
            Lea dx,m0
            int 21h
             
            xor ax,ax
            mov ax,1Ah
            add bx,ax
            
            dec count
            jnz pack
            mov bx,ax
            
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
            je menu
            
            mov ah,9
            Lea dx,m7
            int 21h
        
        
        mov ah,4ch
        int 21h
         
         
    indec:
        
        PUSH BX
        
        @BEGIN:
        
        MOV AH, 2
        MOV DL, ' '
        INT 21H
        
        XOR BX, BX
        
        MOV AH, 1
        INT 21H
        
        AND AX, 000FH
        PUSH AX
        
        MOV AX,10
        MUL BX
        POP BX
        ADD BX, AX
        
        MOV AH, 1
        INT 21H 
        
        mov ax,bx
        
        @EXIT:

        
        POP BX
        

        
             
        main endp
    ;include indec.asm
    include outdec.asm
    end main                      .model small
.stack 100h
.data

    m0 dw "         !!!!!!Welcome in our project!!!!!!$"
    m1 dw 10,13,10,13, "Which menu do you want ??please select:$"
    m2 dw 10,13,10,13, "1.Rice 100/- 2.Vegetable 50/- 3.Soup 20/- $"
    m3 dw 10,13,10,13, "Select the menu number:$"
    m8 dw 10,13,10,13, "SORRY!!!There are no more than 3 items.$"
    m9 dw 10,13,10,13, "Enter Food name:$"
    m10 dw 10,13,10,13,"          Price:$" 
    m4 dw 10,13,10,13, "Have-In : press 1 or Take-Away : press 2 $"
    m5 dw 10,13,10,13, "Enter quantity:$" 
    m6 dw 10,13,10,13, "Total price: $"
    m7 dw 10,13,10,13, "      *****THANK YOU*****$"
    m11 dw "4.$"  
    m12 dw "/-$" 
    m13 dw 10,13,10,13, " To Re-odrer : Press <1>$",
    m14 dw 10,13,10,13, " To Exit : Press Any key$",    
    
    m15 dw 10,13,10,13, "Have-In OR Take-Away ? $"    
    m16 dw 10,13,10,13, "Packing Charges : 30/-$"
    q dw 0    
    r dw 0
    v db 0
    s dw 0
    rprice dw 100
    vprice dw 50
    sprice dw 20
    nprice dw 0
    
    charges dw 30    
    count dw 0
    
    var1 db 100 dup('$')
    
.code
    main proc
        
        mov ax,@data
        mov ds,ax
        
        mov ah,9
        Lea dx,m0
        int 21h  
        
        start:
        cmp v,0
        jg start1
                
        mov ah,9
        Lea dx,m15
        int 21h
        
        mov ah,9
        Lea dx,m16
        int 21h        
                 
        mov ah,9
        Lea dx,m4
        int 21h
                 
        mov ah,1
        int 21h
        cmp al,32h
        je l4
        jmp menu 
        
        l4:  
        
        inc count    
        
        mov ah,9
        Lea dx,m0
        int 21h
        
        
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
         
        
        
        menuadd:
        inc v
        
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
            je menu
            
            mov ah,9
            Lea dx,m7
            int 21h
        
        
        mov ah,4ch
        int 21h
           
        COMMENT @
        mov ah,9
        Lea dx,m4
        int 21h
        
        mov ah,1
        int 21h
        cmp al,32h
        je menu
                
        mov ah,9
        Lea dx,m9
        int 21h
        @           
        
        mov si,offset var1
        
        l1:
        mov ah,1
        int 21h
        cmp al,13
        je print
        mov [si],al
        inc si
        jmp l1
        
        print: 
        
        call price
        
        start1:
        
        mov ah,9
        Lea dx,m2
        int 21h
        
        mov ah,9
        Lea dx,m11
        int 21h  
        
        mov dx,offset var1
        mov ah,9
        int 21h
        
        mov ah,2
        mov dl,' '
        int 21h 
        
        xor ax,ax   
        mov ax,nprice
        call outdec
        
        mov ah,9
        Lea dx,m12
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
        
        newmenu_:
        
            mov ah,9
            Lea dx,m5
            int 21h
            
            xor ax,ax            
            
            call indec
    
            mul nprice
            
            mov bx,ax
            
            jmp totalprice
         
        
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
            
            mov bx,ax
            
            jmp totalprice 
            
        soup_:    
            mov ah,9
            Lea dx,m5
            int 21h 
            
            xor ax,ax
            
            call indec
           
            mul sprice
            
            mov bx,ax
            
            jmp totalprice 
            
        price:
        
            mov ah,9
            Lea dx,m10
            int 21h  
            
            mov ax,0
             mov bx,0
              mov cx,0
               mov dx,0
            
            input:
                and ax,000Fh
                push ax
                mov ax,10
                mul bx
                mov bx,ax
                pop ax
                add bx,ax
                
                mov ah,1
                int 21h
                
                cmp al,0Dh
                jne input
                
            add nprice,bx
            ret
               
            
            
        totalprice:
         
            mov ah,9
            Lea dx,m6
            int 21h 
            
            xor ax,ax
            
            
            mov ax,bx
            
            
            call outdec  
            
            jmp Final
             
                     
                     
        pack :  
        
            
            mov bx,ax 
            xor ax,ax
            mov ah,9
            Lea dx,m0
            int 21h
             
            xor ax,ax
            mov ax,1Ah
            add bx,ax
            
            dec count
            jnz pack
            mov bx,ax
            
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
            je menu
            
            mov ah,9
            Lea dx,m7
            int 21h
        
        
        mov ah,4ch
        int 21h
         
         
    indec:
        
        PUSH BX
        
        @BEGIN:
        
        MOV AH, 2
        MOV DL, ' '
        INT 21H
        
        XOR BX, BX
        
        MOV AH, 1
        INT 21H
        
        AND AX, 000FH
        PUSH AX
        
        MOV AX,10
        MUL BX
        POP BX
        ADD BX, AX
        
        MOV AH, 1
        INT 21H 
        
        mov ax,bx
        
        @EXIT:

        
        POP BX
        

        
             
        main endp
    ;include indec.asm
    include outdec.asm
    end main                      .model small
.stack 100h
.data

    m0 dw "         !!!!!!Welcome in our project!!!!!!$"
    m1 dw 10,13,10,13, "Which menu do you want ??please select:$"
    m2 dw 10,13,10,13, "1.Rice 100/- 2.Vegetable 50/- 3.Soup 20/- $"
    m3 dw 10,13,10,13, "Select the menu number:$"
    m8 dw 10,13,10,13, "SORRY!!!There are no more than 3 items.$"
    m9 dw 10,13,10,13, "Enter Food name:$"
    m10 dw 10,13,10,13,"          Price:$" 
    m4 dw 10,13,10,13, "Have-In : press 1 or Take-Away : press 2 $"
    m5 dw 10,13,10,13, "Enter quantity:$" 
    m6 dw 10,13,10,13, "Total price: $"
    m7 dw 10,13,10,13, "      *****THANK YOU*****$"
    m11 dw "4.$"  
    m12 dw "/-$" 
    m13 dw 10,13,10,13, " To Re-odrer : Press <1>$",
    m14 dw 10,13,10,13, " To Exit : Press Any key$",    
    
    m15 dw 10,13,10,13, "Have-In OR Take-Away ? $"    
    m16 dw 10,13,10,13, "Packing Charges : 30/-$"
    q dw 0    
    r dw 0
    v db 0
    s dw 0
    rprice dw 100
    vprice dw 50
    sprice dw 20
    nprice dw 0
    
    charges dw 30    
    count dw 0
    
    var1 db 100 dup('$')
    
.code
    main proc
        
        mov ax,@data
        mov ds,ax
        
        mov ah,9
        Lea dx,m0
        int 21h  
        
        start:
        cmp v,0
        jg start1
                
        mov ah,9
        Lea dx,m15
        int 21h
        
        mov ah,9
        Lea dx,m16
        int 21h        
                 
        mov ah,9
        Lea dx,m4
        int 21h
                 
        mov ah,1
        int 21h
        cmp al,32h
        je l4
        jmp menu 
        
        l4:  
        
        inc count    
        
        mov ah,9
        Lea dx,m0
        int 21h
        
        
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
         
        
        
        menuadd:
        inc v
        
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
            je menu
            
            mov ah,9
            Lea dx,m7
            int 21h
        
        
        mov ah,4ch
        int 21h
           
        COMMENT @
        mov ah,9
        Lea dx,m4
        int 21h
        
        mov ah,1
        int 21h
        cmp al,32h
        je menu
                
        mov ah,9
        Lea dx,m9
        int 21h
        @           
        
        mov si,offset var1
        
        l1:
        mov ah,1
        int 21h
        cmp al,13
        je print
        mov [si],al
        inc si
        jmp l1
        
        print: 
        
        call price
        
        start1:
        
        mov ah,9
        Lea dx,m2
        int 21h
        
        mov ah,9
        Lea dx,m11
        int 21h  
        
        mov dx,offset var1
        mov ah,9
        int 21h
        
        mov ah,2
        mov dl,' '
        int 21h 
        
        xor ax,ax   
        mov ax,nprice
        call outdec
        
        mov ah,9
        Lea dx,m12
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
        
        newmenu_:
        
            mov ah,9
            Lea dx,m5
            int 21h
            
            xor ax,ax            
            
            call indec
    
            mul nprice
            
            mov bx,ax
            
            jmp totalprice
         
        
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
            
            mov bx,ax
            
            jmp totalprice 
            
        soup_:    
            mov ah,9
            Lea dx,m5
            int 21h 
            
            xor ax,ax
            
            call indec
           
            mul sprice
            
            mov bx,ax
            
            jmp totalprice 
            
        price:
        
            mov ah,9
            Lea dx,m10
            int 21h  
            
            mov ax,0
             mov bx,0
              mov cx,0
               mov dx,0
            
            input:
                and ax,000Fh
                push ax
                mov ax,10
                mul bx
                mov bx,ax
                pop ax
                add bx,ax
                
                mov ah,1
                int 21h
                
                cmp al,0Dh
                jne input
                
            add nprice,bx
            ret
               
            
            
        totalprice:
         
            mov ah,9
            Lea dx,m6
            int 21h 
            
            xor ax,ax
            
            
            mov ax,bx
            
            
            call outdec  
            
            jmp Final
             
                     
                     
        pack :  
        
            
            mov bx,ax 
            xor ax,ax
            mov ah,9
            Lea dx,m0
            int 21h
             
            xor ax,ax
            mov ax,1Ah
            add bx,ax
            
            dec count
            jnz pack
            mov bx,ax
            
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
            je menu
            
            mov ah,9
            Lea dx,m7
            int 21h
        
        
        mov ah,4ch
        int 21h
         
         
    indec:
        
        PUSH BX
        
        @BEGIN:
        
        MOV AH, 2
        MOV DL, ' '
        INT 21H
        
        XOR BX, BX
        
        MOV AH, 1
        INT 21H
        
        AND AX, 000FH
        PUSH AX
        
        MOV AX,10
        MUL BX
        POP BX
        ADD BX, AX
        
        MOV AH, 1
        INT 21H 
        
        mov ax,bx
        
        @EXIT:

        
        POP BX
        

        
             
        main endp
    ;include indec.asm
    include outdec.asm
    end mainvvv
