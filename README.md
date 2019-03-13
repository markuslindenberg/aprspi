#  Raspberry Pi 3 APRS Tracker/TNC based on Buildroot

This project generates a Raspberry Pi Image for the Software 
TNC / AX.25 packet modem [Direwolf](https://github.com/wb2osz/direwolf/) using the [Buildroot](https://buildroot.org/) embedded firmware toolchain.

The goal project is to create a rock solid, ready to use and easy to upgrade firmware image containing all required components for Direwolf-based applications.

## Status

**This is unpolished, unfinished work in progress, prebuild images are not yet available.** Use Buildroot to build the firmware (see instructions below).

## Hardware

You'll need:

* Raspberry Pi 3 / 3+
* USB audio interface (Signalink, cheap C-Media adapter ...) to the TRX
* Optional: USB control interface for your TRX (e.g. USB-RS232 cable)
* Optional: GPS board or USB GPS

## Design

The main design goals are robustness and tight integration of all included components. The device can be switched off / lose power without filesystem corruption.

* The SD card image only contains a FAT32 partition.
* The root filesystem is run from initramfs and will be reset after each reboot.
* All mutable configuration resides on the Raspberry Pi FAT32 partition (mounted on `/boot/`). The mount point is managed by automount and unmounted after 5 seconds of inactivity.

## Included Services

* [Direwolf](https://github.com/wb2osz/direwolf/): Software TNC
* [rigctld](https://hamlib.github.io/): Rig remote control service
* [gpsd](http://www.catb.org/gpsd/): GPS support

### Infrastructure

* [Chrony](https://chrony.tuxfamily.org/): Local timekeeping using GPS and NTP (if available)
* [OpenSSH](https://www.openssh.com/): Remote access
* [systemd-networkd](https://www.freedesktop.org/software/systemd/man/systemd.network.html): Network setup
* [iwd](https://wiki.archlinux.org/index.php/Iwd): Wifi setup
* [systemd-journald](https://www.freedesktop.org/software/systemd/man/systemd-journald.service.html): In-memory logging
* [rngd](https://www.kernel.org/doc/Documentation/hw_random.txt): Hardware RNG support
* [watchdog](https://github.com/brgl/busybox/blob/master/miscutils/watchdog.c): Support for bcm2835 wachdog
* [BlueZ 5](http://www.bluez.org/): Bluetooth stack

## Build Instructions

Please read the excellent [Buildroot user manual](https://buildroot.org/downloads/manual/manual.html) and install all requirements listed there.

```
git clone -b 2019.02 https://git.busybox.net/buildroot
git clone https://github.com/markuslindenberg/aprspi.git

cd buildroot
make BR2_EXTERNAL=../aprspi aprspi_raspberrypi3_64_defconfig
make
```

This will bootstrap and compile a cross compilation toolchain and build all software including the Linux kernel from source and generate a SD card image in `output/images`.

## SSH / console access

* The root password for console access is `aprspi` and currently it's hardcoded 😱.
* To enable SSH access put a [authorized_keys](https://manpages.debian.org/stretch/openssh-server/authorized_keys.5.en.html#AUTHORIZED_KEYS_FILE_FORMAT) file on the SD card.
  It will be used for the root account.

## Configuration

It is planned to eventually implement a web interface but for now the TNC has to be set up manually using SSH or console access.

All persistent configuration files are placed on the SD card's FAT32 filesystem and can also be copied from/to the SD card manually.

### Wifi / networking (optional)

aprspi will use DHCP to configure the ethernet and wifi interfaces.

Wifi is managed by `iwd`, See `iwctl help` for iwctl's usage.

```
iwctl station wlan0 scan
iwctl station wlan0 get-networks
iwctl connect "some network"
```

Reboot aprspi using `reboot` or use `systemctl restart iwd-restore.service` to save all known wifi networks on the SD card.

### rigctld (optional)

If `rigctld` should be used by Direwolf for PTT, place a file `rigctld.txt` on the SD card (`/boot/rigctld.txt`):

```
OPTIONS=-m 234 -r /dev/ttyUSB0 -s 9600
```

See `rigctld -h` and `rigctld -L` for help. By default rigctld is running on `127.0.0.1:4532` in dummy mode.

### ALSA / Audio levels

Use `arecord` to monitor audio level from the TRX to the TNC:

```
arecord -f s16 -r 44100 -V mono /dev/null
```

Press `Ctrl+C` to interrupt.

The audio level can be adjusted using `pactl`:

```
pactl set-source-volume @DEFAULT_SOURCE@ 16384
pactl set-sink-volume @DEFAULT_SINK@ 32768
```

Both values can be put into `volume.txt` on the SD card to automatically adjust the volume:

```
# Set audio levels for input and output between 0-65536

OUTPUT=32000
INPUT=22000
```

### Direwolf

Create a file `direwolf.conf` on the SD card.
See the [Dire Wolf User Guide](https://github.com/wb2osz/direwolf/blob/master/doc/User-Guide.pdf) on how to configure beaconing etc.

```
ADEVICE default
CHANNEL 0
#PTT /dev/ttyUSB0 RTS
#GPSD
```

The TNC can be accessed over the network on port 8000 (AGW) or 8001 (KISS).

### Bluetooth

Bluetooth is enabled, any device can pair with `aprspi` without PIN.
[APRSdroid](https://aprsdroid.org/) works using `TNC (KISS)` with `Bluetooth SPP` connection on channel 1.

Bluetooth pairings are saved in `bluetooth.tgz` on the SD card on `reboot` or by using `systemctl restart bluetooth-restore.service`.

## Upgrading

Replace the `Image` file on the SD card and reboot.

## ToDo / Future

* Automated builds
* Webinterface for configuration/monitoring/upgrading
* Other applications that use a soundcard

