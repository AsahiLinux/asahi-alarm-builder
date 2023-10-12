#!/bin/sh
set -e

pacman --noconfirm -S \
    asahi-desktop-meta arch-install-scripts pacman-contrib \
    sudo zsh vim wget htop unzip strace rsync powertop git \
    man-db alsa-tools alsa-utils evtest iotop \
    networkmanager \
    xorg-server xf86-input-evdev xorg-xinput xorg-xinit xorg-xdpyinfo \
    mesa-demos mesa-utils \
    plasma-meta konsole dolphin sddm kde-applications-meta \
    pipewire pipewire-jack pavucontrol wireplumber phonon-qt5-gstreamer \
    noto-fonts noto-fonts-cjk noto-fonts-emoji \
    powerdevil plasma-nm networkmanager-qt \
    feh calamares asahi-calamares-configs \
    firefox \
    bluedevil bluez-utils pulseaudio-bluetooth bluez-tools
