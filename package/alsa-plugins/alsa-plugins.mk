#############################################################
#
# alsa-plugins
#
#############################################################

ALSA_PLUGINS_VERSION = 1.1.7
ALSA_PLUGINS_SOURCE = alsa-plugins-$(ALSA_PLUGINS_VERSION).tar.bz2
ALSA_PLUGINS_SITE = ftp://ftp.alsa-project.org/pub/plugins
ALSA_PLUGINS_DEPENDENCIES = alsa-lib pulseaudio

ALSA_PLUGINS_CONF_OPTS += --with-plugindir=/usr/lib/alsa-lib \
	--localstatedir=/var \
	--disable-oss \
	--disable-mix \
	--disable-usbstream \
	--disable-arcamav \
	--disable-jack \
	--disable-samplerate \
	--disable-libav \
	--disable-speexdsp

$(eval $(autotools-package))
