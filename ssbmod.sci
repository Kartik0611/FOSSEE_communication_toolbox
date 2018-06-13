function y=ssbmod(x, Fc, Fs, varargin)

// Number of arguments check
[outa,inpa]=argn(0) 
if(inpa > 5)
    error("Too Many Input Arguments");
end
//funcprot(0) //to protect the function 

//Check y,Fc, Fs.
if(~isreal(x)| ~or(type(x)==[1 5 8]) )
    error("Y must be real");
end

if(~isreal(Fc) | ~isscalar(Fc) | Fc<=0 | ~or(type(Fc)==[1 5 8]) )
    error("Fc must be Real, scalar, positive");
end

if(~isreal(Fs) | ~isscalar(Fs) | Fs<=0 | ~or(type(Fs)==[1 5 8]) )
    error("Fs must be Real, scalar, positive");
end

// Check if Fs is greater than 2*Fc
if(Fs<=2*Fc)
    error("Fs<2Fc:Nyquist criteria fails");
end

if(inpa>=4)
    ini_phase = varargin(1);
    if(isempty(ini_phase))
        ini_phase = 0;
    elseif(~isreal(ini_phase) | ~isscalar(ini_phase)| ~or(type(ini_phase)==[1 5 8]) )
        error("comm:ssbdemod:Initial phase should be Real");
    end
else
    ini_phase = 0;
end

Method = '';
if(inpa==5)
    Method = varargin(2);
    if(strcmp(convstr(Method,'l'),'upper')) 
        error('Invalid input argument');
    end
end

// End of Parameter checks 

//--- Assure that X, if one dimensional, has the correct orientation --- 
wid = size(x,1);
if(wid ==1)
    x = x(:);
end

t = (0:1/Fs:((size(x,1)-1)/Fs))';
t = t(:, ones(1, size(x, 2)));

if (~strcmp(convstr(Method,'l'),'upper'))
    y = x .* cos(2 *%pi * Fc * t + ini_phase) - ...
        imag(hilbert(x)) .* sin(2 *%pi * Fc * t + ini_phase);    
else
    y = x .* cos(2 *%pi * Fc * t + ini_phase) + ...
        imag(hilbert(x)) .* sin(2 *%pi * Fc * t + ini_phase);    
end; 

// --- restore the output signal to the original orientation --- 
if(wid == 1)
    y = y';
end

endfunction

