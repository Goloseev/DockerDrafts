echoBLUE "Запускаю 3_add_netfolder_to_fstab.sh"

smbuser_file_path="/root/.smbuser_for_red.conf"


VAR=$(isFile)

echo VAR=$VAR

#тест
rm $smbuser_file_path


if (( EUID != 0 )); then
	echoRED "скрипт должен запускаться под root правами"
   	return
fi

if test -f "$smbuser_file_path"; then 
    echoRED "Файл $smbuser_file_path уже существует"
    echoRED "перезапись файла невозможна"
    return
fi

echoBLUE "Создаю файл: $smbuser_file_path"
touch $smbuser_file_path

echoBLUE "скрипт завершен"



isFile(){
	#if test -f "$1"; then res=1; else res=0
	#return 134;
	echo SomeResult
	}

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
