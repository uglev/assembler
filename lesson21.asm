.286
CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h
begin:
                                             	 ;Стандартное начало com-файла.

mov ax,3D02h
mov dx,offset File_name
int 21h
mov Handle,ax
mov bx,ax                                        ;Открыли файл, сохранили bx.

mov ah,3Fh
mov dx,offset Finish
mov cx,9
int 21h 
                                           
mov Length_F,cx                                  ;Прочитали файл, в cx - его истинная длина.
mov si,dx                                        ;Перенесём dx в si для работы с циклом.

cycle:                                     	 ;Основной цикл. В si - адрес начала загруженного файла.
mov ah,byte ptr cs:[si]                     	 ;Прочтём первый байт в ah
inc ah                                     	 ;Считанное значение в ah увеличим на 1.         
mov byte ptr cs:[si],ah                     	 ;Запишем обратно.                               
inc si                                      	 ;Перейдём к следующему байту.                   
loop cycle                                  	 ;В cx - длина. Пока не обнулится cx - на метку.

mov ax,4200h
xor dx,dx
xor cx,cx
int 21h
mov ah,40h
mov dx,offset Finish
mov cx,Length_F
int 21h
mov ah,3Eh                                                             
mov bx,Handle
int 21h                                          ;Сохранили файл с начала и закрыли его.

ret                                              ;Можно выйти в DOS и так.

File_name db '111.txt',0,'!$'                    ;Текстовые переменные.
Handle dw 0
Length_F dw 0
Finish equ $
CSEG ends
end begin