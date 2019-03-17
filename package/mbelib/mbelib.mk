#############################################################
#
# mbelib
#
#############################################################

MBELIB_VERSION = v1.3.0
MBELIB_SITE = $(call github,szechyjs,mbelib,$(MBELIB_VERSION))
MBELIB_INSTALL_STAGING = YES

$(eval $(cmake-package))
