﻿ADD AX,BX 	;Прибавляет BX к AX. Существует также инструкция вычи-
		;тания (SUB), а также варианты обеих этих инструкций.
		;
MUL BL 		; Умножает BL на AX. Имеется также инструкция деления
		; (DIV), а также варианты обеих этих инструкций.
		;
INC BL 		; Увеличивает BL на 1. Имеется также инструкция умень-
		; шения (DEC).
		;
LOOP XXX 	;Возвращает программу назад к строке помеченной XXX,
		; повторяя процесс столько раз, какое число содержится
		; в CX (аналогично инструкции FOR .. TO .. NEXT в Бей-
		; сике).
		;
OR AL,BL 	;Выполняет операцию логического ИЛИ над содержимым
		; регистров AL и BL, причем результат помещается в AL.
		; Имеются также инструкции AND, XOR и NOT.
		;
SHL AX,1 	; Сдвигает все биты, содержащиеся в AX, на одну позицию
		; влево. Это эквивалентно умножению содержимого AX на
		; 2. Другие инструкции сдвигают биты вправо или осу-
		; ществляют циклический сдвиг. Все эти инструкции очень
		; полезны для битовых операций, таких как установка
		; точек экрана.
IN AL,DX	; Помещает в AX байт, обнаруженный в порте, адрес кото-
		; рого указан в DX. Имеется также инструкция OUT.
		;
JMP		; Передает управление в другое место программы, как
		; инструкция GOTO в Бейсике. JMP YYY передает управле-
		; ние на строку программы, имеющую метку YYY.
	
CMP AL,BL	; Сравнивает содержимое AL и BL. За инструкцией CMP
		; обычно следует инструкция условного перехода. Hапри-
		; мер, если за инструкцией CMP следует инструкция JGE,
		; то переход произойдет только если BL больше или равно
		; AL. Инструкция CMP достигает того же результата, что
		; и инструкция IF .. THEN в Бейсике (на самом деле
		; инструкция IF .. THEN переводится интерпретатором
		; Бейсика в инструкцию CMP).
	
TEST AL,BL 	; Проверяет есть ли среди битов, установленных в BL,
		; такие, которые установлены также и в AL. За этой
		; инструкцией обычно следует команда условного перехо-
		; да, так же как за CMP. TEST очень полезен при провер-
		; ке статусных битов (битовые операции очень просто
		; реализуются в языке ассемблера).
	
MOVS 		; Пересылает строку, длина которой содержится в CX, с
		; места, на которое указывает SI, на место, на которое
		; указывает DI. Имеется еще несколько других инструк-
		; ций, связанных с пересылкой и поиском строк.