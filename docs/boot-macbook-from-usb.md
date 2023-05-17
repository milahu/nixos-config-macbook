# boot macbook from usb

- download linux iso from https://nixos.org/download.html#nixos-iso
   - Download (GNOME, 64-bit Intel/AMD)
- write the iso to a usb flash drive
   - simply using `dd if=image.iso of=/dev/sdX` will not work
   - use [balena etcher](https://www.balena.io/etcher/) to create a bootable usb drive ([via](https://github.com/NixOS/nixpkgs/blob/master/nixos/doc/manual/installation/installing-usb.section.md))
   - maybe [unetbootin](https://unetbootin.github.io/) works too
- shutdown the macbook
- press and hold the `alt/option` key, start the macbook, wait for the boot menu (options: `Macintosh HD` or `EFI Boot`), choose the second option (`EFI Boot`)
   - docs: [Mac startup key combinations](https://support.apple.com/en-us/HT201255)
