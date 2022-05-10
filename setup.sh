#!/bin/bash

grub="/etc/default/grub"
grubThemes="/usr/share/grub/themes"
theme="ANT"

function createGrub() {
    if [[ ! -d $grubThemes/$theme ]]; then
        sudo mkdir $grubThemes/$theme

        sudo cp $grub $grub.bak
        sudo cp -r $(pwd) $grubThemes
    fi
}

function editGrub() {
    sudo sed -i '/GRUB_TIMEOUT_STYLE=/d' $grub
    sudo sed -i '/GRUB_TIMEOUT=/d' $grub
    sudo sed -i '/GRUB_THEME=/d' $grub

    sudo bash -c "echo 'GRUB_TIMEOUT_STYLE="menu"' >> $grub"
    sudo bash -c "echo 'GRUB_TIMEOUT="6"' >> $grub"
    sudo bash -c "echo "GRUB_THEME=\"$grubThemes/$theme/theme.txt\"" >> $grub"
}
