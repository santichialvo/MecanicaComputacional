function fI= monte_carlo_integration(fun,a,b,c,d)
%
%                   Monte Carlo integration method
%
%   fI = monte_carlo_integration(fun,a,b,c,d)
%
% 1.- Pick "N" randomly distributed points in the rectangle (a,b)x(c,d)
%
% 2.- Determine the average value of the function  
%
% f_avg = 1/N*sum_i=1^N f(xi,yi)
%
% 3.- Compute the approximation to the integral  
%
% Integral = (b-a)*(d-c)*f_avg
%

N=1000;

xx = rand(N,1)*(b-a)+a;
yy = rand(N,1)*(d-c)+c;

eval(['f_avg = ' fun '(xx,yy);']);
f_avg = mean(f_avg);

fI = (b-a)*(d-c)*f_avg;