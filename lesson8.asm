﻿.286
CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h 
begin:
;Всё написанное выше пока опускаем.

mov ax,3D02h					;Загружаем в регистр ah число 3Dh (функция открытия
						;файла с записью), а в al число 02h (пишем в конец).
						;Можно было записать и так - mov ah,3Dh
						;mov al,02h
mov dx,offset File_name				;Указываем имя файла в смещении по адресу File_name.
int 21h						;Выполняем функцию.

mov Handle,ax					;При открытии файлу будет присвоен номер, его и
						;сохраняем для дальнейших действий,
mov bx,ax					;а заодно и сохраняем его в bx.

mov ax,4202h					;Используем функцию установки указателя.
						;al=02h - устанавливаем в конец.
mov cx,0                                        ;Нам надо записать прямо в конец файла, поэтому
mov dx,0                                        ;обнулим cx и dx (иначе будет писать далее на
                                                ;значение (CX * 65536) + DX)
int 21h						;Выполняем функцию.

mov ah,40h					;Используем функцию записи в файл.
mov dx,offset one				;В dx занесём адрес смещения к записываемому
						;тексту.
mov cx,1					;Число записываемых байт - 1.
int 21h                                         ;Выполняем функцию.

mov ah,3Eh                                      ;Используем функцию закрытия файла.
mov bx,Handle                                   ;Для закрытия обязательно "вспоминаем" его номер,
						;номер у нас был сохранён в Handle.
int 21h                                         ;Выполняем функцию.

mov ah,9					;Загружаем в регистр ah число 9 (указываем функцию).
mov dx,offset All_ok				;Указываем, что за фразу мы будем выводить.
int 21h 					;Выводим фразу.


int 20h 					;Выходим в DOS.

File_name db '1.txt',0,'!$'			;Определяем переменную File_name (доступную побайтно),
						;с именем файла. Путь к файлу не указан, это значит,
						;что файл находится в текущем каталоге.
Handle dw 0					;Определяем переменную Handle, которую используем для
						;хранения номера файла. Первоначально она будет равна 0.

one db '1'					;Определяем переменную one, содержащую символ "1",
						;которую мы будем приписывать в конец файла.

All_ok db 'Успешно!$'				;Определяем переменную Vse_ok, доступную побайтно, с фразой
						;"Успешно!". В одинарных кавычках, после знака "!" ставим
						;знак "$".

;Завершение программы.
CSEG ends 					
end begin         