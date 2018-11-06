################################################################################
#
# hamlib
#
################################################################################

HAMLIB_VERSION = 3.3
HAMLIB_SITE = https://github.com/Hamlib/Hamlib.git
HAMLIB_SITE_METHOD = git
HAMLIB_DEPENDENCIES = readline libusb
HAMLIB_AUTORECONF = YES
HAMLIB_INSTALL_STAGING = YES

define HAMLIB_PRE_CONFIGURE_NODOC
        sed -i 's/ doc//g' $(@D)/Makefile.am
endef

HAMLIB_PRE_CONFIGURE_HOOKS += HAMLIB_PRE_CONFIGURE_NODOC

$(eval $(autotools-package))
