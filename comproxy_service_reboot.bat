rem принцип действия: мы запрашиваем статус службы, пишем в файл log.txt

chcp 1251>nul
echo %date% & echo %time% > D:\log.txt  
set LOG=D:\log.txt 

rem добавил новую переменную %tmp% - и перестал удалять %log% - туда заносится необходимая инфа для поиска проблемы

echo %date% & echo %time% > D:\temp.txt
set tmp=D:\temp.txt
set service=Comproxy


sc query %service% >> %tmp%


rem после чего делаем проверку на определенное знеачение - в нашем случае STOPPED

findstr "STOPPED" d:\temp.txt > d:\buffer.txt
set output=d:\buffer.txt

rem результат проверки отправляем в переменную 

set /p SCSTP= < %output%

rem проверяем - если в результате пусто - удаляем файлы	
	
	IF "%SCSTP%"=="" (
		echo %date% & echo %time% & echo "Comproxy running after" >> %LOG%
		del /Q %output% 
		del /Q %tmp%
		break

rem если что то есть - запускаем службы и удаляем buffer.txt 
		
		) ELSE (	
			sc start %service%
			echo %date% & echo %time% & echo "comproxy forced running , " >> %LOG%
			del /Q %output%
			del /Q %tmp%
		)
break