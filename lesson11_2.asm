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


						;Данная программа будет обновлять файл
						;hello.com.

mov ax,3D02h  					;Первоначально откроем файл для чтения-записи.
mov dx,offset File_name
int 21h
jc Message_bad

mov Handle,ax 					;Если файл существует, сохраняем номер файла.
mov bx,ax

mov ah,3Fh                                      ;Чтение в память.
mov cx,19h                                      ;Определяем количество читаемых байт (напр.25 - будущая длина hello.com).
mov dx,offset Finish                            ;по адресу памяти за нашей программой.
int 21h

						;Файл в нашей памяти. Строка Hello, world находится в db
						;в смещении 109h от начала программы hello, т.е. через 9 байт
						;У нас она располагается тоже через 9 байт, но после конца (Finish equ $)
						;Определим её настоящий адрес:

add dx,9h

mov si,offset New_phrase                        ;Переносим 16 букв c адреса смещения переменной New_phrase
mov di,dx                                       ;на новый адрес dx (конец нашей програмы + 9 байт).
mov cx,16
rep movsb

mov dx,0h					;Устанавливаем указатель с начала файла +0h.
mov cx,0h                                       ;+0h мы указали потому, что будем
mov ax,4200h                                    ;перезаписывать файл hello.com с первого байта.
int 21h                                         ;

mov ah,40h                                      ;Записываем 25 символов (в т.ч.$) из смещения Finish 
mov dx,offset Finish	                        ;по адресу, указанному выше.
mov cx,25
int 21h                                         ;Смотрим отладчик - файл прочтён и строка в памяти заменилась!

Message_ok:					;Подпрограмма успешного вывода строки и выхода.
mov bx,Handle 					;Сначала сохраним файл, восстановив bx.
mov ah,3Eh                                      ;Закроем файл.
int 21h

mov ah,9					;Выводим строку.
mov dx,offset Mess_ok
int 21h
int 20h
  
Message_bad: 					;Подпрограмма вывода сообщения об ошибке и выхода.
mov ah,9
mov dx,offset Mess_bad
int 21h
int 20h               

File_name db 'hello.com',0,'!$'			;Имя файла.

Mess_ok db 'Файл обновлён. Всем спасибо.$'      ;Успешное сообщение и сообщение об ошибке (ниже).

Mess_bad db 'Файл не найден. Поместите hello.com в каталог с программой.$'

Handle dw 0FFFFh                                ;Определяем переменную (для идентификатора файла).

New_phrase db 'Goodbye, world!$'                ;Новая фраза, которая заменяет "Hello, world!".

Finish equ $					;Метка конца нашей программы!

CSEG ends
end begin