################################################################################
#
# iwd
#
################################################################################

IWD_VERSION = 0.13
IWD_SITE = https://git.kernel.org/pub/scm/network/wireless/iwd.git
IWD_SITE_METHOD = git
IWD_DEPENDENCIES = readline
IWD_AUTORECONF = YES

define IWD_PRE_CONFIGURE_ELL
	rm -rf $(@D)/../ell
	git clone -b 0.16 https://git.kernel.org/pub/scm/libs/ell/ell.git $(@D)/../ell
endef

define IWD_PRE_CONFIGURE_BOOTSTRAP
        mkdir -p $(@D)/build-aux
endef

define IWD_PRE_BUILD_GENERATE_ELL
	make -C $(@D) ell/internal ell/ell.h
endef

IWD_PRE_CONFIGURE_HOOKS += IWD_PRE_CONFIGURE_ELL IWD_PRE_CONFIGURE_BOOTSTRAP
IWD_PRE_BUILD_HOOKS += IWD_PRE_BUILD_GENERATE_ELL

$(eval $(autotools-package))
