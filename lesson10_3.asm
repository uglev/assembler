﻿						;Всё, что следует за значком ";" - это комментарий.

.286						;Разрешает ассемблирование   непривилегированных   инструкций
       						;процессора 80286  (реальный  режим) и инструкций арифметического
       						;сопроцессора 80287.

.model small 					;Указываем модель.
						;Код занимает один сегмент, данные объединены в одну группу 
						;с именем DGROUP.  
						;Эту модель обычно используют для большинства программ на ассемблере

SST segment stack "stack"                       ;Начало сегмента SST, определяющего стек.
dw 10 dup(?)                                    ;Резервируем область памяти.
SST ENDS                                        ;Указываем на завершение сегмента SST.

DATAS segment USE16                          	;Начало сегмента DATAS
						;Сообщаем ассемблеру, что внутрисегментная адресация является 
						;16-ти разрядной - use16

helloworld1 db 'Hello, world!$'			;Определяем переменную helloworld1, доступную побайтно, с фразой
						;"Hello, world!". В одинарных кавычках, после знака "!" ставим
						;знак "$".

helloworld2 db 'Hello, world! (2)$'		;Определяем переменную helloworld2, доступную побайтно, с фразой
						;"Hello, world!". В одинарных кавычках, после знака "!" ставим
						;знак "$".
DATAS ends                                   	;Указываем на завершение сегмента DATAS2.

DATA2 segment USE16
newlabel:
mov ax,DATAS
mov ds,ax

mov ah,9					;Загружаем в регистр ah число 9 (указываем функцию).
mov dx,offset helloworld2			;Указываем, что за фразу мы будем выводить.
int 21h 					;Выводим фразу.

;Выходим в DOS
mov ah,4Ch					;Используем вместо int 20h
int 21h

DATA2 ends
                                                
CSEG segment USE16                              ;Начало сегмента CSEG - в котором идёт наш код программы.
						;Сообщаем ассемблеру, что внутрисегментная адресация является 
						;16-ти разрядной - use16

assume cs:CSEG, ds:DATAS, es:DATA2, ss:SST	;

begin:                                          ;Начало программы - точка входа.

mov ax,DATAS
mov ds,ax

mov ah,9					;Загружаем в регистр ah число 9 (указываем функцию).
mov dx,offset helloworld1			;Указываем, что за фразу мы будем выводить.
int 21h 					;Выводим фразу.

mov ax,DATA2
mov ds,ax


JMP FAR PTR newlabel
             
CSEG ends 					;Указываем на завершение сегмента CSEG.
end begin                                       ;Конец программы (точки входа).