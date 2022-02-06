% Demo de función de propagación de errores:
%
% z = 2*y + 5*x
%

close all;
clc;
clear;

x_mu    = 1.0;
x_sigma = 0.01;

y_mu    = 3.0;
y_sigma = 0.02;

N = 10000000; % Number of random samples

xs=randn(N,1) * x_sigma + x_mu;
ys=randn(N,1) * y_sigma + y_mu;

% z = 2*y + 5*x
zs = 2*ys + 5*xs;
z_mu_theory = 2*y_mu + 5*x_mu;

z_sigma_good = sqrt( 2^2 * y_sigma^2 + 5^2 * x_sigma^2)
z_sigma_bad = 2 * y_sigma + 5 * x_sigma
z_sigma_mc = std(zs)

figure(1);
subplot(1,2,1);
hx = histogram(xs,200,'Normalization','pdf');
hold on;
hy = histogram(ys,200,'Normalization','pdf');

subplot(1,2,2);
hz = histogram(zs,200,'Normalization','pdf');
hold on;

set(hx,"EdgeColor",[1 0 0],'FaceColor',[1 0 0])
set(hy,"EdgeColor",[0 1 0],'FaceColor',[0 1 0])
set(hz,"EdgeColor",[0 0 1],'FaceColor',[0 0 1])

x_values = linspace(z_mu_theory-z_sigma_mc*6 ,z_mu_theory+z_sigma_mc*6, 1000);
z_pdf_good = normpdf(x_values, z_mu_theory, z_sigma_good);
z_pdf_bad  = normpdf(x_values, z_mu_theory, z_sigma_bad);

p1=plot(x_values,z_pdf_good,'k','LineWidth',5);
p2=plot(x_values,z_pdf_bad,'k:','LineWidth',3);

subplot(1,2,1);
legend([hx,hy],'Histogram of x','Histogram of y');
title(sprintf('z=2y+5x (\\sigma_x=%.01g \\sigma_y=%.01g)',x_sigma,y_sigma));

subplot(1,2,2);
title(sprintf('z=2y+5x (\\sigma_x=%.01g \\sigma_y=%.01g)',x_sigma,y_sigma));
legend([hz,p1,p2],'Histogram of z=f(x,y)','PDF with square formula', 'PDF with linear formula');
