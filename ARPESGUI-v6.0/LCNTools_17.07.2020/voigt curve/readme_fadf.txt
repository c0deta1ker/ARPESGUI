ACCURACY IN THE SECOND VERSION

    Within the HITRAN domain 0 < x < 40,000 and 10^-4 < y < 10^2, where x =
Re[z] and y = Im[z] are the real and imaginary arguments, the average
accuracy exceeds 10^-14. The worst detected accuracies in the external
|z| > 8 and internal |z| <= 8 areas are ~10^-14 and ~10^-13, respectively.
Within the narrow band |y| < 5*10^-3 bounded by the internal area the worst
detected accuracy is ~10^-13.
    The code covers the entire complex domain required for practical
applications (in all four quadrants) and remains highly accurate even for
the vanishing imaginary argument y -> 0. Current version of the code
provides improvement in accuracy by several orders of magnitude at small
imaginary argument |y| << 1.

NOTE: Our objective for the worst accuracy is ~10^-13; if you detect any
point(s) where the accuracy is ~10^-12 or worse, please let us known about
it. We will fix the problem as soon as we can.

Email: <absanj AT gmail DOT com>

---------------------------------------------------------------------------
FIRST VERSION: submitted on 10 Sept. 2014

    Below is the Matlab code from the previous (first) version of function
file 'fadf(z).m' published earlier in the Matlab Central webcite, the file
ID: #47801. This Matlab code is shown for chronology.
---------------------------------------------------------------------------

function FF = fadf(z)

% This program file computes the complex error function, also known as the
% Faddeeva function. The algorithmic implementation utilizes the
% approximations based on the Fourier expansion [1, 2] and the Laplace
% continued fraction [3] (see also optimized C++ code from RooFit package
% in the work [4]).
%
% REFERENCES
% [1] S. M. Abrarov and B. M. Quine, Appl. Math. Comput., Efficient
%     algorithmic implementation of the Voigt/complex error function based
%     on exponential series approximation, 218 (2011) 1894-1902.
%     http://doi.org/10.1016/j.amc.2011.06.072
%
% [2] S. M. Abrarov and B. M. Quine, On the Fourier expansion method
%     for highly accurate computation of the Voigt/complex error function
%     in a rapid algorithm, arXiv:1205.1768v1 (2012).
%     http://arxiv.org/abs/1205.1768
%
% [3] W. Gautschi, Efficient computation of the complex error function,
%     SIAM J. Numer. Anal., 7 (1970) 187-198.
%     http://www.jstor.org/stable/2949591
%
% [4] T. M. Karbach, G. Raven and M. Schiller, Decay time integrals in
%     neutral meson mixing and their efficient evaluation,
%     arXiv:1407.0748v1 (2014).
%     http://arxiv.org/abs/1407.0748
%
% The code is written by Sanjar M. Abrarov and Brendan M. Quine, York
% University, Canada, September 2014.

ind_neg = imag(z)<0; % if some imag(z) values are negative, then ...
z(ind_neg) = conj(z(ind_neg)); % ... bring them to the upper-half plane
ind_ext  = abs(z)>15; % external indices
ind_band = abs(z)<=15 & imag(z)<10^-5; % narrow band indices

FF = zeros(size(z)); % define array
FF(~ind_ext & ~ind_band) = ...
    fexp(z(~ind_ext & ~ind_band)); % internal area. This area is the ...
    % ... most difficult for accurate computation
FF(ind_ext) = contfr(z(ind_ext)); % external area
FF(ind_band) = smallim(z(ind_band)); % narrow band

    function FE = fexp(z,tauM) % the Fourier expansion approximation

        if nargin == 1
            tauM = 12; % default margin value
        end
        maxN = 23; % number of summation terms

        n = 1:maxN;
        aN = 2*sqrt(pi)/tauM*exp(-n.^2*pi^2/tauM^2); % Fourier coefficients

        z1 = exp(1i*tauM*z); % define first repeating array
        z2 = tauM^2*z.^2; % define second repeating array

        FE = sqrt(pi)/tauM*(1 - z1)./z2; % initiate array FE
        for n = 1:maxN
            FE = FE + (aN(n)*((-1)^n*z1 - 1)./(n^2*pi^2 - z2));
        end
        FE = 1i*tauM^2*z/sqrt(pi).*FE;
    end

    function CF = contfr(z) % the Laplace continued fraction approximation

        aN = 8; % initial integer
        aN = 1:2*aN;
        aN = aN/2;

        CF = aN(end)./z; % start computing from the last aN
        for n = 1:length(aN) - 1
            CF = aN(end-n)./(z - CF);
        end
        CF = 1i/sqrt(pi)./(z - CF);
    end

    function SIm = smallim(z) % approximation at small imag(z)

        ind_0 = abs(real(z))<=1e-3; % indices near origin
        ind_4 = abs(real(z))>4; % indices for |Re[z]| > 4

        % If 10^-3 < |Re[z]| <= 4, then:
        SIm(~ind_0 & ~ind_4) = fexp(z(~ind_0 & ~ind_4),12.1);
        % else if |Re[z]| <= 10^-3, then:
        SIm(ind_0) = (1-z(ind_0).^2).*(1+2i/sqrt(pi)*z(ind_0));

        del = 10^-5; % assign delta
        z_del = real(z(ind_4)) + 1i*del; % incorporate delta
        zr = imag(z(ind_4))./del; % assign ratio
        ff_ref = fexp(z_del); % assign reference of the Faddeeva function

        % Finally, for |Re[z]| > 4 apply
        SIm(ind_4) = zr.*real(ff_ref) + (1 - zr).*exp(-real(z_del).^2) ...
            + 1i*imag(ff_ref);
    end

% Convert for negative imag(z) values
FF(ind_neg) = conj(2*exp(-z(ind_neg).^2) - FF(ind_neg));
end

---------------------------------------------------------------------------
