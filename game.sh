#!/bin/sh
sudo cp -r /mnt/usb0/Live-usb-storage/demo/'Touhou 1 - 5' ~/
sudo cp /mnt/usb0/Live-usb-storage/demo/DOSBox-X-PC98-x86_64.AppImage ~/Загрузки
cd ~/Загрузки;
nohup ./DOSBox-X-PC98-x86_64.AppImage >/dev/null 2>&1 &
