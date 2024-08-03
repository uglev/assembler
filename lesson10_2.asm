﻿						;Всё, что следует за значком ";" - это комментарий.

.286						;Разрешает ассемблирование   непривилегированных   инструкций
       						;процессора 80286  (реальный  режим) и инструкций арифметического
       						;сопроцессора 80287.

MESSAGE1 segment USE16                          ;Начало сегмента MESSAGE1
						;Сообщаем ассемблеру, что внутрисегментная адресация является 
						;16-ти разрядной - use16

helloworld1 db 'Hello, world!$'			;Определяем переменную helloworld1, доступную побайтно, с фразой
						;"Hello, world!". В одинарных кавычках, после знака "!" ставим
						;знак "$".
MESSAGE1 ends                                   ;Указываем на завершение сегмента MESSAGE1.

MESSAGE2 segment USE16                          ;Начало сегмента MESSAGE2
						;Сообщаем ассемблеру, что внутрисегментная адресация является 
						;16-ти разрядной - use16

helloworld2 db 'Hello, world! (2)$'		;Определяем переменную helloworld2, доступную побайтно, с фразой
						;"Hello, world!". В одинарных кавычках, после знака "!" ставим
						;знак "$".
MESSAGE2 ends                                   ;Указываем на завершение сегмента MESSAGE2.
                                                
CSEG segment USE16                              ;Начало сегмента CSEG - в котором идёт наш код программы.
						;Сообщаем ассемблеру, что внутрисегментная адресация является 
						;16-ти разрядной - use16

assume cs:CSEG, ds:MESSAGE1			;Для сегментирования адресов из сегмента CSEG выбирается регистр cs,
						;а для сегментирования адресов из сегмента MESSAGE1 - ds.
;org 100h 					;Внимание! Директива org 100h не используется!!!
begin:                                          ;Начало программы - точка входа.

mov ax,MESSAGE1					;Заносим адрес первого сегмента в ds черех ax.
mov ds,ax					;

mov ah,9					;Загружаем в регистр ah число 9 (указываем функцию).
mov dx,offset helloworld1			;Указываем, что за фразу мы будем выводить.
int 21h 					;Выводим фразу.

mov ax,MESSAGE2					;Заносим адрес второго сегмента в ds черех ax.
mov ds,ax					;

mov ah,9					;Загружаем в регистр ah число 9 (указываем функцию).
mov dx,offset helloworld2			;Указываем, что за фразу мы будем выводить.
int 21h 					;Выводим фразу.

;Выходим в DOS
mov ah,4Ch					;Используем вместо int 20h
int 21h
             
CSEG ends 					;Указываем на завершение сегмента CSEG.
end begin                                       ;Конец программы (точки входа).