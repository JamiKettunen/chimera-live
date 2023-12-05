#!/bin/sh
#
# Convenience script for generating different kinds of live images

# all extra arguments are passed to mklive.sh as is
#
# Copyright 2022 Daniel "q66" Kolesa
#
# License: BSD-2-Clause
#

IMAGE=
EXTRA_PKGS=

while getopts "b:p:" opt; do
    case "$opt" in
        b) IMAGE="$OPTARG";;
        p) EXTRA_PKGS="$OPTARG";;
        *) ;;
    esac
done

shift $((OPTIND - 1))

readonly BASE_PKGS="cryptsetup-scripts lvm2 zfs linux-lts-zfs-bin firmware-wifi firmware-linux-soc ${EXTRA_PKGS}"

case "$IMAGE" in
    base)
        PKGS="${BASE_PKGS}"
        ;;
    gnome)
        PKGS="${BASE_PKGS} base-desktop"
        ;;
    plasma)
        # TODO: finish something like base-desktop for KDE Plasma 6 as well
        PKGS="${BASE_PKGS} base-full pipewire mesa-dri xdg-utils desktop-file-utils networkmanager fonts-noto fonts-noto-emoji-ttf fonts-hack-ttf sddm breeze-icons plasma-desktop plasma-integration kactivitymanagerd breeze kscreen ksystemstats kirigami-addons kded systemsettings konsole xdg-desktop-portal-kde xdg-user-dirs-gtk upower xserver-xorg-input-libinput chimera-repo-contrib"
        ;;
    *)
        echo "unknown image type: $IMAGE"
        echo
        echo "supported image types: base gnome"
        exit 1
        ;;
esac

./mklive.sh -p "$PKGS" -f "$IMAGE" "$@"
