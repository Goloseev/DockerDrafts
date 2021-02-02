word="ro1ot"
if grep -q $word /etc/passwd
then echo "Файл содержит, как минимум, одно слово $word."
else echo "слово $word не найдено"
fi