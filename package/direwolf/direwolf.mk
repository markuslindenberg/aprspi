################################################################################
#
# direwolf
#
################################################################################

DIREWOLF_VERSION = 1.5
DIREWOLF_SITE = https://github.com/wb2osz/direwolf.git
DIREWOLF_SITE_METHOD = git
DIREWOLF_DEPENDENCIES = alsa-lib gpsd hamlib udev host-gen_fff

define DIREWOLF_USERS
	direwolf -1 direwolf -1 * - - dialout,gpio,pulse-access Direwolf TNC
endef

define DIREWOLF_INSTALL_CONFIG
	$(INSTALL) -D -m 0644 $(DIREWOLF_PKGDIR)/direwolf.conf \
		$(TARGET_DIR)/etc/direwolf.conf
endef

DIREWOLF_POST_INSTALL_TARGET_HOOKS += DIREWOLF_INSTALL_CONFIG

define DIREWOLF_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(DIREWOLF_PKGDIR)/direwolf.service \
		$(TARGET_DIR)/usr/lib/systemd/system/direwolf.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -sf ../../../../usr/lib/systemd/system/direwolf.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/direwolf.service
endef

$(eval $(cmake-package))
