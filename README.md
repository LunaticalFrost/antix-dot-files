### For real.
I just post my dotfile from USB stick to here to not lose it.
Also for unique binary that i post here.

If you looking for optimal PC98 experience - download from Releases. For from code. 
How do you want.

Some description for files:

# DOSBox-X-PC98-x86_64 this is binary of DOSBOX-X based 2025-01-03 build with dependencies from Ubuntu 24.01

# autoset.sh
The autosetup for AntiX 19.2-4.19-smp-kernel. For RAM based system.
How to use?
For my daily driver i do next:
```bash
sudo mkdir /mnt/usb0; sudo mount /dev/sda1 /mnt/usb0; cd /mnt/usb0/Live-usb-storage/demo; ./autoset.sh
```
That is main command that i enter when i loading `toram`.

# config/i3status.conf 
This is dotfiles for i3 - example given from known Nord theme - change only variables - this be easier.
# game.sh 
Autostart for Dosbox-x if u in usb-stick.
# grub.cfg 
Personal use for Antix USB stick.
# sources.sh 
For installing .bashrc aliases and bash prompt line with command 
```bash
source .bashrc
```
