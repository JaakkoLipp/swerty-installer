#!/bin/sh
# Uninstaller for Swerty Keyboard Layout modifications.
# USE AT OWN RISK

set -eu
trap 'echo "An error occurred on line $LINENO. Exiting." >&2' ERR

# Ensure the script is run as root.
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root for /usr/share/X11/xkb/ access." >&2
    exit 1
fi

printf "Restoring backup files in /usr/share/X11/xkb/ folder...\n"

# Restore the symbols file.
if [ -f /usr/share/X11/xkb/symbols/se.backup ]; then
    cp /usr/share/X11/xkb/symbols/se.backup /usr/share/X11/xkb/symbols/se || {
        echo "Failed to restore /usr/share/X11/xkb/symbols/se" >&2
        exit 1
    }
    echo "Restored /usr/share/X11/xkb/symbols/se from backup."
else
    echo "Backup /usr/share/X11/xkb/symbols/se.backup not found, skipping."
fi

# Restore the evdev.xml file.
if [ -f /usr/share/X11/xkb/rules/evdev.xml.backup ]; then
    cp /usr/share/X11/xkb/rules/evdev.xml.backup /usr/share/X11/xkb/rules/evdev.xml || {
        echo "Failed to restore /usr/share/X11/xkb/rules/evdev.xml" >&2
        exit 1
    }
    echo "Restored /usr/share/X11/xkb/rules/evdev.xml from backup."
else
    echo "Backup /usr/share/X11/xkb/rules/evdev.xml.backup not found, skipping."
fi

# Restore the evdev.lst file.
if [ -f /usr/share/X11/xkb/rules/evdev.lst.backup ]; then
    cp /usr/share/X11/xkb/rules/evdev.lst.backup /usr/share/X11/xkb/rules/evdev.lst || {
        echo "Failed to restore /usr/share/X11/xkb/rules/evdev.lst" >&2
        exit 1
    }
    echo "Restored /usr/share/X11/xkb/rules/evdev.lst from backup."
else
    echo "Backup /usr/share/X11/xkb/rules/evdev.lst.backup not found, skipping."
fi

printf "\nUninstallation complete. Swerty modifications have been removed.\n"
