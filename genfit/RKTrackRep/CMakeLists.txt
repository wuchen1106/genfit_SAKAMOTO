cmake_minimum_required(VERSION 2.6)


#check for ENV variables that are needed
IF(NOT DEFINED ENV{ROOTSYS})
   MESSAGE(FATAL_ERROR "You did not set the environment variable ROOTSYS. Please check your ROOT configuration.") 
ENDIF(NOT DEFINED ENV{ROOTSYS})
#IF(NOT DEFINED ENV{GENFIT})
#   MESSAGE(FATAL_ERROR "You did not set the environment variable GENFIT.") 
#ENDIF(NOT DEFINED ENV{GENFIT})


INCLUDE_DIRECTORIES($ENV{ROOTSYS}/include  ${GENFIT}/core ${GENFIT}/RKTrackRep)


AUX_SOURCE_DIRECTORY($ENV{GENFIT}/RKTrackRep GENFIT_RK_SRCS)

SET(GENFIT_RK_HEADERS RKTrackRep.h)

set(GENFIT_RK_LINKDEF  genfitRKLinkDef.h)
set(GENFIT_RK_DICTIONARY genfitRKDict.cxx) 

FIND_PROGRAM(ROOT_CINT_EXECUTABLE
	NAMES rootcint
	PATHS $ENV{ROOTSYS}/bin
	NO_DEFAULT_PATH)

ADD_CUSTOM_COMMAND(OUTPUT ${CMAKE_BINARY_DIR}/${GENFIT_RK_DICTIONARY}
	COMMAND ${ROOT_CINT_EXECUTABLE}
      	ARGS -f ${CMAKE_BINARY_DIR}/${GENFIT_RK_DICTIONARY} -c -DHAVE_CONFIG_H  -I${GENFIT}/core -I${GENFIT}/RKTrackRep
      	${GENFIT_RK_HEADERS} ${GENFIT_RK_LINKDEF}
      	DEPENDS ${GENFIT_RK_HEADERS} ${GENFIT_RK_LINKDEF})

SET(GENFIT_RK_SRCS ${GENFIT_RK_SRCS} ${CMAKE_BINARY_DIR}/${GENFIT_RK_DICTIONARY})


################ install ###################

#add ROOT lib
Execute_process(COMMAND root-config --glibs --cflags
	OUTPUT_VARIABLE ROOT_LIBS
    	OUTPUT_STRIP_TRAILING_WHITESPACE)



ADD_LIBRARY(genfitRK SHARED ${GENFIT_RK_SRCS})
TARGET_LINK_LIBRARIES(genfitRK ${ROOT_LIBS} -L${GENFITLIBDIR} -lgenfit   -lGeom -lVMC -lEG)
INSTALL(TARGETS genfitRK DESTINATION ${GENFITLIBINSTALLDIR} )

