################################################################################
#
# direwolf
#
################################################################################

DIREWOLF_VERSION = 1.5
DIREWOLF_SITE = https://github.com/wb2osz/direwolf.git
DIREWOLF_SITE_METHOD = git
DIREWOLF_DEPENDENCIES = alsa-lib gpsd hamlib udev host-gen_fff

$(eval $(cmake-package))