# TEXLIVE_SRC must be a precompiled TEXLIVE build with dynamic libraries
TEXLIVE_SRC = $(HOME)/texlive-src
# We expect to find a precompiled static library compiled with -fpic here
LUA_DIR = $(HOME)/lua54/lua-5.4.0

INCLUDE_DIRS = $(TEXLIVE_SRC)/Work/texk $(TEXLIVE_SRC)/texk $(LUA_DIR)/src
LINK.so = $(LINK.o) -shared

override CFLAGS += -fpic -DHAVE_DECL_ISASCII=1 $(patsubst %,-I%,$(INCLUDE_DIRS))
override LDFLAGS += -Wl,-version-script=versionscript

kpse.so: lkpselib.o $(TEXLIVE_SRC)/Work/texk/kpathsea/.libs/libkpathsea.a $(LUA_DIR)/src/liblua.a

%.so:
	$(LINK.so) $^ $(LOADLIBES) $(LDLIBS) -o $@

lkpselib.o: lkpselib.c
