#############################################################
#
# multimon-ng
#
#############################################################

MULTIMON_NG_VERSION = 1.1.7
MULTIMON_NG_SITE = $(call github,EliasOenal,multimon-ng,$(MULTIMON_NG_VERSION))
MULTIMON_NG_DEPENDENCIES = pulseaudio

$(eval $(cmake-package))
