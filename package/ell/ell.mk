################################################################################
#
# ell
#
################################################################################

ELL_VERSION = 0.12
ELL_SITE = https://git.kernel.org/pub/scm/libs/ell/ell.git
ELL_SITE_METHOD = git
ELL_AUTORECONF = YES
ELL_INSTALL_STAGING = YES

define ELL_PRE_CONFIGURE_BOOTSTRAP
        mkdir -p $(@D)/build-aux
endef

ELL_PRE_CONFIGURE_HOOKS += ELL_PRE_CONFIGURE_BOOTSTRAP

$(eval $(autotools-package))
