*
* $Id: intsch.F 220 2007-11-19 16:08:06Z rdm $
*
* $Log: intsch.F,v $
* Revision 1.1.1.1  2002/06/16 15:18:43  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:21  fca
* AliRoot sources
*
* Revision 1.1.1.1  1995/10/24 10:21:57  cernlib
* Geant
*
*
#include "geant321/pilot.h"
*CMZ :  3.21/02 29/03/94  15.41.48  by  S.Giani
*-- Author :
      SUBROUTINE INTSCH(IFSE,I,IS,NR)
C       THIS ROUTINE DETERMINES THE INTERPOLATION SCHEME
C       ACCORDING TO ENDF/B-V FORMATTED DATA FILES
      DIMENSION IFSE(*)
      DO 10 J=1,NR
         J1=3+2*(J-1)
         NPTS=IFSE(J1)
         IF(I.LE.NPTS)GO TO 20
   10 CONTINUE
   20 IS=IFSE(J1+1)
      RETURN
      END
