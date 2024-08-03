.286
CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h 
begin:
;Всё написанное выше пока опускаем.
mov cx,5					;Устанавливаем значение регистра в 5.

metka:
mov ah,9					;Загружаем в регистр ah число 9 (указываем функцию).
mov dx,offset helloworld			;Указываем, что за фразу мы будем выводить.
int 21h 					;Выводим фразу.

dec cx						;Вычитаем единицу из регистра cx.
jne metka					;Если cx не равен 0, переходим на метку.

int 20h 					;Выходим в DOS.

helloworld db 'Hello, world!$'			;Определяем переменную helloworld, доступную побайтно, с фразой
						;"Hello, world!". В одинарных кавычках, после знака "!" ставим
						;знак "$".

;Завершение программы.
CSEG ends 					
end begin         