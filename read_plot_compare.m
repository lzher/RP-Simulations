close all; clear; clc;

DATA_PATH = 'statdata/';
FILENAME1 = 'wa_20192011133838608';
FILENAME2 = 'cw_20192011133914279';
FILENAME3 = 'rp_20192011152453851';

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
T_AVE_TIME1 = T_AVE_TIME;
T_AVE_PASS1 = T_AVE_PASS;

load([DATA_PATH, FILENAME2, '.mat']);

H_AVE_PASS(H_AVE_PASS == 0) = 1e-6;
C_AVE_PASS(C_AVE_PASS == 0) = 1e-6;

H_AVE_TIME2 = H_AVE_TIME;
C_AVE_TIME2 = C_AVE_TIME;
H_AVE_PASS2 = H_AVE_PASS;
C_AVE_PASS2 = C_AVE_PASS;
T_AVE_TIME2 = T_AVE_TIME;
T_AVE_PASS2 = T_AVE_PASS;

load([DATA_PATH, FILENAME3, '.mat']);

H_AVE_PASS(H_AVE_PASS == 0) = 1e-6;
C_AVE_PASS(C_AVE_PASS == 0) = 1e-6;

H_AVE_TIME3 = H_AVE_TIME;
C_AVE_TIME3 = C_AVE_TIME;
H_AVE_PASS3 = H_AVE_PASS;
C_AVE_PASS3 = C_AVE_PASS;
T_AVE_TIME3 = T_AVE_TIME;
T_AVE_PASS3 = T_AVE_PASS;

%% plot

LINEWIDTH = 2;

H1 = '行人（等待）';
C1 = '车辆（等待）';
H2 = '行人（车让人）';
C2 = '车辆（车让人）';
H3 = '行人（竞争）';
C3 = '车辆（竞争）';
T1 = '等待';
T2 = '车让人';
T3 = '竞争';

f1 = figure;
ph3 = semilogx(LAMBDAS, H_AVE_TIME3, 'k*-', 'linewidth', LINEWIDTH);
hold on;
pc3 = semilogx(LAMBDAS, C_AVE_TIME3, 'k^-', 'linewidth', LINEWIDTH);
ph2 = semilogx(LAMBDAS, H_AVE_TIME2, 'r*-', 'linewidth', LINEWIDTH);
pc2 = semilogx(LAMBDAS, C_AVE_TIME2, 'r^-', 'linewidth', LINEWIDTH);
ph1 = semilogx(LAMBDAS, H_AVE_TIME1, 'b*-', 'linewidth', LINEWIDTH);
pc1 = semilogx(LAMBDAS, C_AVE_TIME1, 'b^-', 'linewidth', LINEWIDTH);
xlabel('到达率 \lambda');
ylabel('平均等待时间 (s)');
legend([ph1, pc1, ph2, pc2, ph3, pc3], {H1, C1, H2, C2, H3, C3}, ...
    'location', 'northwest');

f2 = figure;
ph3 = loglog(LAMBDAS, H_AVE_PASS3, 'k*-', 'linewidth', LINEWIDTH);
hold on;
pc3 = loglog(LAMBDAS, C_AVE_PASS3, 'k^-', 'linewidth', LINEWIDTH);
ph2 = loglog(LAMBDAS, H_AVE_PASS2, 'r*-', 'linewidth', LINEWIDTH);
pc2 = loglog(LAMBDAS, C_AVE_PASS2, 'r^-', 'linewidth', LINEWIDTH);
ph1 = loglog(LAMBDAS, H_AVE_PASS1, 'b*-', 'linewidth', LINEWIDTH);
pc1 = loglog(LAMBDAS, C_AVE_PASS1, 'b^-', 'linewidth', LINEWIDTH);
xlabel('到达率 \lambda');
ylabel('通过数量');
ylim([1e-2, 1e5]);
legend([ph1, pc1, ph2, pc2, ph3, pc3], {H1, C1, H2, C2, H3, C3}, ...
    'location', 'northwest');

f3 = figure;
p3 = semilogx(LAMBDAS, T_AVE_TIME3, 'k*-', 'linewidth', LINEWIDTH);
hold on;
p2 = semilogx(LAMBDAS, T_AVE_TIME2, 'r*-', 'linewidth', LINEWIDTH);
p1 = semilogx(LAMBDAS, T_AVE_TIME1, 'b*-', 'linewidth', LINEWIDTH);
xlabel('到达率 \lambda');
ylabel('总平均等待时间 (s)');
legend([p1, p2, p3], {T1, T2, T3}, 'location', 'northwest');

f4 = figure;
p3 = loglog(LAMBDAS, T_AVE_PASS3, 'k*-', 'linewidth', LINEWIDTH);
hold on;
p2 = loglog(LAMBDAS, T_AVE_PASS2, 'r*-', 'linewidth', LINEWIDTH);
p1 = loglog(LAMBDAS, T_AVE_PASS1, 'b*-', 'linewidth', LINEWIDTH);
xlabel('到达率 \lambda');
ylabel('总通过数量');
legend([p1, p2, p3], {T1, T2, T3}, 'location', 'northwest');

saveas(f1, 'figures/fig_ave_wait_time', 'epsc');
saveas(f2, 'figures/fig_ave_pass', 'epsc');
saveas(f3, 'figures/fig_total_wait_time', 'epsc');
saveas(f4, 'figures/fig_total_pass', 'epsc');


