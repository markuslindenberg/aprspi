################################################################################
#
# iwd
#
################################################################################

IWD_VERSION = 0.10
IWD_SITE = https://git.kernel.org/pub/scm/network/wireless/iwd.git
IWD_SITE_METHOD = git
IWD_CONF_OPTS = --enable-external-ell
IWD_DEPENDENCIES = readline ell
IWD_AUTORECONF = YES

define IWD_PRE_CONFIGURE_BOOTSTRAP
        mkdir -p $(@D)/build-aux
endef

IWD_PRE_CONFIGURE_HOOKS += IWD_PRE_CONFIGURE_BOOTSTRAP

$(eval $(autotools-package))
