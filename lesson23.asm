CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h

begin:
mov ax,03h
int 10h         			;графический режим 80х25.
mov bl,03h          			;цвет линии.
mov cx,1
mov dx,0      				;начальные координаты точки.
 
mainloop:
mov ah,7        			;ждём символ с клавиатуры.
int  21h
 
cmp al,27       			;...это ESC?
je quit        				;да - на выход!
  
cmp al,4dh       			;сравнение со стрелкой "вправо".
je key_right     			;переход в обработчик.
jmp mainloop    			;если да, не выходим, а ждём другую клавишу.
 
draw:                                   ;рисование линии.
mov ah,09h
mov al,0C4h        			;горизонтальная линия (0B3h - вертикальная).
mov bh,00          			;страница 0 
int 10h
jmp mainloop     			;продолжаем ждать символ.
 
key_right:           			;обработчик клавиши "вправо".
inc cx           			;рисуем ещё точку
jmp draw         
 
quit:               			;обработчик клавиши ESC.
int 20h

CSEG ends
end begin