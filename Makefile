# $Header$
# this Makefile creates a SwissEph library and a swetest sample on 64-bit
# Redhat Enterprise Linux RHEL 6.

# The mode marked as 'Linux' should also work with the GNU C compiler
# gcc on other systems. 

# If you modify this makefile for another compiler, please
# let us know. We would like to add as many variations as possible.
# If you get warnings and error messages from your compiler, please
# let us know. We like to fix the source code so that it compiles
# free of warnings.
# send email to the Swiss Ephemeris mailing list.
#

CFLAGS = -g -Wall -fPIC  	# for Linux and other gcc systems
OP=$(CFLAGS)  
CC=clang -arch x86_64 -target x86_64-apple-ios-simulator -target arm64_apple-ios

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	SHAREDLIBPATH = /usr/lib
endif
ifeq ($(UNAME_S),Darwin)
	SHAREDLIBPATH = /usr/local/lib
endif

# compilation rule for general cases
.o :
	$(CC) $(OP) -o $@ $? -lm
.c.o:
	$(CC) -c $(OP) $<     

SWEOBJ = Sources/libswe/swedate.o Sources/libswe/swehouse.o Sources/libswe/swejpl.o Sources/libswe/swemmoon.o Sources/libswe/swemplan.o Sources/libswe/swepcalc.o Sources/libswe/sweph.o\
	Sources/libswe/swepdate.o Sources/libswe/swephlib.o Sources/libswe/swecl.o Sources/libswe/swehel.o

# create an archive and a dynamic link libary fro SwissEph
# a user of this library will inlcude swephexp.h  and link with -lswe

libswe.a: $(SWEOBJ)
	ar r libswe.a	$(SWEOBJ)
	cp libswe.a $(SHAREDLIBPATH)

libswe.so: $(SWEOBJ)
	$(CC) -shared -o libswe.so $(SWEOBJ)

clean:
	rm -f *.o swetest libswe* *.a
	
###
swecl.o: Sources/libswe/swejpl.h Sources/libswe/sweodef.h Sources/libswe/swephexp.h Sources/libswe/swedll.h Sources/libswe/sweph.h Sources/libswe/swephlib.h
sweclips.o: Sources/libswe/sweodef.h Sources/libswe/swephexp.h Sources/libswe/swedll.h
swedate.o: Sources/libswe/swephexp.h Sources/libswe/sweodef.h Sources/libswe/swedll.h
swehel.o: Sources/libswe/swephexp.h Sources/libswe/sweodef.h Sources/libswe/swedll.h
swehouse.o: Sources/libswe/swephexp.h Sources/libswe/sweodef.h Sources/libswe/swedll.h Sources/libswe/swephlib.h Sources/libswe/swehouse.h
swejpl.o: Sources/libswe/swephexp.h Sources/libswe/sweodef.h Sources/libswe/swedll.h Sources/libswe/sweph.h Sources/libswe/swejpl.h
swemmoon.o: Sources/libswe/swephexp.h Sources/libswe/sweodef.h Sources/libswe/swedll.h Sources/libswe/sweph.h Sources/libswe/swephlib.h
swemplan.o: Sources/libswe/swephexp.h Sources/libswe/sweodef.h Sources/libswe/swedll.h Sources/libswe/sweph.h Sources/libswe/swephlib.h Sources/libswe/swemptab.h
swepcalc.o: Sources/libswe/swepcalc.h Sources/libswe/swephexp.h Sources/libswe/sweodef.h Sources/libswe/swedll.h
sweph.o: Sources/libswe/swejpl.h Sources/libswe/sweodef.h Sources/libswe/swephexp.h Sources/libswe/swedll.h Sources/libswe/sweph.h Sources/libswe/swephlib.h
swephlib.o: Sources/libswe/swephexp.h Sources/libswe/sweodef.h Sources/libswe/swedll.h Sources/libswe/sweph.h Sources/libswe/swephlib.h
