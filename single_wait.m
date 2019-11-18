close all; clear; clc;

% Parameters of humans and cars
MAX_H = 10000;
MAX_C = 10000;

LAMBDA_H = 0.1;
LAMBDA_C = 0.2;

H_GO_TIME = 10;
C_GO_TIME = 2;

% Parameters of simulation
MAX_TIME = 10;

%% Start simulation
h_arr_time = cumsum(exprnd(1/LAMBDA_H, MAX_H, 1));
c_arr_time = cumsum(exprnd(1/LAMBDA_C, MAX_C, 1));

h_idx = 1;
c_idx = 1;
h_last_idx = 1;
c_last_idx = 1;

now_going = 'h';
h_wait = zeros(1, H_GO_TIME);
c_wait = zeros(1, C_GO_TIME);
h_time = zeros(MAX_H, 2);
c_time = zeros(MAX_C, 2);

h_pass = 0;
c_pass = 0;

for time = 1:MAX_TIME
    h_arr = 0;
    c_arr = 0;
    while h_arr_time(h_idx) <= time
        h_wait(1) = h_wait(1) + 1;
        h_time(h_idx, 1) = time;
        h_arr = h_arr + 1;
        h_idx = h_idx + 1;
    end
    while c_arr_time(c_idx) <= time
        c_wait(1) = c_wait(1) + 1;
        c_time(c_idx, 1) = time;
        c_arr = c_arr + 1;
        c_idx = c_idx + 1;
    end
    if sum(h_wait) == 0 && sum(c_wait) ~= 0
        now_going = 'c';
    elseif sum(h_wait) ~= 0 && sum(c_wait) == 0
        now_going = 'h';
    end
    if now_going == 'h'
        h_wait = [0, h_wait(1:end-1)];
        h_pass = h_pass + h_wait(end);
        h_time(h_last_idx : h_idx - 1, 2) = time;
        h_last_idx = h_idx;
    elseif now_going == 'c'
        c_wait = [0, c_wait(1:end-1)];
        c_pass = c_pass + c_wait(end);
        c_time(c_last_idx : c_idx - 1, 2) = time;
        c_last_idx = c_idx;
    end
    fprintf('time: %-5d h: %-3d c: %-3d go: %c\n\n', time, h_arr, c_arr, now_going);
    disp(h_wait);
    disp(c_wait);
end

h_time((h_time(:, 1) ~= 0) & (h_time(:, 2) == 0), 2) = MAX_TIME;
c_time((c_time(:, 1) ~= 0) & (c_time(:, 2) == 0), 2) = MAX_TIME;

h_pass
c_pass

h_time(1:10, :)
c_time(1:10, :)
