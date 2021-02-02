clear
smbuser_file_path="/root/.smbuser_for_red.conf"
if test -f "$smbuser_file_path"; then 
    echo "Файл $smbuser_file_path уже существует"
    echo "менять его не считаю допустимым - сделайте это вручную"
    allowed_file_creation=false
else
   echo "Файла $smbuser_file_path пока нет"
   allowed_file_creation=true
fi

echo "получил allowed_file_creation=$allowed_file_creation"

if [ "$allowed_file_creation" = true ]; then
	echo "Создаю файл: $smbuser_file_path"
	touch $smbuser_file_path
fi

echo finish script
