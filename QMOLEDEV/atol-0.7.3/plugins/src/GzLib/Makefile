#
# Atol file manager plugin (Linux/Gtk makefile)
#
# USAGE:
# 1. type "make" to create program binary
#

# check these defines

#
# other settings
#

#DEBUG=-g
CXX=gcc
CFLAGS= -I ../
FLAGS= $(CFLAGS)

# define compile/link command line with flags
CC=$(CXX) $(DEBUG) -fPIC -O2 -MMD -pthread -Wall -D_REENTRANT
LD=$(CXX) $(DEBUG) -fPIC

#
# define default project to build
#
.PHONY: all

all: gzlib

#
# list of all objects to build (atol dependency)
#

SRCPATH=.
ZLIBSRC=./zlib

OBJS= GzLib.o ArchiveInfo.o gzip.o $(ZLIBSRC)/libz.a

# link program binary
# mark symbols with dllexport in source, or try -Wl,--export-all
gzlib: $(OBJS)
	$(LD) $(OBJS) -o GzLib.atp $(FLAGS) $(LDFLAGS) -shared -fpic --export-all --enable-auto-import

# compile individual objects
# TOFIX?: use pattern rules (how to adjust for possible multiple source directories?)

GzLib.o: $(SRCPATH)/GzLib.cpp
	$(CC) $(FLAGS) -c $(SRCPATH)/GzLib.cpp -o GzLib.o

ArchiveInfo.o: $(SRCPATH)/ArchiveInfo.cpp $(SRCPATH)/ArchiveInfo.h
	$(CC) $(FLAGS) -c $(SRCPATH)/ArchiveInfo.cpp -o ArchiveInfo.o

gzip.o: $(SRCPATH)/gzip.cpp $(SRCPATH)/gzip.h
	$(CC) $(FLAGS) -c $(SRCPATH)/gzip.cpp -o gzip.o

#
# clean up the mess
#
.PHONY : clean

clean:
	@echo cleaning up
	rm -f *.o *.d *.atp

#
# help printout
#
.PHONY : help

help:
	@echo Usage:
	@echo make           - builds application binaries
	@echo make help      - prints this help

