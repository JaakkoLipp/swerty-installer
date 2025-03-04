#!/bin/sh
# automated steps to install swerty keyboard layout as detailed in instruction.txt
# USE AT OWN RISK

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root for /usr/share/X11/xkb/ access." >&2
    exit 1
fi

# Check if swerty already installed.
if grep -q "swerty" /usr/share/X11/xkb/symbols/se || grep -q "Swerty" /usr/share/X11/xkb/rules/evdev.xml; then
    echo "xkb files already contains swerty modifications!\nExiting..."
    exit 1
fi

echo "Making edits in /usr/share/X11/xkb/ folder, backups created before edits.\n"

echo "Making /usr/share/X11/xkb/symbols/se.backup"
cp /usr/share/X11/xkb/symbols/se /usr/share/X11/xkb/symbols/se.backup || {
    echo "Backup of file 1 failed." >&2
    exit 1
}

echo "Appending /swerty-linux/se.txt to ../xkb/symbols/se"
cat /swerty-linux/se.txt >> /usr/share/X11/xkb/symbols/se || {
    echo "Appending failed." >&2
    exit 1
}

echo "Making ../xkb/rules/evdev.xml.backup"
cp /usr/share/X11/xkb/rules/evdev.xml /usr/share/X11/xkb/rules/evdev.xml.backup || {
    echo "Backup of file 3 failed." >&2
    exit 1
}

echo "Adding Swerty into evdev.xml with sed"
sed -i '/<layout>/,/<\/layout>/ {
  /<name>se<\/name>/,/<variantList>/ {
    /<variantList>/a \
        <variant>\
          <configItem>\
            <name>swerty</name>\
            <description>Swerty</description>\
          </configItem>\
        </variant>
  }
}' /usr/share/X11/xkb/rules/evdev.xml

echo "Making /usr/share/X11/xkb/rules/evdev.lst.backup"
cp /usr/share/X11/xkb/rules/evdev.lst /usr/share/X11/xkb/rules/evdev.lst.backup || {
    echo "Backup of file 4 failed." >&2
    exit 1
}

echo "Adding Swerty into evdev.lst with sed"
sed -i '/^! variant$/a\
  swerty          se: Swerty' /usr/share/X11/xkb/rules/evdev.lst

echo "\nNow Swerty should show up as one of the alternative keyboard layouts for Swedish.\n"
