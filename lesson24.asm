CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h

begin:
mov ax,03h
int 10h         			;графический режим 80х25.
mov bl,03h          			;цвет линии.
mov cx,1                                ;начальная длина линии.
mov dx,0      				;начальные координаты точки (dh=0, dl=0).


mov si,40                               ;начало цикла -
draw:                                   ;рисование линии.
mov ah,09h
mov al,0C4h        			;горизонтальная линия (0B3h - вертикальная).
mov bh,00          			;страница 0. 
int 10h 
inc cx                                  ;длина линии увеличивается на 1.

dec si                                  ;работа с циклом - уменьшаем на 1
cmp si,0                                ;и проверяем, отработал ли он 40 раз.
jne draw

mov ah,7        			;ждём символ с клавиатуры (пауза).
int  21h

mov cx,1

mov ah,02 				;установить положение курсора.
mov bh,00 				;cтраница 0.
mov dh,0 				;cтрока.
mov dl,40				;cтолбец.
int 10h 				;вызвать BIOS.


mov si,20
draw1:                                  ;рисование линии.
mov ah,09h
mov al,0B3h        			;вертикальная линия.
mov bh,00          			;страница 0 
int 10h 

call Down                               ;вызов подпрограммы.

dec si                                  ;работа с циклом - уменьшаем на 1 и т.д.
cmp si,0
jne draw1

mov ah,7        			;ждём символ с клавиатуры.
int  21h

mov ah,02 				;установить положение курсора.
mov bh,00 				;cтраница 0.
mov dh,20
mov dl,0				;cтолбец.
int 10h 				;вызвать BIOS.

mov si,40                               ;начало цикла -
draw2:                                  ;рисование линии.
mov ah,09h
mov al,0C4h        			;горизонтальная линия (0B3h - вертикальная).
mov bh,00          			;страница 0.              
int 10h 
inc cx                                  ;длина линии увеличивается на 1.

dec si                                  ;работа с циклом - уменьшаем на 1
cmp si,0                                ;и проверяем, отработал ли он 40 раз.
jne draw2

mov ah,7        			;ждём символ с клавиатуры (пауза).
int  21h

mov cx,1

mov ah,02 				;установить положение курсора.
mov bh,00 				;cтраница 0.
mov dh,0 				;cтрока.
mov dl,0				;cтолбец.
int 10h 				;вызвать BIOS.

mov si,20
draw3:                                  ;рисование линии.
mov ah,09h
mov al,0B3h        			;вертикальная линия.
mov bh,00          			;страница 0 
int 10h 

call Down                               ;вызов подпрограммы.

dec si                                  ;работа с циклом - уменьшаем на 1 и т.д.
cmp si,0
jne draw3

mov ah,7        			;ждём символ с клавиатуры.
int  21h
 
quit:               			;обработчик клавиши ESC.
int 20h

Down proc
mov ah,02 				;установить положение курсора
mov bh,00 				;страница 0.
inc dh                                  ;следующая строка.
int 10h 				;вызвать BIOS
ret
Down endp

CSEG ends
end begin