#!/bin/sh

# ```РЕДАКТИРОВАТЬ ЭТОТ СКРИПТ ТОЛЬКО В КРАЙНЕЙ НЕОБХОДИМОСТИ!```

# Автонастройка репозиториев и удаление несуществующих репозиториев.
# В нашем случае мы ставим архивные репозитории Buster которые на флешке.
sudo rm -rf /etc/apt/sources.list.d/*
sudo cp /mnt/usb0/Live-usb-storage/demo/debian-unified.list /etc/apt/sources.list.d/

# [ Установка ВСЕГО. ]
# Это необходимо что бы репозитории подхватились.
set +e
sudo apt update --allow-insecure-repositories;
set -e
# set +e и -e - это отключает ошибки в этот момент так как подхватывают-
# ся репы с debian-unified.list
# Дальше у нас установка архивного ключа репозитория и обновления репоз-
# итория, что бы бэкпорты подхватились и заработали.
sudo apt install debian-archive-keyring -y; sudo apt update --allow-insecure-repositories; 

## Спешал пункт. Так как у нас на флешке есть APPIMAGE Google Chrome 150.x - мы сразу его копируем в директорию папки "Загрузки".
sudo cp /mnt/usb0/Live-usb-storage/demo/Google-Chrome-stable-150.0.7871.186-1-x86_64.AppImage /home/demo/Загрузки/;

# Установка терминала и назначения по умолчанию... 
# Здесь мы полностью вычищаем лису, ставим, гит, файлзиллу, неовим,
# и терминал КИТТИ.
# А также устанавливаем zram-tools для того что бы настроить ZRAM.
sudo apt install i3 --install-recommends -y; 
sudo apt install neofetch exa kitty dfc neovim filezilla git zram-tools -y; 
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty;
sudo apt purge --autoremove firefox* -y; 
sudo apt clean; clear;

# Дальше мы настраиваем алгоритм на lz4 и ставим 4GB подкачку. Если
# у вас комп мощнее - то милости прошу - меняйте.

# ПРИМЕЧАНИЕ: set +e и set -e нужны здесь если скрипт запущен повторно.
# Они ни на что не влияют но для sanity check пусть будут.
set +e
sudo modprobe zram;
echo lz4 | sudo tee /sys/block/zram0/comp_algorithm;
echo 4G | sudo tee /sys/block/zram0/disksize;
sudo mkswap /dev/zram0;
sudo swapon /dev/zram0 -p 100;
echo 100 | sudo tee /proc/sys/vm/swappiness; echo 0 | sudo tee /proc/sys/vm/vfs_cache_pressure
set -e
clear

# Конец скрипта. Сделано [[Lunatic]] специально для Acer Aspire R3-131T 
echo НАКОНЕЦ ТО ГОТОВО. Установка завершена!
echo -e Теперь точно все.
sleep 1
exit 0


