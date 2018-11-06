cmake_minimum_required (VERSION 3.1)
project (geotranz)
add_library (geotranz STATIC error_string.c mgrs.c polarst.c tranmerc.c ups.c usng.c utm.c)
target_link_libraries (geotranz m)
