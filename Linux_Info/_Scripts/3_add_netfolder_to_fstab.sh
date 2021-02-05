echo "   --- Запускаю 3_add_netfolder_to_fstab.sh /n -----------------------------"
NORMAL='\033[0m'
BOLD='\033[1m'

echoRED "some text"
echoBLUE BLUE text
echoGREEN GREEN text
echo white text


echo -ne $RED red $GREEN green $NORMAL normal

smbuser_file_path="/root/.smbuser_for_red.conf"
if test -f "$smbuser_file_path"; then 
    echo "   --- Файл $smbuser_file_path уже существует"
    echo "   --- менять его не считаю допустимым - сделайте это вручную"
    allowed_file_creation=false
else
   echo "   --- Файла $smbuser_file_path пока нет"
   allowed_file_creation=true
fi

echo "   --- получил allowed_file_creation=$allowed_file_creation"

if [ "$allowed_file_creation" = true ]; then
	echo "   --- Создаю файл: $smbuser_file_path"
	touch $smbuser_file_path
fi

echo "   --- скрипт завершен"





echoRED(){
        RED='\033[0;31m'         #  ${RED}
        NORMAL='\033[0m'
	echo -e $RED"   ---"$1"---------------"$NORMAL
	}

echoBLUE(){
	BLUE='\033[0;34m'      #  ${GREEN}
        NORMAL='\033[0m'
	echo -e $BLUE"   ---"$1"---------------"$NORMAL
	}

echoGREEN(){
	GREEN='\033[0;32m'      #  ${GREEN}
	NORMAL='\033[0m'
	echo -e $GREEN"   ---"$1"---------------"$NORMAL
	}
