.286
CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h 
begin:
;Всё написанное выше пока опускаем.

jmp exit					;"Прыгаем" на метку exit, не выполняя операторы ниже.

NameProg proc 					;Начало нашей подпрограммы.
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