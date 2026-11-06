#!/bin/sh

# ```РЕДАКТИРОВАТЬ ЭТОТ СКРИПТ ТОЛЬКО В КРАЙНЕЙ НЕОБХОДИМОСТИ!```

# Автонастройка репозиториев и удаление несуществующих репозиториев.
# В нашем случае мы ставим архивные репозитории Buster которые на флешке.
sudo rm -rf /etc/apt/sources.list.d/*
sudo cp /mnt/usb0/Live-usb-storage/demo/debian-unified.list /etc/apt/sources.list.d/

# [ Установка ВСЕГО. ]
# Это необходимо что бы репозитории подхватились.
echo Установка репозиториев и замена устаревшего ключа Debian. Подождите.
set +e
sudo apt-get update --allow-insecure-repositories >/dev/null;
set -e
# set +e и -e - это отключает ошибки в этот момент так как подхватывают-
# ся репы с debian-unified.list
# Дальше у нас установка архивного ключа репозитория и обновления репоз-
# итория, что бы бэкпорты подхватились и заработали.
sudo apt-get install debian-archive-keyring -y >/dev/null; sudo apt-get update --allow-insecure-repositories >/dev/null; 
clear; echo Готово.
sleep 2; clear;
echo Копирование Google Chrome 150.0.7871.186...

## Спешал пункт. Так как у нас на флешке есть APPIMAGE Google Chrome 150.x - мы сразу его копируем в директорию папки "Загрузки".
sudo cp /mnt/usb0/Live-usb-storage/demo/Google-Chrome-stable-150.0.7871.186-1-x86_64.AppImage /home/demo/Загрузки/;
clear; echo Готово.
sleep 2; clear; echo Идет установка... Шаг 0/3. 
# Установка терминала и назначения по умолчанию... 
# Здесь мы полностью вычищаем лису, ставим, гит, файлзиллу, неовим,
# и терминал КИТТИ - попутно добавляя exa и dfc...
# А также устанавливаем zram-tools для того что бы настроить ZRAM.

sudo apt-get install i3 --install-recommends -y >/dev/null; 
echo Шаг 1/3.
# Спросишь... А зачем i3 не идет со всеми? Потому что потянет все остальное в те же recommends.
# То есть, накачает лишнего.
# Качаем.
sudo apt-get install neofetch exa kitty dfc neovim filezilla git zram-tools -y >/dev/null; 
echo Шаг 2/3.
# Здесь ставим kitty по умолчанию терминалом в системе.
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty >/dev/null;
echo Шаг 3/3. 
# Уебываем лису и чистимся.
sudo apt-get purge --autoremove firefox* -y >/dev/null; 
sudo apt clean; clear;
echo Установка ZRAM.
# Дальше мы настраиваем алгоритм на lz4 и ставим 4GB подкачку. Если
# у вас комп мощнее - то милости прошу - меняйте.

# ПРИМЕЧАНИЕ: set +e и set -e нужны здесь если скрипт запущен повторно.
# Они ни на что не влияют но для sanity check пусть будут.
set +e
sleep 3
# Включаем ZRAM.
sudo modprobe zram;
sleep 3
# Выставляем lz4 алгоритм так как он легче для проца и 4GB (Почему? Потому что у нас появится
# ну как минимум 7 - 8ГБ ЭФФЕКТИВНОЙ ОЗУ.)
sleep 3
echo lz4 | sudo tee /sys/block/zram0/comp_algorithm >/dev/null;
sleep 3
echo 4G | sudo tee /sys/block/zram0/disksize >/dev/null;
sleep 10
clear; echo Установка приоритета.
# Устанавливаем ZRAM с приоритетом 100.
sudo mkswap /dev/zram0 >/dev/null;
sudo swapon /dev/zram0 -p 100 >/dev/null;

# Ставим Swappiness и vfs_cache pressure - Сваппинес определяет когда и на каком проценте ОЗУ все скинется на ДИСК(ОЗУ в нашем случае.)
# Если мы ставим 0 - получаем сброс только когда все забьется нахуй, а когда 100 - 180 - то сразу будет туда лететь.
# Для чего нам нужен vfs_cache_pressure? Это определение виртуальная подсистема файлов чистится. 0 - до талого не будет.
# ВФС = 100 - оно будет чистится сразу и жрать диск или (ОЗУ) нагружая проц лишней работой.
 
echo 100 | sudo tee /proc/sys/vm/swappiness; echo 0 | sudo tee /proc/sys/vm/vfs_cache_pressure
# И все...
set -e
clear

# Конец скрипта. Сделано [[Lunatic]] специально для Acer Aspire R3-131T 
echo НАКОНЕЦ ТО ГОТОВО. Установка завершена!
sleep 1
clear
exit 0


