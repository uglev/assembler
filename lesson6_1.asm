.286
CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h 
begin:
;Всё написанное выше пока опускаем.
mov ax,5					;Устанавливаем значение регистра ax в 5.

add ax,3					;Прибавляем число 3, ax=8.
sub ax,6					;Отнимаем число 6, ax=2.
inc ax						;Прибавляем число 1, ax=3 (также inc ax занимает
						;меньше места, чем add ax,1).
dec ax						;Отнимаем число 1, ax=2 (также dec ax занимает
						;меньше места, чем sub ax,1).

int 20h						;Выходим в DOS.

;Завершение программы.
CSEG ends 					
end begin      