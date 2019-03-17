#############################################################
#
# dsd
#
#############################################################

DSD_VERSION = f175834e45a1a190171dff4597165b27d6b0157b
DSD_SITE = $(call github,szechyjs,dsd,$(DSD_VERSION))
DSD_DEPENDENCIES = mbelib libsndfile itpp portaudio

$(eval $(cmake-package))
