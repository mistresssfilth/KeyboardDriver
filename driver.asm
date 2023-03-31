
Assume CS: Code, DS: Code
Code SEGMENT
    org 100h
last db ?
frequency1      equ     300     
number_cycles1  equ     1000   
port_b      equ     61h      
    .386
    
Start:
    mov     ax,cs
    mov     ds,ax 
notLat: mov last, 0
repeat:
    mov ah, 0
    int 16h
    mov ah, 2
    mov dl, al
    int 21h
    cmp al, 27
    je finish 
 
    cmp al, '0'
    jb  notDigit; al < '0' 
    cmp al, '9'; al <= '9'  
    jbe Digit
    cmp al, '9'
    ja notDigit

Digit:
    cmp last, 1
    jne notLat
    call ton1
    jmp notLat

notDigit:
    cmp al,'A'
    jb notLat
    cmp al,'Z'
    jbe islat
    cmp al,'a'
    jb notLat
    cmp al,'z'
    ja notLat
isLat:
    mov last, 1
    jmp repeat
finish:
    mov ax, 4C00h
    int 21h
ton1 proc near   
    mov dx,number_cycles1   
    mov di,frequency1       
   
ton01: or al,00000010b    
    out port_b,al       
    mov cx,di           
    loop $  
    and al,11111101b   
    out port_b,al       
    mov cx,di          
    loop $           
    dec dx          
    jnz ton01    
    sti         
    ret         
       
ton1 endp        
Code ends
END Start

    
    