*
* $Id: sigmor.F 220 2007-11-19 16:08:06Z rdm $
*
* $Log: sigmor.F,v $
* Revision 1.1.1.1  2002/06/16 15:18:43  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:21  fca
* AliRoot sources
*
* Revision 1.1.1.1  1995/10/24 10:21:54  cernlib
* Geant
*
*
#include "geant321/pilot.h"
*CMZ :  3.21/02 29/03/94  15.41.48  by  S.Giani
*-- Author :
      FUNCTION SIGMOR(EK,NMED)
C***************************************************
C    Get x-section for low energetic neutrons
C    Ek < 20 MeV (Ek is given in eV)
C  INPUT: material and neutron energy
C  OUTPUT: SIG = x-section
C
C**************************************************
C MICAP common
#include "geant321/mmicap.inc"
#include "geant321/mpoint.inc"
C
      CALL NSIGTA(EK,NMED,TSIG,D,LD(LFP32),LD(LFP33))
      SIGMOR = TSIG
      RETURN
      END
