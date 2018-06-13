function result = iscatastrophic(trellis)

//   This function  determines if a convolutional code is catastrophic or not

//   Calling Sequence
//   RESULT = ISCATASTROPHIC(TRELLIS)

//   Description
//   RESULT = ISCATASTROPHIC(TRELLIS) returns 1 if the specified 
//   trellis corresponds to a catastrophic convolutional code, else 0.

//   Examples 
//   eg_1.numInputSymbols = 4;
//   eg_1.numOutputSymbols = 4;
//   eg_1.numStates = 3;
//   eg_1.nextStates = [0 1 2 1;0 1 2 1; 0 1 2 1];
//   eg_1.outputs = [0 0 1 1;1 1 2 1; 1 0 1 1];
//   res_t_eg_1=istrellis(eg_1)
//   res_c_eg_1=iscatastrophic(eg_1)
//   if (res_c_eg_1) then
//       disp('Example 1 is catastrophic')
//   else
//       disp('Example 1 is not catastrophic')
//   end

//   eg_2.numInputSymbols = 2;
//   eg_2.numOutputSymbols = 4;
//   eg_2.numStates = 2;
//   eg_2.nextStates = [0 0; 1 1 ]
//   eg_2.outputs = [0 0; 1 1];
//   res_t_eg_2=istrellis(eg_2)
//   res_c_eg_2=iscatastrophic(eg_2)
//   if (res_c_eg_2) then
//       disp('Example 2 is catastrophic')
//   else
//       disp('Example 2 is not catastrophic')
//   end 


//   See also
//   istrellis

//   Authors
//   Pola Lakshmi Priyanka, IIT Bombay//

//*************************************************************************************************************************************//

// Check number of input arguments
[out_a,inp_a]=argn(0)

if inp_a~=1 then
    error('comm:iscatastrophic: Invalid number of input arguments')
end


if out_a>1 then
    error('comm:iscatastrophic: Invalid number of output arguments')
end

// Check if the input is a valid trellis
if ~istrellis(trellis),
    error('comm:iscatastrophic:Input should be a valid trellis structure.');  
end

result = 0;

// Find indices of zeros in trellis structure
[r_idx,c_idx] = find(trellis.outputs==0);

//Find Connectivity matrix and check if it is catastrophic
A = zeros(trellis.numStates,trellis.numStates);
for k = 2:length(r_idx)
    A(r_idx(k),trellis.nextStates(r_idx(k),c_idx(k))+1)=1;
end


test = A;
for i = 1:trellis.numStates
    for j = 1:trellis.numStates
        if test(j,j)==1
            result = 1
        end
    end
    if result==1
        break
    else
        test = test*A;
    end
end

endfunction
