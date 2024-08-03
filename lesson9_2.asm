.286
CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h 
begin:
;Всё написанное выше пока опускаем.

jmp exit					;"Прыгаем" на метку exit, не выполняя операторы ниже.

NameProg proc 					;Начало нашей подпрограммы.

pop ax 						;Вынимаем из стека значение для ret.
mov ax,offset metka				;Подмениваем адрес возврата на адрес строки mov ah,9
push ax 					;Заносим в стек.
metka: 					 	;Метка-адрес для занесения в ax (куда прыгать). Или не
 					 	;использовать метку, а вместо строки mov ax,offset metka
 					 	;можно было написать mov ax,0107h

mov ah,9					;Загружаем в регистр ah число 9 (указываем функцию).
mov dx,offset helloworld			;Указываем, что за фразу мы будем выводить.
int 21h 					;Выводим фразу.
ret
NameProg endp					;Конец подпрограммы.

exit:  						;Метка на шаге 2.

call NameProg    				;Вызываем подпрограмму вывода, которая выводит фразу.

int 20h 					;Выходим в DOS.

helloworld db 'Hello, world!$'			;Определяем переменную helloworld, доступную побайтно, с фразой
						;"Hello, world!". В одинарных кавычках, после знака "!" ставим
						;знак "$".

;Завершение программы.
CSEG ends 					
end begin  