close all; clear; clc;

DATA_PATH = 'statdata/';
PREFIX = 'cw_';

max_time = 100;
max_episode = 100;
h_speed = 0.2;
c_speed = 0.5;

X = -3:2;
NX = length(X);

LAMBDAS = 10.^X;

H_AVE_TIME = zeros(NX, 1);
C_AVE_TIME = zeros(NX, 1);
H_AVE_PASS = zeros(NX, 1);
C_AVE_PASS = zeros(NX, 1);
T_AVE_TIME = zeros(NX, 1);
T_AVE_PASS = zeros(NX, 1);

for idx = 1:NX
    fprintf("IDX: %d ", idx);
    lambda_h = LAMBDAS(idx);
    lambda_c = LAMBDAS(idx);

    [h_ave_wait_time, c_ave_wait_time, ...
     h_pass_number, c_pass_number, ...
     total_ave_wait_time, total_pass_number] = ...
        car_wait_batch(lambda_h, lambda_c, ...
                           max_time, max_episode, ...
                           h_speed, c_speed);
    H_AVE_TIME(idx) = h_ave_wait_time;
    C_AVE_TIME(idx) = c_ave_wait_time;
    H_AVE_PASS(idx) = h_pass_number;
    C_AVE_PASS(idx) = c_pass_number;
    T_AVE_TIME(idx) = total_ave_wait_time;
    T_AVE_PASS(idx) = total_pass_number;
    
    disp(datestr(now, 'yyyyddmmHHMMSSFFF'));
end

fn = [PREFIX, datestr(now, 'yyyyddmmHHMMSSFFF')]

save([DATA_PATH, fn], ...
    'H_AVE_TIME', 'C_AVE_TIME', ...
    'H_AVE_PASS', 'C_AVE_PASS', ...
    'T_AVE_TIME', 'T_AVE_PASS');

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
legend([ph, pc], {'Humans', 'Cars'});

figure;
ph = semilogx(LAMBDAS, T_AVE_TIME);
xlabel('\lambda');
ylabel('Total wait time');

figure;
ph = semilogx(LAMBDAS, T_AVE_PASS);
xlabel('\lambda');
ylabel('Total throughput');
    