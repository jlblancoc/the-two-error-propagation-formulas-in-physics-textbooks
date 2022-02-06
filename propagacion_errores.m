% Demo de función de propagación de errores:
%
% z = 2*y + 5*x + 3*w
%

close all;
clc;
clear;

x_mu    = 1.0;
x_sigma = 0.05;

y_mu    = 2.0;
y_sigma = 0.10;

w_mu    = 20.0;
w_sigma = 0.5;

N = 10000000; % Number of random samples

xs=randn(N,1) * x_sigma + x_mu;
ys=randn(N,1) * y_sigma + y_mu;
ws=randn(N,1) * w_sigma + w_mu;

K=3; % sigmas -> limits

x_limit_min = x_mu - K * x_sigma;
x_limit_max = x_mu + K * x_sigma;

y_limit_min = y_mu - K * y_sigma;
y_limit_max = y_mu + K * y_sigma;

w_limit_min = w_mu - K * w_sigma;
w_limit_max = w_mu + K * w_sigma;

% z = 2*y + 5*x+ 3*w
zs = 2*ys + 5*xs; % + 3*ws;
z_mu_theory = 2*y_mu + 5*x_mu; % + 3*w_mu;

z_sigma_good = sqrt( 2^2 * y_sigma^2 + 5^2 * x_sigma^2)
z_sigma_bad = 2 * y_sigma + 5 * x_sigma
z_sigma_mc = std(zs)

z_limit_min = z_mu_theory - K * z_sigma_bad;
z_limit_max = z_mu_theory + K * z_sigma_bad;

z_limit_min_good = z_mu_theory - K * z_sigma_good;
z_limit_max_good = z_mu_theory + K * z_sigma_good;


figure(1);
subplot(1,2,1);
hx = histogram(xs,200,'Normalization','pdf');
hold on;
hy = histogram(ys,200,'Normalization','pdf');
%hw = histogram(ws,200,'Normalization','pdf');

plot(x_limit_min*[1 1],[0 0.5]*max(hx.Values),'k','LineWidth',3);
plot(x_limit_max*[1 1],[0 0.5]*max(hx.Values),'k','LineWidth',3);

plot(y_limit_min*[1 1],[0 0.5]*max(hy.Values),'k','LineWidth',3);
plot(y_limit_max*[1 1],[0 0.5]*max(hy.Values),'k','LineWidth',3);

%plot(w_limit_min*[1 1],[0 0.5]*max(hw.Values),'k','LineWidth',3);
%plot(w_limit_max*[1 1],[0 0.5]*max(hw.Values),'k','LineWidth',3);

subplot(1,2,2);
hz = histogram(zs,200,'Normalization','pdf');
hold on;

set(hx,"EdgeColor",[1 0 0],'FaceColor',[1 0 0])
set(hy,"EdgeColor",[0 1 0],'FaceColor',[0 1 0])
%set(hw,"EdgeColor",[1 1 0],'FaceColor',[1 1 0])
set(hz,"EdgeColor",[0 0 1],'FaceColor',[0 0 1])

x_values = linspace(z_mu_theory-z_sigma_mc*6 ,z_mu_theory+z_sigma_mc*6, 1000);
z_pdf_good = normpdf(x_values, z_mu_theory, z_sigma_good);
z_pdf_bad  = normpdf(x_values, z_mu_theory, z_sigma_bad);

p1=plot(x_values,z_pdf_good,'k','LineWidth',5);
p2=plot(x_values,z_pdf_bad,'k:','LineWidth',3);

plot(z_limit_min*[1 1],[0 0.5]*max(hz.Values),'k:','LineWidth',3);
plot(z_limit_max*[1 1],[0 0.5]*max(hz.Values),'k:','LineWidth',3);

plot(z_limit_min_good*[1 1],[0 0.5]*max(hz.Values),'k-','LineWidth',3);
plot(z_limit_max_good*[1 1],[0 0.5]*max(hz.Values),'k-','LineWidth',3);

tit = sprintf('z=2y+5x (\\sigma_x=%.01g \\sigma_y=%.01g)',x_sigma,y_sigma);

subplot(1,2,1);
legend([hx,hy],'Histogram of x','Histogram of y');
title(tit);

subplot(1,2,2);
legend([hz,p1,p2],'Histogram of z=f(x,y,w)','PDF with square formula', 'PDF with linear formula');
title(tit);
