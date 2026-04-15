%% === USER PARAMETERS ===
steering_ratio = 5000/389;   % <-- CHANGE THIS to your system value

%% === LOAD DATA ===
% Works for timeseries or struct format

if isa(out.SW_angle_ws, 'timeseries')
    t_ = out.SW_angle_ws.Time;
    SW = out.SW_angle_ws.Data;
else
    t_ = out.SW_angle_ws.time;
    SW = out.SW_angle_ws.signals.values;
end

if isa(out.RW_angle_ws, 'timeseries')
    RW = out.RW_angle_ws.Data;
else
    RW = out.RW_angle_ws.signals.values;
end

%% === EXPECTED OUTPUT ===
RW_expected = SW / steering_ratio;

%% === ERROR SIGNAL ===
error1 = RW - RW_expected;

%% === METRICS ===

% RMSE
RMSE = sqrt(mean(error1.^2));

% MAE
MAE = mean(abs(error1));

% Max Error
MAX_ERROR = max(abs(error1));

% Steady-State Error (last 5% of samples)
n_sample = length(error1);
steady_state_error = mean(error1(round(0.95*n_sample):end));

% Percentage RMSE (relative to signal magnitude)
RMSE_percent = 100 * RMSE / max(abs(RW_expected));

%% === DISPLAY RESULTS ===
fprintf('\n=== TRACKING PERFORMANCE METRICS ===\n');
fprintf('RMSE              : %.6f\n', RMSE);
fprintf('MAE               : %.6f\n', MAE);
fprintf('Max Error         : %.6f\n', MAX_ERROR);
fprintf('Steady-State Error: %.6f\n', steady_state_error);
fprintf('RMSE (%%)          : %.2f %%\n', RMSE_percent);

%% === PLOTS ===
figure;

subplot(2,1,1);
plot(t_, RW_expected, 'LineWidth', 1.5); hold on;
plot(t_, RW, '--', 'LineWidth', 1.5);
grid on;
legend('Expected RW Angle', 'Actual RW Angle');
title('Angle Tracking');
xlabel('Time (s)');
ylabel('Angle');

subplot(2,1,2);
plot(t_, error1, 'LineWidth', 1.5);
grid on;
title('Tracking Error');
xlabel('Time (s)');
ylabel('Error');
