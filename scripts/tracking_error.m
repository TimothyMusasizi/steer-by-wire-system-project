% Script: tracking_error

%% === USER PARAMETERS ===
tracking_error_steering_ratio = 5000/389;   % <-- CHANGE THIS to your system value

%% === LOAD DATA ===
% Works for timeseries or struct format

if isa(out.SW_angle_ws, 'timeseries')
    tracking_error_t = out.SW_angle_ws.Time;
    tracking_error_SW = out.SW_angle_ws.Data;
else
    tracking_error_t = out.SW_angle_ws.time;
    tracking_error_SW = out.SW_angle_ws.signals.values;
end

if isa(out.RW_angle_ws, 'timeseries')
    tracking_error_RW = out.RW_angle_ws.Data;
else
    tracking_error_RW = out.RW_angle_ws.signals.values;
end

%% === EXPECTED OUTPUT ===
tracking_error_RW_expected = tracking_error_SW / tracking_error_steering_ratio;

%% === ERROR SIGNAL ===
tracking_error_error = tracking_error_RW - tracking_error_RW_expected;

%% === METRICS ===

% RMSE
tracking_error_RMSE = sqrt(mean(tracking_error_error.^2));

% MAE
tracking_error_MAE = mean(abs(tracking_error_error));

% Max Error
tracking_error_MAX_ERROR = max(abs(tracking_error_error));

% Steady-State Error (last 5% of samples)
tracking_error_n_sample = length(tracking_error_error);
tracking_error_steady_state_error = mean( ...
    tracking_error_error(round(0.95 * tracking_error_n_sample):end) );

% Percentage RMSE (relative to signal magnitude)
tracking_error_RMSE_percent = 100 * tracking_error_RMSE / ...
    max(abs(tracking_error_RW_expected));

%% === DISPLAY RESULTS ===
fprintf('\n=== TRACKING PERFORMANCE METRICS ===\n');
fprintf('RMSE              : %.6f\n', tracking_error_RMSE);
fprintf('MAE               : %.6f\n', tracking_error_MAE);
fprintf('Max Error         : %.6f\n', tracking_error_MAX_ERROR);
fprintf('Steady-State Error: %.6f\n', tracking_error_steady_state_error);
fprintf('RMSE (%%)          : %.2f %%\n', tracking_error_RMSE_percent);

%% === PLOTS ===
figure;

subplot(2,1,1);
plot(tracking_error_t, tracking_error_RW_expected, 'LineWidth', 1.5); hold on;
plot(tracking_error_t, tracking_error_RW, '--', 'LineWidth', 1.5);
grid on;
legend('Expected RW Angle', 'Actual RW Angle');
title('Angle Tracking');
xlabel('Time (s)');
ylabel('Angle');

subplot(2,1,2);
plot(tracking_error_t, tracking_error_error, 'LineWidth', 1.5);
grid on;
title('Tracking Error');
xlabel('Time (s)');
ylabel('Error');