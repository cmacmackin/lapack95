SUBROUTINE LA_TEST_DSBGVD( JOBZ, UPLO, N, KAB, KBB, AB, LDAB, BB, LDBB, W, Z, LDZ, WORK, LWORK, IWORK, LIWORK, INFO )
!
!  -- LAPACK95 interface driver routine (version 1.1) --
!     UNI-C, Denmark;
!     August 11, 1999
!
!  .. Use Statements ..
      USE LA_PRECISION, ONLY: WP => DP
      USE F95_LAPACK, ONLY: LA_SBGVD
!  .. Implicit Statement ..
      IMPLICIT NONE
!  .. Scalar Arguments ..
      INTEGER, INTENT(IN) :: N, KAB, KBB, LDAB, LDBB, LDZ, LWORK, LIWORK
      INTEGER, INTENT(INOUT) :: INFO
      CHARACTER*1, INTENT(IN) :: JOBZ, UPLO
!  .. Array Arguments ..
      INTEGER, INTENT(OUT) :: IWORK(1: LIWORK)
      REAL(WP), INTENT(INOUT) :: AB(1:LDAB, 1:N), BB( 1:LDBB, 1:N)
      REAL(WP), INTENT(OUT)::  W(1:N), WORK(1: LWORK), Z(1:LDZ, 1:N)
!  .. Parameters ..
      CHARACTER(LEN=8),  PARAMETER :: SRNAME = 'LA_SBGVD'
      CHARACTER(LEN=14), PARAMETER :: SRNAMT = 'LA_TEST_DSBGVD'
!  .. Common blocks ..
      INTEGER :: INFOTC
      COMMON /LINFO95/ INFOTC
!  .. Local Scalars ..
      INTEGER :: I, J, IAB1, IAB2, IW, IBB1, IBB2, IZ1, IZ2
      CHARACTER*1 :: IUPLO, IJOBZ   
!  .. Local Arrays ..
      LOGICAL, SAVE :: CTEST = .TRUE., ETEST = .TRUE.
      LOGICAL LSAME
!  .. Executable Statements ..
      IAB1 = KAB + 1; IAB2 = N; IUPLO = UPLO; IW = N; IJOBZ = JOBZ
      IBB1 = KBB + 1; IBB2 = N; IZ1 = N; IZ2 = N
      I = INFO / 100; J = INFO - I*100
      SELECT CASE(I)
      CASE (1)
      IAB1  = IAB1 - 1
      CASE (2)
      IBB2 = IBB2 - 1
      CASE (3)
      IW = IW - 1
      CASE (4)
      IUPLO = 'T'
      CASE (5)
      IZ2 = IZ2 - 1
      CALL LA_SBGVD( AB(1:IAB1, 1: IAB2), BB(1:IBB1, 1:IBB2), W(1 :IW), &
     &  IUPLO, Z(1:IZ1, 1: IZ2), INFO )
      CALL LA_AUX_AA01( I, CTEST, ETEST, SRNAMT )
      RETURN
      IJOBZ = 'V'
      CASE(:-1,6:)
      CALL UESTOP(SRNAMT)
      END SELECT
      IF (LSAME(IJOBZ, 'V')) THEN
        CALL LA_SBGVD( AB(1:IAB1, 1: IAB2), BB(1:IBB1, 1:IBB2), W(1 :IW), &
     &    IUPLO, Z(1:IZ1, 1: IZ2), INFO )
      ELSE
        CALL LA_SBGVD( AB(1:IAB1, 1: IAB2), BB(1:IBB1, 1:IBB2), W(1 :IW), &
     &    IUPLO, INFO = INFO )
      END IF
      CALL LA_AUX_AA01( I, CTEST, ETEST, SRNAMT )
      END SUBROUTINE LA_TEST_DSBGVD
