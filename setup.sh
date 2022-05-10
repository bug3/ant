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
