
    section .data
    List_1 dd 14 DUP(0)
    List_2 dd 14 DUP(0)
    probel db ' ', 0   
    ;test_lable db '*', 0
    ;len equ $-test_lable
    
    i dd 0
    j dd 1
    
    ;k dd 0 ; List
    ;q dd 0 ; Matriza
    num dd 0
    
    section .bss
    buffer resb 32
          
    section .text
    matriza dd 0,5,2,0,0
            dd 0,0,7,0,0
            dd 0,4,0,6,1
            dd 0,3,0,0,9
            dd 0,0,0,0,0
                 
                     
global _start
_start:
    mov ebp, esp; for correct debugging 
;-------------------------------------------------------
print_matriza:
    mov ebx,0
    mov ecx, 5
print_forI:
  push ecx
  mov ecx, 5
  print_forJ:
    push ecx                       
    mov edi, [matriza + ebx*4]
    
    call Print_DEC
    call Print_Probel
          
    add ebx,1
    pop ecx
    dec ecx
  JNZ print_forJ
  call Print_NEWLINE
  pop ecx
  dec ecx
JNZ print_forI
call Print_NEWLINE
;-------------------------------------------------------      
Upakovka:
mov ebx,0 ; index Matriza
mov esi,0 ; index List
mov edx,0

mov ecx, 5
forI:
push ecx

    mov edx,[i] ; i
    mov eax,0
    mov [List_1 + esi*4],eax
    add edx,1
    mov [List_2 + esi*4],edx
   
    mov [i],edx ; i
    add esi,1

          mov ecx, 5
          forJ:
            ;push ecx
        
            mov ax,[matriza + ebx*4]
            mov dx,0
            cmp ax,dx
            
            JE ravno
                    mov edx,[j] ; j           
                    mov ax,[matriza + ebx*4]   
                    mov [List_1 + esi*4],ax
                    mov [List_2 + esi*4],edx  
                    add esi,1

                    ravno:
                    add ebx,1  
                              
                    mov edx,[j] ; j
                    add edx,1
                    mov [j],edx                   

                    ;pop ecx
                    dec ecx
            JNZ forJ
              
            mov edx,1  
            mov [j],edx ; i 
             
          pop ecx
          dec ecx
    JNZ forI
;-------------------------------------------------------   
mov ecx, 14
mov esi, 0
Print_List_1:
push ecx
    mov edi, [List_1 + esi*4]
    call Print_DEC
    call Print_Probel
    add esi,1
pop ecx
dec ecx
JNZ Print_List_1
call Print_NEWLINE
;-------------------------------------------------------
mov ecx, 14
mov esi, 0
Print_List_2:
push ecx
    mov edi, [List_2 + esi*4]
    call Print_DEC
    call Print_Probel
    add esi,1
pop ecx
dec ecx
JNZ Print_List_2
call Print_NEWLINE
;pause: 
;jmp pause
        mov eax, 1              ; номер системной функции sys_exit
        xor ebx, ebx            ; код возврата - здесь 0
        int 0x80  
    
;-------------------------------------------------------
;Процедуры
;-------------------------------------------------------    
    Print_DEC:
        push eax             
        push ebx             
        push ecx      
        push edx
         
    lea eax, [edi]
    lea edi, [buffer + 31]  ;Вычитание адресов
    mov DWORD [edi], 0x0A   ;Добавление символа новой строки
    
    convert:
    dec edi
    xor edx, edx ; edx = NULL_ptr (т.е. edx = 0)
    mov ecx, 10
    div ecx
    add dl, 30h ; 30h = "0" в таблице ASCII
    mov [edi], dl
    test eax, eax ; eax - остаток
    jnz convert ; if ZF = 0 (т.е. eax не 0)

    ; Print to console
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    lea edx, [buffer +31]
    sub edx, ecx
    int 0x80
        pop edx             
        pop ecx             
        pop ebx      
        pop eax 
    ret
    
    Print_Probel:
        push eax             
        push ebx             
        push ecx      
        push edx
        
            mov eax, 4
            mov ebx, 1
            mov ecx, probel
            mov edx, 1
            int 0x80
        
        pop edx             
        pop ecx             
        pop ebx      
        pop eax  
         
        ret
        
       Print_NEWLINE:
        push eax             
        push ebx             
        push ecx      
        push edx
        
            mov dl,0
            add dl, 0x0A  ; 0x0A  = "\n" в таблице ASCII
            mov [edi], dl
            mov eax, 4
            mov ebx, 1
            mov ecx, edi 
            mov edx, 1
            int 0x80
        
        pop edx             
        pop ecx             
        pop ebx      
        pop eax  
         
        ret     