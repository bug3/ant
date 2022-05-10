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

function updateGrub() {
    if [[ -x "$(command -v update-grub)" ]]; then
        sudo update-grub
    elif [[ -x "$(command -v grub-mkconfig)" ]]; then
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    elif [[ -x "$(command -v grub2-mkconfig)" ]]; then
        if [[ -x "$(command -v zypper)" ]]; then
            sudo grub2-mkconfig -o /boot/grub2/grub.cfg
        elif [[ -x "$(command -v dnf)" ]]; then
            sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}
