SUBROUTINE LA_TEST_CGEGV(JOBVL, JOBVR, N, A, LDA, B, LDB, ALPHA, BETA, VL, LDVL, VR, LDVR, WORK, LWORK, RWORK, INFO)
!
!  -- LAPACK95 interface driver routine (version 1.1) --
!     UNI-C, Denmark;
!     May 5, 1999
!
!  .. Use Statements ..
   USE LA_PRECISION, ONLY: WP => SP
   USE F95_LAPACK, ONLY: LA_GEGV
!  .. Implicit Statement ..
   IMPLICIT NONE
!  .. Scalar Arguments ..
   INTEGER, INTENT(IN) :: N, LDA, LDB, LDVL, LDVR, LWORK
   INTEGER, INTENT(INOUT) :: INFO
   CHARACTER*1, INTENT(IN) :: JOBVL, JOBVR
!  .. Array Arguments ..
   COMPLEX(WP), INTENT(INOUT) :: A(1:LDA,1:N), B(1:LDB, 1:N)
   COMPLEX(WP), INTENT(OUT):: WORK(1:LWORK)
   COMPLEX(WP), INTENT(OUT) :: ALPHA(1:N), BETA(1:N), &
&    VL(1: LDVL, 1:N), VR(1: LDVR, 1:N)
   REAL(WP), INTENT(OUT) :: RWORK(1:8*N)
!  .. Parameters ..
   CHARACTER(LEN=8),  PARAMETER :: SRNAME = 'LA_GEGV '
   CHARACTER(LEN=14), PARAMETER :: SRNAMT = 'LA_TEST_CGEGV '
!  .. Common blocks ..
   INTEGER :: INFOTC
   COMMON /LINFO95/ INFOTC
!  .. Local Scalars ..
   INTEGER :: I, J, IA1, IA2, IB1, IB2, IALPHA, IBETA, IVL1, &
&    IVL2, IVR1, IVR2
   CHARACTER*1 :: IJOBVL, IJOBVR
!  .. Local Arrays ..
   LOGICAL, SAVE :: CTEST = .TRUE., ETEST = .TRUE.
   LOGICAL LSAME
!  .. Executable Statements ..
   IA1 = N; IA2 = N; IJOBVL = JOBVL; IJOBVR = JOBVR
   IB1 = N; IB2 = N; IALPHA = N; IBETA = N
   IVL1 = N; IVL2 = N; IVR1 = N; IVR2 = N
   I = INFO / 100; J = INFO - I*100
   SELECT CASE(I)
     CASE (1)
       IA2 = IA1 - 1
     CASE (2)
       IB1 = IA1 - 1
     CASE (3)
       IALPHA = IA1 - 1
     CASE (4)
       IALPHA = IA1 - 1
     CASE (5)
       IBETA  = IA1 - 1
     CASE (6)
       IVL1 = IA1 - 1
     CASE (7)
       IVR1 = IA1 - 1
     CASE(:-1,8:)
       CALL UESTOP(SRNAMT)
   END SELECT

   IF (LSAME(IJOBVL,'V')) THEN
     IF (LSAME (IJOBVR, 'V')) THEN
       CALL LA_GEGV( A(1:IA1,1:IA2), B(1:IB1, 1:IB2), ALPHA(1: IALPHA), &
&        BETA(1: IBETA), VL(1:IVL1,1:IVL2), &
&        VR(1:IVR1,1:IVR2), INFO)    
     ELSE
       CALL LA_GEGV( A(1:IA1,1:IA2), B(1:IB1, 1:IB2), ALPHA(1: IALPHA), &
&        BETA(1: IBETA), VL(1:IVL1,1:IVL2), &
&        INFO = INFO)
     END IF
   ELSE 
     IF (LSAME (IJOBVR, 'V')) THEN
       CALL LA_GEGV( A(1:IA1,1:IA2), B(1:IB1, 1:IB2), ALPHA(1: IALPHA), &
&        BETA(1: IBETA),&
&        VR = VR(1:IVR1,1:IVR2), INFO = INFO)
     ELSE
       CALL LA_GEGV( A(1:IA1,1:IA2), B(1:IB1, 1:IB2), ALPHA(1: IALPHA), &
&        BETA(1: IBETA), &
&        INFO = INFO)
     END IF
   END IF
   CALL LA_AUX_AA01( I, CTEST, ETEST, SRNAMT )
 END SUBROUTINE LA_TEST_CGEGV
      
      
