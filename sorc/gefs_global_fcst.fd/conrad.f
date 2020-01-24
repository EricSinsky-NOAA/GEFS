      SUBROUTINE CONRAD(NFILE,RCO2, L,LP1,LP1V,NBLY, NBLW
     &,           SGTMP, CO21D, CO22D, CO21D3, CO21D7
     &,           SOURCE, DSRCE)
CFPP$ NOCONCUR R
!    *******************************************************************
!    *                           C O N R A D                           *
!    *    READ CO2 TRANSMISSION DATA FROM UNIT(NFILE)FOR NEW VERTICAL  *
!    *      COORDINATE TESTS      ...                                  *
!    *    THESE ARRAYS USED TO BE IN BLOCK DATA    ...K.CAMPANA-MAR 90 *
!    *******************************************************************
!
      use machine
      implicit none
!
      integer nfile, L, LP1, LP1V, NBLY, NBLW
      real (kind=kind_rad) SGTMP(LP1,2),   CO21D(L,6), CO22D(LP1,LP1,6)
     &,                     CO21D3(LP1,6),  CO21D7(LP1,6)
     &,                     SOURCE(28,NBLY),DSRCE(28,NBLY), RCO2
!
      real (kind=kind_io4) sgtmp4(lp1,2),co21d4(l,6),co22d4(lp1,lp1,6)
     &,                   co21d34(lp1,6), co21d74(lp1,6), rco24
!
      integer i, j, kk
!
!                 CO2 DATA TABLES FOR USERS VERTICAL COORDINATE
!
!   THE FOLLOWING MODULE BLOCKS CONTAIN PRETABULATED CO2 TRANSMISSION
!       FUNCTIONS, EVALUATED USING THE METHODS OF FELS AND
!       SCHWARZKOPF (1981) AND SCHWARZKOPF AND FELS (1985),
!-----  THE 2-DIMENSIONAL ARRAYS ARE
!                    CO2 TRANSMISSION FUNCTIONS AND THEIR DERIVATIVES
!        FROM 109-LEVEL LINE-BY-LINE CALCULATIONS MADE USING THE 1982
!        MCCLATCHY TAPE (12511 LINES),CONSOLIDATED,INTERPOLATED
!        TO THE NMC MRF VERTICAL COORDINATTE,AND RE-CONSOLIDATED TO A
!        200 CM-1 BANDWIDTH. THE INTERPOLATION METHOD IS DESCRIBED IN
!        SCHWARZKOPF AND FELS (J.G.R.,1985).
!-----  THE 1-DIM ARRAYS ARE
!                  CO2 TRANSMISSION FUNCTIONS AND THEIR DERIVATIVES
!          FOR TAU(I,I+1),I=1,L,
!            WHERE THE VALUES ARE NOT OBTAINED BY QUADRATURE,BUT ARE THE
!            ACTUAL TRANSMISSIVITIES,ETC,BETWEEN A PAIR OF PRESSURES.
!          THESE USED ONLY FOR NEARBY LAYER CALCULATIONS INCLUDING QH2O.
!-----  THE WEIGHTING FUNCTION GTEMP=P(K)**0.2*(1.+P(K)/30000.)**0.8/
!         1013250.,WHERE P(K)=PRESSURE,NMC MRF(NEW)  L18 DATA LEVELS FOR
!         PSTAR=1013250.
!-----  STEMP IS US STANDARD ATMOSPHERES,1976,AT DATA PRESSURE LEVELS
!        USING NMC MRF SIGMAS,WHERE PSTAR=1013.25 MB (PTZ PROGRAM)
!====>   BEGIN HERE TO GET CONSTANTS FOR RADIATION PACKAGE
!
      REWIND NFILE
!       READ IN PRE-COMPUTED CO2 TRANSMISSION DATA....
!
      READ(NFILE) (SGTMP4(I,1),I=1,LP1)
      READ(NFILE) (SGTMP4(I,2),I=1,LP1)
      DO KK=1,6
        READ(NFILE) (CO21D4(I,KK),I=1,L)
      ENDDO
      DO KK=1,6
        READ(NFILE) ((CO22D4(I,J,KK),I=1,LP1),J=1,LP1)
      ENDDO
      DO KK=1,6
        READ(NFILE) (CO21D34(I,KK),I=1,LP1)
      ENDDO
      DO KK=1,6
        READ(NFILE) (CO21D74(I,KK),I=1,LP1)
      ENDDO
!
!  READ CO2 CONCENTRATION IN PPM (DEFAULTED IN GRADFS IF MISSING)
        READ(NFILE,END=31) RCO24
   31   CONTINUE
!
      SGTMP  = SGTMP4
      CO21D  = CO21D4
      CO22D  = CO22D4
      CO21D3 = CO21D34
      CO21D7 = CO21D74
      RCO2   = RCO24
!
      REWIND NFILE
!
!     PRINT 66,NFILE
!  66 FORMAT(1H ,'----READ CO2 TRANSMISSION FUNCTIONS FROM UNIT ',I2)
!
!......    DEFINE TABLES FOR LW RADIATION
!
      CALL LWTABLE(LP1,LP1V, SOURCE,DSRCE)
!
      RETURN
      END