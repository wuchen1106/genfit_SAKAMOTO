*
* $Id: gfinds.F 220 2007-11-19 16:08:06Z rdm $
*
* $Log: gfinds.F,v $
* Revision 1.1.1.1  2002/07/24 15:56:26  rdm
* initial import into CVS
*
* Revision 1.1.1.1  2002/06/16 15:18:41  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:21  fca
* AliRoot sources
*
* Revision 1.1.1.1  1995/10/24 10:21:41  cernlib
* Geant
*
*
#include "geant321/pilot.h"
*CMZ :  3.21/02 06/07/94  18.26.03  by  S.Giani
*FCA :          05/01/99  09:53:52  by  Federico Carminati
*               Corrected inline function to prevent loss of address
*               following conversion to real
*-- Author :
      SUBROUTINE G3FINDS
C.
C.    ******************************************************************
C.    *                                                                *
C.    *       Returns the set/volume parameters corresponding to       *
C.    *       the current space point in /GCTRAK/                      *
C.    *       and fill common /GCSETS/                                 *
C.    *                                                                *
C.    *       IHSET  user set identifier                               *
C.    *       IHDET  user detector identifier                          *
C.    *       ISET set number in JSET                                  *
C.    *       IDET   detector number in JS=LQ(JSET-ISET)               *
C.    *       IDTYPE detector type (1,2)                               *
C.    *       NUMBV  detector volume numbers (array of length NVNAME)  *
C.    *       NVNAME number of volume levels                           *
C.    *                                                                *
C.    *    ==>Called by : G3TRACK                                      *
C.    *       Author    R.Brun  *********                              *
C.    *       Modified  V.Perev                                        *
C.    *                                                                *
C.    ******************************************************************
C.
#include "geant321/gcbank.inc"
#include "geant321/gcsets.inc"
#include "geant321/gcvolu.inc"
#include "geant321/gctmed.inc"
#if defined(CERNLIB_DEBUG)
      INTEGER        LNAM(15), LNUM(15)
#endif
      JATTF(JV) = JV + NINT(Q(JV+5)) + 6
C.
C.    ------------------------------------------------------------------
C.
*
#if defined(CERNLIB_DEBUG)
      WRITE(CHMAIL,1000)NLEVEL
      CALL GMAIL (0, 0)
      DO 5 I    = 1,NLEVEL
        WRITE(CHMAIL,1001)NAMES(I),NUMBER(I),LVOLUM(I),LINDEX(I)
        CALL GMAIL (0, 0)
        WRITE(CHMAIL,1002)(GTRAN(J,I),J = 1,3),(GRMAT(J,I),J=1,10)
        CALL GMAIL (0, 0)
    5   CONTINUE
 1000 FORMAT (' DEBUG : GFINDS =',I3)
 1001 FORMAT (5(1X,A4,3I3))
 1002 FORMAT (1X,13F9.4)
      NLEV = NLEVEL
      CALL UCOPY (NAMES (1),LNAM(1),NLEV)
      CALL UCOPY (NUMBER(1),LNUM(1),NLEV)
      NLEVEL    = 0
      CALL GLVOLU (NLEV, LNAM, LNUM, IER)
      IF (IER.NE.0)             STOP
#endif
*
      IHSET = 0
      IHDET = 0
      ISET  = 0
      IDET  = 0
      IDTYPE = 0
      NVNAME = 0
*
      DO 10 NLEV = NLEVEL,1,-1
         JVO = LQ(JVOLUM-LVOLUM(NLEV))
         JAT = JATTF(JVO)
         IDET = Q(JAT+8)
         IF(IDET.NE.0) THEN
            NL = NLEV
            GO TO 15
         ENDIF
  10  CONTINUE
      GOTO 99
  15  ISET   = Q(JAT+7)
      IDTYPE = Q(JAT+9)
      IHSET  = IQ(JSET+ISET)
      JS     = LQ(JSET-ISET)
      IHDET  = IQ(JS+IDET)
      JD     = LQ(JS-IDET)
      NVNAME = IQ(JD+2)
      DO 40 I=1,NVNAME
            NAME=IQ(JD+2*I+9)
            NUMBV(I)=0
            DO 30 J=1,NLEVEL
               IF(NAMES(J).EQ.NAME)THEN
                  NUMBV(I)=NUMBER(J)
                  GO TO 40
               ENDIF
  30        CONTINUE
  40  CONTINUE
C
   99 END
