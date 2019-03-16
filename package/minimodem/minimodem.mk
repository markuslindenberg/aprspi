#############################################################
#
# minimodem
#
#############################################################

MINIMODEM_VERSION = minimodem-0.24-1
MINIMODEM_SITE = $(call github,kamalmostafa,minimodem,$(MINIMODEM_VERSION))
MINIMODEM_DEPENDENCIES = fftw-single alsa-lib pulseaudio libsndfile
MINIMODEM_AUTORECONF=YES

$(eval $(autotools-package))
