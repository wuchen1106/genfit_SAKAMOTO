*
* $Id: gintri.F 220 2007-11-19 16:08:06Z rdm $
*
* $Log: gintri.F,v $
* Revision 1.1.1.1  2002/06/16 15:18:42  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:21  fca
* AliRoot sources
*
* Revision 1.1.1.1  1995/10/24 10:21:48  cernlib
* Geant
*
*
#include "geant321/pilot.h"
*CMZ :  3.21/02 29/03/94  15.41.33  by  S.Giani
*-- Author :
      SUBROUTINE GINTRI
C.
C.    ******************************************************************
C.    *                                                                *
C.    *      Defines MENUs and COMMANDs                                *
C.    *       User MENUs initialisation by user routine GUINTI         *
C.    *                                                                *
C.    *    ==>Called by : GXINT                                        *
C.    *       Authors:   R.Brun      **********                        *
C.    *                  S.Giani     **********                        *
C.    *                                                                *
C.    ******************************************************************
C.
#if defined(CERNLIB_USRJMP)
#include "geant321/gcjump.inc"
#endif
#if defined(CERNLIB_USRJMP)
      EXTERNAL GUINTI
#endif
C.
C.  ---------------------------------------------------------------------
C.
#if defined(CERNLIB_USRJMP)
*
      JUINTI = JUMPAD(GUINTI)
*
#endif
      CALL GKDRAW
      CALL GKGCON
      CALL GKGEOM
      CALL GKCONT
      CALL GKRZ
      CALL GKFZ
      CALL GKDZ
      CALL GKSCAN
      CALL GKPHYS
      CALL GKLIST
      CALL GKFORT
#if !defined(CERNLIB_USRJMP)
      CALL GUINTI
#endif
#if defined(CERNLIB_USRJMP)
      CALL JUMPT0(JUINTI)
#endif
*
      END
 
 
 
