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

The main design goals are robustness and tight integration of all included components. The device can be switched off / lose power without the possibility of filesystem corruption.

* The SD card image only contains a FAT32 partition.
* The root filesystem is run from initramfs and is mounted read-only. All mutable configuration resides on the Raspberry Pi FAT32 partition (mounted on `/boot/`).
* `/var` and `/tmp` are tmpfs filesystems.

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

## Build Instructions

Please read the excellent [Buildroot user manual](https://buildroot.org/downloads/manual/manual.html) and install all requirements listed there.

```
git clone -b 2018.11.2 https://git.busybox.net/buildroot
git clone https://github.com/markuslindenberg/aprspi.git

cd buildroot
make BR2_EXTERNAL=../aprspi aprspi_raspi3-64_defconfig
make
```

This will bootstrap and compile a cross compilation toolchain and build all software including the Linux kernel from source and generate a SD card image in `output/images`.

## SSH / console access

The root password is `tester` and currently it's hardcoded 😱.

## Configuration

### Wifi

See `iwctl help` for iwctl's usage.

```
iwctl station wlan0 scan
iwctl station wlan0 get-networks
iwctl connect "some network"
```

To enable the wifi connection on bootup all `.psk` files found in `/boot` will be copied to `/var/lib/iwd` and used by iwd during startup.

```
cp /var/lib/iwd/*.psk /etc/
```

### Hamlib / rigctld

Configure rigctld's options in `/boot/rigctld.txt`:

```
OPTIONS=-m 1 -r /dev/ttyUSB0 -T 127.0.0.1
```

### Direwolf

Place direwolf's configuration in `/boot/direwolf.conf`.

## Upgrading

Replace `/boot/Image` and reboot.

## ToDo / Future

* Automated builds
* Bluetooth support
* Webinterface for configuration/monitoring/upgrading
* Other applications that use a soundcard
* Better documentation
