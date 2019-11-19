close all; clear; clc;

DATA_PATH = 'statdata/';
FILENAME1 = 'cw_20191911171652117';
FILENAME2 = '20191911165509428';

max_time = 100;
max_episode = 100;

X = -3:2;
NX = length(X);

LAMBDAS = 10.^X;

load([DATA_PATH, FILENAME1, '.mat']);

H_AVE_PASS(H_AVE_PASS == 0) = 1e-6;
C_AVE_PASS(C_AVE_PASS == 0) = 1e-6;

H_AVE_TIME1 = H_AVE_TIME;
C_AVE_TIME1 = C_AVE_TIME;
H_AVE_PASS1 = H_AVE_PASS;
C_AVE_PASS1 = C_AVE_PASS;

load([DATA_PATH, FILENAME2, '.mat']);

H_AVE_PASS(H_AVE_PASS == 0) = 1e-6;
C_AVE_PASS(C_AVE_PASS == 0) = 1e-6;

H_AVE_TIME2 = H_AVE_TIME;
C_AVE_TIME2 = C_AVE_TIME;
H_AVE_PASS2 = H_AVE_PASS;
C_AVE_PASS2 = C_AVE_PASS;

%% plot

LINEWIDTH = 2;

figure;
ph1 = semilogx(LAMBDAS, H_AVE_TIME1, 'b*-', 'linewidth', LINEWIDTH);
hold on;
pc1 = semilogx(LAMBDAS, C_AVE_TIME1, 'b^-', 'linewidth', LINEWIDTH);
ph2 = semilogx(LAMBDAS, H_AVE_TIME2, 'r*-', 'linewidth', LINEWIDTH);
pc2 = semilogx(LAMBDAS, C_AVE_TIME2, 'r^-', 'linewidth', LINEWIDTH);
xlabel('\lambda');
ylabel('Average wait time');
legend([ph1, pc1, ph2, pc2], {'Humans1', 'Cars1', 'Humans2', 'Cars2'}, ...
    'location', 'northwest');

figure;
ph1 = loglog(LAMBDAS, H_AVE_PASS1, 'b*-', 'linewidth', LINEWIDTH);
hold on;
pc1 = loglog(LAMBDAS, C_AVE_PASS1, 'b^-', 'linewidth', LINEWIDTH);
ph2 = loglog(LAMBDAS, H_AVE_PASS2, 'r*-', 'linewidth', LINEWIDTH);
pc2 = loglog(LAMBDAS, C_AVE_PASS2, 'r^-', 'linewidth', LINEWIDTH);
xlabel('\lambda');
ylabel('Throughput');
ylim([1e-2, 1e5]);
legend([ph1, pc1, ph2, pc2], {'Humans1', 'Cars1', 'Humans2', 'Cars2'}, ...
    'location', 'northwest');
