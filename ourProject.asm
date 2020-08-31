.model small
.stack 100h

.data       

msg1 db "Please enter your string:$"
menu db 0AH,0DH,0AH,0DH,"-MENU-",0AH,0DH,"*****************************************",0AH,0DH,"1- Print string in reverse order.",0AH,0DH,"2- Print string in UPPERCASE characters.",0AH,0DH,"3- Print string in lowercase characters.",0AH,0DH,"4- Exit.",0AH,0DH,"*****************************************",0AH,0DH,"Please enter your choice: $" 
rev db 0ah,0dh,"reverse string: $"
up db 0ah,0dh,"STRING IN UPPERCASE: $"
low db 0ah,0dh,"string in lowercase: $"
msg2 db "Invalid choice!$"
array db 11 dup ("$")
input db ? 
newline db 0ah,0dh,"$"

.code
main proc
mov ax,@data
mov ds,ax
 
mov ah,9
lea dx,msg1
int 21h
 
 
mov cx,10
lea si,array    

string:
mov ah,1
int 21h
mov [si],al
inc si
loop string

 
while: 

mov ah,9
lea dx,menu
int 21h

mov ah,1
int 21h
mov input,al
sub input,30h


mov ah,9
lea dx,newline
int 21h 


cmp input,4
je while_end ;if user input 4 jump to exit program

cmp input,1
jne else2
;print array in reverse order 
mov ah,9
lea dx,rev
int 21h

mov cx,10
mov bx,9

print:
mov ah,2
mov dl,array+[bx]
int 21h
sub bx,1
loop print
jmp while


 
else2:
cmp input,2
jne else3
;print uppercase
mov ah,9
lea dx,up
int 21h

mov cx,10
mov bx,0

if_upper:
cmp array+[bx],41h
jnge else_upper
cmp array+[bx],05Ah
jnle else_upper
mov ah,2
mov dl,array+[bx]
int 21h
inc bx
jmp end

else_upper:
sub array+[bx],20h
mov ah,2
mov dl,array+[bx]
int 21h 
inc bx

end:
loop if_upper
jmp while


else3:
cmp input,3
jne else
;print lowercase
mov ah,9
lea dx,low
int 21h 

mov cx,10
mov bx,0

if_lower:
cmp array+[bx],61h
jnge else_lower
cmp array+[bx],07Ah
jnle else_lower
mov ah,2
mov dl,array+[bx]
int 21h
inc bx
jmp end2

else_lower:
add array+[bx],20h
mov ah,2
mov dl,array+[bx]
int 21h 
inc bx

end2:
loop if_lower
jmp while


else:
mov ah,9
lea dx,msg2
int 21h
jmp while
 

while_end:
mov ah,4ch
int 21h 
 
    
main endp
end main
