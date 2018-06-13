function q = gfrepcov(p)
//   This function represents a binary polynomial in standard ascending order format.

//   Calling Sequence
//   Q = GFREPCOV(P)

//   Description
//   Q = GFREPCOV(P) converts vector (P) to standard ascending
//   order format vector (Q), which is a vector that lists the coefficients in 
//   order of ascending exponents,  if P represents a binary polynomial 
//   as a vector of exponents with non-zero coefficients.

//   Examples
//   The matrix below represents the binary polynomial $1 + s + s^2 + s^4$
//   Implies output vector should be [1 1 1 0 1]
//   A=[0 1 2 4 ]
//   B=gfrepcov(A)
//   disp(B)
//   Also try A=[1 2 3 4 4] which is incorrect way of representing binary polynomial

//   See also
//   gfpretty

//   Authors
//   Pola Lakshmi Priyanka, IIT Bombay//

//*************************************************************************************************************************************//

//Input arguments 
[out_a,inp_a]=argn(0)

[row_p, col_p] = size(p);

// Error checking 
if ( isempty(p) | ndims(p)>2 | row_p > 1 )
    error('comm:gfrepcov: P should be a vector');
end
for j=1:col_p
if (floor(p(1,j))~=p(1,j) | abs(p(1,j))~=p(1,j)  )
    error('comm:gfrepcov: Elements of the vector should be non negative integers');
end
end

// Check if the given vector is in ascending order format, if not convert //
if max(p) > 1

// Check if P has any repetative elements.
    
    if (length(unique(p))~=length(p))
        error('comm:gfrepcov: Repeated elements in Vector');
    end
    q = zeros(1,max(p)+1);
    q(p+1) = 1;

else
    
    q = p;
    
end
endfunction
