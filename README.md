## Swerty Keyboard Layout Installer for Linux

![layout](https://johanegustafsson.net/projects/swerty/images/swerty-linux.svg)

A linux shell script which installs the swerty keyboard layout by johanegustafsson
Layout creator credit and more information on swerty: [johanegustafsson.net](https://johanegustafsson.net/projects/swerty/)

The script creates backups of the original configuration files in `/usr/share/X11/xkb/` and then applies the necessary changes.

### Disclaimer

**USE AT OWN RISK.** This script modifies system configuration files and should be used only after confirming that you have proper backups. Always review the script and test it in a safe environment before deploying on production systems.
Tested to be working on Ubuntu 24.10.

### Prerequisites

- Linux system compatible with X11.
- Root privileges (the script checks for root and exits if not run as root).
- POSIX-compliant shell (e.g., `/bin/sh`).
- The custom file `/swerty-linux/se.txt` containing your Swerty layout modifications.

### Installation

1. Clone or download this repository.
2. Ensure your custom `se.txt` file is available at `/swerty-linux/se.txt` (or modify the script to point to its correct location).

### Usage

Make the script executable:

```sh
chmod +x install-swerty.sh
```

Run the script as root:

```sh
sudo ./install_swerty.sh
```

Uninstall swerty (restores backups):

```sh
chmod +x uninstall-swerty.sh && sudo ./uninstall_swerty.sh
```

---

The install script will:
- Check for root privileges.
- Verify that the necessary files exist.
- Create backups of the following files:
  - `/usr/share/X11/xkb/symbols/se`
  - `/usr/share/X11/xkb/rules/evdev.xml`
  - `/usr/share/X11/xkb/rules/evdev.lst`
- Append the modifications from `/swerty-linux/se.txt` to the symbols file.
- Insert the new variant block into `evdev.xml`.
- Append the corresponding line into `evdev.lst`.
- Check if the modifications are already present before applying any changes.
