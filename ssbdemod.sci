function z=ssbdemod(y, Fc, Fs, varargin)
    
//   This function performs Single Side Band Amplitude Demodulation

//   Calling Sequence
//   Z = SSBDEMOD(Y,Fc,Fs) 
//   Z = SSBDEMOD(Y,Fc,Fs,INI_PHASE) 
//   Z = SSBDEMOD(Y,Fc,Fs,INI_PHASE,NUM,DEN) 

//   Description
//   Z = SSBDEMOD(Y,Fc,Fs) 
//   demodulates the single sideband amplitude modulated signal Y 
//   with the carrier frequency Fc (Hz).
//   Sample frequency Fs (Hz). zero initial phase (ini_phase).
//   The modulated signal can be an upper or lower sideband signal. 
//   A lowpass butterworth filter is used in the demodulation.  
// 
//   Z = SSBDEMOD(Y,Fc,Fs,INI_PHASE) 
//   adds an extra argument the initial phase (rad) of the modulated signal.
// 
//   Z = SSBDEMOD(Y,Fc,Fs,INI_PHASE,NUM,DEN) 
//   adds extra arguments about the filter specifications 
//   i.e., the numerator and denominator of the lowpass filter.
//
//   Fs must satisfy Fs >2*(Fc + BW), where BW is the bandwidth of the
//   modulating signal.
 

//   Examples

//   Fs =200;
//   t = [0:2*Fs+1]'/Fs;
//   ini_phase = 5;
//   Fc = 20;
//   fm1= 2;
//   fm2= 3;
//   x =sin(2*fm1*%pi*t)+sin(2*fm2*%pi*t);
//   y = ssbmod(x,Fc,Fs,ini_phase);
//   o = ssbdemod(y,Fc,Fs,ini_phase);
//   z = fft(y);
//   zz =abs(z(1:length(z)/2+1 ));
//   axis = (0:Fs/length(zz):Fs -(Fs/length(zz)))/2;
//
//   figure
//   subplot(3,1,1); plot(x);
//   title(' Message signal');
//   subplot(3,1,2); plot(y);
//   title('Amplitude modulated signal');
//   subplot(3,1,3); plot(axis,zz);
//   title('Spectrum of amplitude modulated signal');
//   z1 =fft(o);
//   zz1 =abs(z1(1:length(z1)/2+1 ));
//   axis = (0:Fs/length(zz1):Fs -(Fs/length(zz1)))/2;
//   figure
//   subplot(3,1,1); plot(y);
//   title(' Modulated signal');
//   subplot(3,1,2); plot(o);
//   title('Demodulated signal');
//   subplot(3,1,3); plot(axis,zz1);
//   title('Spectrum of Demodulated signal');

//   See also 
//   ssbmod

//   Authors
//   Pola Lakshmi Priyanka, IIT Bombay//

//*************************************************************************************************************************************//

//   Check number of input arguments
[outa,inpa]=argn(0) 
if(inpa > 6)
//    error("comm:ssbdemod:Too Many Input Arguments");        // Here error comments are printed as it is.
    error("Too Many Input Arguments");
end
//funcprot(0) //to protect the function 

//Check y,Fc, Fs.
if(~isreal(y)| ~or(type(y)==[1 5 8]) )
//    error("comm:ssbdemod: Y must be real");             // Here error comments are printed as it is.
    error(" Y must be real");
end

if(~isreal(Fc) | ~isscalar(Fc) | Fc<=0 | ~or(type(Fc)==[1 5 8]) )
//    error("comm:ssbdemod:Fc must be Real, scalar, positive");  // Here error comments are printed as it is.
    error("Fc must be Real, scalar, positive");
end

if(~isreal(Fs) | ~isscalar(Fs) | Fs<=0 | ~or(type(Fs)==[1 5 8]) )
//    error("comm:ssbdemod:Fs must be Real, scalar, positive");  // Here error comments are printed as it is.
    error("Fs must be Real, scalar, positive");
end

// Check if Fs is greater than 2*Fc
if(Fs<=2*Fc)
//    error("comm:ssbdemod:Fs<2Fc:Nyquist criteria fails");         // Here error comments are printed as it is.
    error("Fs<2Fc:Nyquist criteria fails");
end

// Check initial phase

if(inpa<4 )
    ini_phase = 0;
else 
    ini_phase = varargin(1);
end
if(~isreal(ini_phase) | ~isscalar(ini_phase)| ~or(type(ini_phase)==[1 5 8]) )
//    error("comm:ssbdemod:Initial phase shoould be Real");   //Here error comments are printed as it is.
    error("Initial phase shoould be Real"); 
end

// Filter specifications
if(inpa<5)  
    H = iir(5,'lp','butt',[Fc/Fs,0],[0,0]); 
    
    num = coeff(H(2));
    den = coeff(H(3));
    num = num(length(num):-1:1);
    den = den(length(den):-1:1);
    
// Check that the numerator and denominator are valid, and come in a pair
elseif( (inpa == 5) )
//    error("comm:ssbdemod:NumDenPair: Filter error :Two arguments required"); // Here error comments are printed as it is.
    error("NumDenPair: Filter error :Two arguments required");

// Check to make sure that both num and den have values

//elseif( bitxor(isempty(varargin(1)), isempty(varargin(2))))   // bitxor should have number(>=0)) as input argument 
elseif( bitxor( bool2s(isempty(varargin(2))), bool2s(isempty(varargin(3)))))
//    error(message('comm:ssbdemod:Filter specifications'));    // "message" is an undesined variable
      error('Filter specification error, NumDenPair required'); 
//elseif(isempty(varargin(1)), isempty(varargin(2)))   
elseif(isempty(varargin(2)) & isempty(varargin(3))) 
//    H = iir(7,'lp','butt',[Fc/Fs*2*%pi,0],[0,0]);       // It should be same as in line 108
      H = iir(5,'lp','butt',[Fc/Fs,0],[0,0]);

//    disp("H(2)=",H(2))
//    disp("H(3)=",H(3))
//No need of displaying it.
    
    num = coeff(H(2));
    den = coeff(H(3));
    num = num(length(num):-1:1);
    den = den(length(den):-1:1);
else 
    num = varargin(2);
    den = varargin(3);
end

// check if Y is one dimensional 
wid = size(y,1);
if(wid ==1)
    y = y(:);
end

// Demodulation
t = (0 : 1/Fs :(size(y,1)-1)/Fs)';
t = t(:, ones(1, size(y, 2)));
z = y .* cos(2*%pi * Fc * t + ini_phase);
for i = 1 : size(z, 2)
    z(:, i) = filter(num, den, z(:, i)) ;
    z=z(length(z):-1:1)
    z(:, i) = filter(num, den, z(:, i)) ;
    //z=z*-2;
    z=z(length(z):-1:1)  // Once again the sequence should be reversed
    z=z*2;  
end;

// restore the output signal to the original orientation 
if(wid == 1)
    z = z';
end
endfunction

// End of function
