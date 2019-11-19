close all; clear; clc;

% Parameters of humans and cars
MAX_H = 10000;
MAX_C = 10000;

LAMBDA_H = 0.1;
LAMBDA_C = 0.2;

H_SPEED = 0.2;
C_SPEED = 0.5;

% Parameters of simulation
MAX_TIME = 1000;

%% Star simulation

h_arr = poissrnd(LAMBDA_H, MAX_TIME, 1);
c_arr = poissrnd(LAMBDA_C, MAX_TIME, 1);

h_total = sum(h_arr);
c_total = sum(c_arr);

h_stage = zeros(h_total + 1, MAX_TIME + 1) - 1;
c_stage = zeros(c_total + 1, MAX_TIME + 1) - 1;
h_idx = 0;
c_idx = 0;
h_leave_idx = 0;
c_leave_idx = 0;

move_side = 'h';

for time = 1:MAX_TIME
    h_new = h_arr(time);
    c_new = c_arr(time);
    h_stage(h_idx + 1 : h_idx + h_new, time:end) = 0;
    c_stage(c_idx + 1 : c_idx + c_new, time:end) = 0;
    h_idx = h_idx + h_new;
    c_idx = c_idx + c_new;
    h_onroad = h_stage(h_leave_idx + 1 : h_idx, time);
    c_onroad = c_stage(c_leave_idx + 1 : c_idx, time);
    
    if isempty(h_onroad) && ~isempty(c_onroad)
        move_side = 'c';
    elseif ~isempty(h_onroad) && isempty(c_onroad)
        move_side = 'h';
    end
    
    if move_side == 'h'
        h_stage(h_leave_idx + 1 : h_idx, time + 1) = h_onroad + H_SPEED;
        while h_stage(h_leave_idx + 1, time + 1) >= 1
            h_stage(h_leave_idx + 1, time + 2 : end) = -2;
            h_leave_idx = h_leave_idx + 1;
        end
    elseif move_side == 'c'
        c_stage(c_leave_idx + 1 : c_idx, time + 1) = c_onroad + C_SPEED;
        while c_stage(c_leave_idx + 1, time + 1) >= 1
            c_stage(c_leave_idx + 1, time + 2 : end) = -2;
            c_leave_idx = c_leave_idx + 1;
        end
    end
    
    fprintf('T: %-5d H: %-3d C: %-3d\n', time, h_new, c_new);
end

h_stage = h_stage(1:end-1, :);
c_stage = c_stage(1:end-1, :);

%% Statistics

h_wait_time = sum(h_stage == 0, 2) - 1;
c_wait_time = sum(c_stage == 0, 2) - 1;

h_ave_wait_time = mean(h_wait_time);
c_ave_wait_time = mean(c_wait_time);
if isnan(h_ave_wait_time)
    h_ave_wait_time = 0;
end
if isnan(c_ave_wait_time)
    c_ave_wait_time = 0;
end

h_pass_number = sum(h_stage >= 1, 1:2);
c_pass_number = sum(c_stage >= 1, 1:2);

% h_stage
% c_stage
% h_wait_time
% c_wait_time

h_ave_wait_time
c_ave_wait_time

h_pass_number
c_pass_number




