#############################################################
#
# ncpamixer
#
#############################################################

NCPAMIXER_VERSION = 1.3.3
NCPAMIXER_SITE = $(call github,fulhax,ncpamixer,$(NCPAMIXER_VERSION))
NCPAMIXER_SUBDIR = src
NCPAMIXER_DEPENDENCIES = ncurses pulseaudio

$(eval $(cmake-package))
