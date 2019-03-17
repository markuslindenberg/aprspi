#############################################################
#
# itpp
#
#############################################################

ITPP_VERSION = 4.3.1
ITPP_SITE = http://downloads.sourceforge.net/project/itpp/itpp/$(ITPP_VERSION)
ITPP_DEPENDENCIES = lapack fftw-double
ITPP_INSTALL_STAGING = YES

$(eval $(cmake-package))
