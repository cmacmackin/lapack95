SUBROUTINE LA_TEST_CGELSS( M, N, NRHS, A, LDA, B, LDB, S, RCOND, RANK, WORK, LWORK, RWORK, INFO)
!
!  -- LAPACK95 interface driver routine (version 0.0) --
!     UNI-C, Denmark; Univ. of Tennessee, USA; NAG Ltd., UK
!     October 31, 1996
!
!  .. Use Statements ..
   USE LA_PRECISION, ONLY: WP => SP
   USE F95_LAPACK, ONLY: LA_GELSS
!  .. Implicit Statement ..
   IMPLICIT NONE
!  .. Scalar Arguments ..
   INTEGER, INTENT(IN) :: M, N, NRHS, LDA, LDB, LWORK
   INTEGER, INTENT(INOUT) :: INFO
   REAL(WP), INTENT(IN) :: RCOND
   INTEGER, INTENT(OUT) :: RANK
!  .. Array Arguments ..
   COMPLEX(WP), INTENT(INOUT) :: A(1:LDA,1:N), B(1:LDB,1:NRHS)
   COMPLEX(WP), INTENT(OUT) :: WORK(1:LWORK)
   REAL(WP), INTENT(OUT) :: S(1: MIN(M,N))
   REAL(WP) :: RWORK(1: 5*min(M,N)-1)
!  .. Parameters ..
   CHARACTER(LEN=8),  PARAMETER :: SRNAME = 'LA_GELSS'
   CHARACTER(LEN=14), PARAMETER :: SRNAMT = 'LA_TEST_CGELSS'
!  .. Common blocks ..
   INTEGER :: INFOTC
   COMMON /LINFO95/ INFOTC
!  .. Local Scalars ..
      INTEGER :: I, J, IA1, IA2, IB1, IB2, IS
      REAL:: IRCOND
!  .. Local Arrays ..
   INTEGER, SAVE, POINTER :: IWORK(:)
   LOGICAL, SAVE :: CTEST = .TRUE., ETEST = .TRUE.
!  .. Executable Statements ..
      IA1 = M; IA2 = N; IB1 = MAX(1,m,n); IB2 = NRHS; IS = MIN(M,N)
      IRCOND = RCOND
   I = INFO / 100; J = INFO - I*100
   SELECT CASE(I)
   CASE(0)
      IF (NRHS == 1) THEN
        CALL LA_GELSS( A(1:IA1,1:IA2), B(1:IB1,1), RANK, S(1:IS), &
     &    IRCOND, INFO)
        INFO = INFOTC
      ELSE
        CALL LA_GELSS( A(1:IA1,1:IA2), B(1:IB1,1:IB2),  RANK, S(1:IS), &
     &    IRCOND, INFO)                               
        INFO = INFOTC
      END IF            
   CASE (2)
      IB1 = MAX(1,M, N) - 2
   CASE(4)
      IS = MIN(M,N) - 1 
      CASE(:-1,1,3 ,5:)
      CALL UESTOP(SRNAMT)
   END SELECT
   IF( I /= 0 ) THEN
      SELECT CASE (NRHS)
      CASE (2:)
      CALL LA_GELSS( A(1:IA1,1:IA2), B(1:IB1,1:IB2), RANK, S(1:IS), &
     &  IRCOND, INFO)                               
      CASE(1)
      CALL LA_GELSS( A(1:IA1,1:IA2), B(1:IB1,1),  RANK, S(1:IS), &
     &  IRCOND, INFO)                               
      CASE(:-1)
         CALL UESTOP(SRNAMT)
      END SELECT
   END IF
   CALL LA_AUX_AA01( I, CTEST, ETEST, SRNAMT )
END SUBROUTINE LA_TEST_CGELSS
