PROGRAM LA_CSPSV_ET_EXAMPLE
!
!  -- LAPACK95 interface driver routine (version 3.0) --
!     UNI-C, Denmark; Univ. of Tennessee, USA; NAG Ltd., UK
!     September, 2000
!
!  .. USE STATEMENTS
   USE LA_PRECISION, ONLY: WP => SP
   USE F95_LAPACK, ONLY: LA_SPSV
!  .. IMPLICIT STATEMENT ..
   IMPLICIT NONE
!  .. PARAMETERS ..
   CHARACTER(LEN=*), PARAMETER :: FMT = '(4(1X,1H(,F7.3,1H,,F7.3,1H):))'
   INTEGER, PARAMETER :: NIN=5, NOUT=6
!  .. LOCAL SCALARS ..
   INTEGER :: I, J, K, FAIL, N, NRHS, NS
!  .. LOCAL ARRAYS ..
   INTEGER, ALLOCATABLE :: PIV(:)
   COMPLEX(WP), ALLOCATABLE :: A(:), B(:,:)
   REAL(WP), ALLOCATABLE :: AA(:), BB(:,:)
!  .. EXECUTABLE STATEMENTS ..
   WRITE (NOUT,*) 'CSPSV ET_Example Program Results.'
   READ ( NIN, * )   ! SKIP HEADING IN DATA FILE
   READ ( NIN, * ) N, NRHS
   PRINT *, 'N = ', N, ' NRHS = ', NRHS
   NS = N*(N+1)/2
   ALLOCATE ( A(NS), AA(NS), B(N,NRHS), BB(N,NRHS), PIV(N) )
!
        READ (NIN, *) AA
      BB = 0.0_WP
      DO K = 1, NRHS
         DO I = 1, N
            DO J = 1, I
               BB(J,K) = BB(J,K) + AA(J+(I-1)*I/2)
               IF ( J /= I ) BB(I,K) = BB(I,K) + AA(J+(I-1)*I/2)
            ENDDO
         ENDDO
         BB(:,K) = BB(:,K)*K
      ENDDO
   A=AA; B=BB
      WRITE(NOUT,*) 'The matrix A:'
      DO I = 1, N
        WRITE (NOUT,*) 'J = ', I; WRITE (NOUT,FMT) (A(J+(I-1)*I/2),J=1,I)
      ENDDO
      WRITE(NOUT,*) 'The RHS matrix B:'
      DO J = 1, NRHS
        WRITE (NOUT,*) 'RHS', J; WRITE (NOUT,FMT) B(:,J)
      ENDDO
!
   WRITE ( NOUT, * )'---------------------------------------------------------'
   WRITE ( NOUT, * )
   WRITE ( NOUT, * )'Details of LA_CSPSV LAPACK Subroutine Results.'
   WRITE ( NOUT, * )
!
   WRITE(NOUT,*)
   WRITE(NOUT,*) 'CALL LA_SPSV(A, B )'
   A=AA; B=BB
   IF (NRHS .GT. 1) THEN
      CALL LA_SPSV( A, B )
   ELSE
      CALL LA_SPSV( A, B(1:N,1) )
   END IF
   WRITE(NOUT,*)'   B - the solution vectors computed by LA_SPSV:'
   DO J = 1, NRHS
      WRITE (NOUT,FMT) B(:,J)
   END DO
! 
   WRITE(NOUT,*)
   WRITE(NOUT,*) 'CALL LA_SPSV( A, B, ''L'' )'
   DO I = 1,N
      DO J = I, N
         A(J+(I-1)*(2*N-I)/2) = AA(I+J*(J-1)/2)
      ENDDO
   ENDDO
   B = BB
   CALL LA_SPSV( A, B, 'L' )
   WRITE(NOUT,*)'   B - the solution vectors computed by LA_SPSV:'
   DO J = 1, NRHS
      WRITE (NOUT,FMT) B(:,J)
   END DO
   WRITE(NOUT,*)
   WRITE(NOUT,*) 'CALL LA_SPSV( A, B(1:N,1), IPIV=PIV, INFO=FAIL )'
   A=AA; B=BB
   CALL LA_SPSV( A, B(1:N,1), IPIV=PIV, INFO=FAIL )
   WRITE(NOUT,*)'B - the solution vectors computed by LA_SPSV, INFO = ', FAIL
   WRITE (NOUT,FMT) B(1:N,1)
   WRITE (NOUT,*) 'Pivots: ', PIV
!
END PROGRAM LA_CSPSV_ET_EXAMPLE
