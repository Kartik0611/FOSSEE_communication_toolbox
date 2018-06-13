function at=gftrunc(a)
//This function is used to truncate the higher order zeroes in the given polynomial equation

//Calling Sequence
//AT=GFTRUNC(A)
    
//Description
//A is considered to be matrix that gives the coefficients of polynomial GF(p) in ascending order powers
//A = [1 2 3] denotes 1 + 2 x + 3 x^2    
//AT=GFTRUNC(A) returns a matrix which gives the polynomial GF(p) truncating the input matrix 
//that is if A(i)=0, where i > d + 1, where d is the degree of the polynomial, that zero is removed
    
//Examples
//A= [ 0 0 1 4 0 0] returns [0 0 1 4]
//c = gftrunc([0 0 1 2 3 0 0 0 4 5 0 1 0 0])

    
//See also
//gfadd, gfconv, gfdeconv, gfsub, gftuple

//Authors
//Pola Lakshmi Priyanka, IIT Bombay//

//*************************************************************************************************************************************//
// Check number of input arguments
[outa,inpa]=argn(0) 

if inpa~=1 then
    error('comm:gftrunc: Invalid number of input arguments')
end

[row_a,col_a]=size(a);
if row_a~=1 then
    error('comm:gftrunc: Input argument should be a row vector')
end
    for j=1:col_a
        if ( abs(a(1,j))~=a(1,j) | floor(a(1,j))~=a(1,j) )
                error('comm:gftrunc:Elements Of A should be Positive Integers');
        end
    end
at=a;
for i=col_a:-1:1
    if a(1,i)~=0 then
        break;
    else
        at=[at(1:i-1)]
    end
end
endfunction
