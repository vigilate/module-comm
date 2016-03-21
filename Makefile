PYTHON ?= python3

PYARGON_DIR = PyArgon2
LIB_ARGON2 = libargon2.so
INSTALL_DIR = /usr/lib

ARGON_DIR = Argon2/Source/C99/
ARGON_BUILD_DIR = Argon2/Build

all:
	git submodule init && git submodule update
	make -C $(ARGON_DIR)
	cp $(ARGON_BUILD_DIR)/$(LIB_ARGON2) $(PYARGON_DIR)/$(LIB_ARGON2)
	cd $(PYARGON_DIR) && $(PYTHON) ./setup.py build

install:
	cd $(PYARGON_DIR) && $(PYTHON) ./setup.py install
	cp $(ARGON_BUILD_DIR)/$(LIB_ARGON2) $(INSTALL_DIR)/$(LIB_ARGON2)

clean:
	make -C $(ARGON_DIR) clean
	cd $(PYARGON_DIR) && $(PYTHON) ./setup.py clean
