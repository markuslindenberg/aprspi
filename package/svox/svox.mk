################################################################################
#
# svox
#
################################################################################

SVOX_VERSION = debian/1.0+git20130326-8
SVOX_SITE_METHOD = git
SVOX_SITE = https://salsa.debian.org/a11y-team/svox.git
SVOX_SUBDIR = pico
SVOX_AUTORECONF = YES
SVOX_AUTORECONF_OPTS = -I lib
SVOX_DEPENDENCIES = popt

define SVOX_APPLY_DEBIAN_PATCHES
        $(APPLY_PATCHES) $(@D) $(@D)/debian/patches $(shell cat $(@D)/debian/patches/series | grep -v '^#' | xargs echo)
endef

define SVOX_ADD_MISSING_DIRS
	mkdir $(@D)/pico/m4
endef

SVOX_POST_PATCH_HOOKS += SVOX_APPLY_DEBIAN_PATCHES
SVOX_PRE_CONFIGURE_HOOKS += SVOX_ADD_MISSING_DIRS

$(eval $(autotools-package))
