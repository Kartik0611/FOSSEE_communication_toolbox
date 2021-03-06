function seq = lteZadoffChuSeq(R, N)
//   This function generates root Zadoff-Chu sequence of complex symbols as per LTE specifications.
//
//   Calling sequence
//   SEQ = LTEZADOFFCHUSEQ(R, N)
//
//   Description
//   SEQ = LTEZADOFFCHUSEQ(R, N) generates the Rth root Zadoff-Chu sequence (SEQ)
//   of length N.

//   Examples
//   seq1 = lteZadoffChuSeq(2, 3)
//   disp(seq1,'seq1')
//   Error should occur because inputs are not co primes
//   seq2 = lteZadoffChuSeq(25, 5)
//   disp(seq2,'seq2')


//   Bibliography 
//   3rd Generation Partnership Project, Technical Specification Group Radio
//   Access Network, Evolved Universal Terrestrial Radio Access (E-UTRA),
//   Physical channels and modulation, Release 10, 3GPP TS 36.211, v10.0.0,
//   2010-12.

//   Authors
//   Pola Lakshmi Priyanka, IIT Bombay//

//*************************************************************************************************************************************//

//Input argument check
[out_a,inp_a]=argn(0)

if inp_a~=2 then
    error('comm:lteZadoffChuSeq:Invalid number of input arguments')
end

if out_a>1 then
    error('comm:lteZadoffChuSeq:Invalid number of output arguments')
end

// Error Check for input arguments
if(~isscalar(R) | ~or(type(R)==[1 5 8]) | ~isreal(R) | R==%inf | R~=floor(R) | R<=0) then
    error('comm:lteZadoffChuSeq: Input argument 1 should be a finite positive integer')
end

if(~isscalar(N) | ~or(type(N)==[1 5 8]) | ~isreal(N) | N==%inf | N~=floor(N) | N<=0 | modulo(N,2)==0) then
    error('comm:lteZadoffChuSeq:Input argument 2 is invalid')
end

if(gcd(uint8([R N])) ~= 1) then
    error('comm:lteZadoffChuSeq:Both the input arguments should be co primes')
end


m = (0:N-1).';
seq = exp( -complex(0,1) * %pi * R * m.*(m+1) / N );

endfunction
