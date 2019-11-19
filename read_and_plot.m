close all; clear; clc;

DATA_PATH = 'statdata/';
FILENAME = 'cw_20191911171652117';

max_time = 100;
max_episode = 100;

X = -3:2;
NX = length(X);

LAMBDAS = 10.^X;

load([DATA_PATH, FILENAME, '.mat']);

H_AVE_PASS(H_AVE_PASS == 0) = 1e-6;
C_AVE_PASS(C_AVE_PASS == 0) = 1e-6;

H_AVE_TIME
C_AVE_TIME
H_AVE_PASS
C_AVE_PASS

figure;
ph = semilogx(LAMBDAS, H_AVE_TIME);
hold on;
pc = semilogx(LAMBDAS, C_AVE_TIME);
xlabel('\lambda');
ylabel('Average wait time');
legend([ph, pc], {'Humans', 'Cars'});

figure;
ph = loglog(LAMBDAS, H_AVE_PASS);
hold on;
pc = loglog(LAMBDAS, C_AVE_PASS);
xlabel('\lambda');
ylabel('Throughput');
ylim([1e-2, 1e5]);
legend([ph, pc], {'Humans', 'Cars'});
