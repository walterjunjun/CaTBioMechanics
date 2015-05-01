# $Id: Makefile 3101 2008-10-16 19:34:03Z roystgnr $


# The location of the mesh library
#LIBMESH_DIR =$(HOME)/SOFTWARES/LIBRARIESIBAMR/libmesh-0.8.0/libmesh_opt
#LIBMESH_DIR =$(HOME)/SOFTWARES/LIBRARIESIBAMR/LIBMESH-0.9.3/libmesh_opt
LIBMESH_DIR=/usr/sfw/LibMesh/0.9.3/linux-opt/
# include the library options determined by configure.  This will
# set the variables INCLUDE and LIBS that we will need to build and
# link with the library.
include $(LIBMESH_DIR)/Make.common


###############################################################################
# File management.  This is where the source, header, and object files are
# defined

#
# source files
srcfiles 	:= $(wildcard *.C)

#
# object files
objects		:= $(patsubst %.C, %.$(obj-suffix), $(srcfiles))
###############################################################################



.PHONY: clean clobber distclean

###############################################################################
# Target:
#
target 	   := ./test1_implicit


all:: $(target)

# Production rules:  how to make the target - depends on library configuration
$(target): $(objects)
	@echo "Linking "$@"..."	
	@$(libmesh_LIBTOOL) --tag=CXX $(LIBTOOLFLAGS) --mode=link $(libmesh_CXX) $(libmesh_CXXFLAGS) $(objects) -o $@ $(libmesh_LIBS) $(libmesh_LDFLAGS) $(EXTERNAL_FLAGS)
#@$(libmesh_CXX) $(libmesh_CXXFLAGS) $(objects) -o $@ $(libmesh_LIBS) $(libmesh_LDFLAGS)
# Useful rules.
clean:
	@rm -f $(objects) *~

clobber:
	@$(MAKE) clean
	@rm -f $(target) out_*

distclean:
	@$(MAKE) clobber
	@rm -f *.o *.g.o *.pg.o

run: $(target)
	@echo "***************************************************************"
	@echo "* Running $(target)"
	@echo "***************************************************************"
	@echo " "
	@  $(target)
	@echo " "
	@echo "***************************************************************"
	@echo "* Done Running $(target)"
	@echo "***************************************************************"


# include the dependency list
#include .depend


#
# Dependencies
#
#.depend:
#	@$(perl) $(LIBMESH_DIR)/contrib/bin/make_dependencies.pl -I. $(foreach i, $(wildcard $(LIBMESH_DIR)/include/*), -I$(i)) "-S\$$(obj-suffix)" $(srcfiles) > .depend
#	@$(perl) -pi -e 's#    $(LIBMESH_DIR)#    \$$\(LIBMESH_DIR\)#' .depend
#	@echo "Updated .depend"

###############################################################################
