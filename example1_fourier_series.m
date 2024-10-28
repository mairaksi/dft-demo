% 3D view demo of the Fourier Series
% Plots cumulatively indiviudal figures based on the provided frequencies and
% amplitudes.

close all;
clear;

N = 1024;  % Segment length
D = dftmtx(N);  % Get DFT matrix for length N
fs = 1024;

% Specify sine wave frequencies and amplitudes for the frequencies

freqs = [4, 12, 20, 28];
amps = [1, 0.33, 0.2, 1/7];

% Loop through all frequencies an plot cumulative signal
for j = 1:length(freqs)

    % Initialize figure
    figure('Position',[1,1,800,250]);
    plot3(nan, nan, nan); hold on;
    cm = colormap('lines');
    sig = zeros(N, 1);
    for i = 1:j  % Loop through all cumulative harmonics

        [aux, t] = sine_generator(freqs(i), fs, N, 90);
        sig_aux(:, i) = amps(i)*aux(:);


        sig = sig + sig_aux(:, i);

        fvec = (0:N-1)/N * fs;  % Initialize frequency domain vector
        Fsig = D*sig(:) / N;  % Compute the DFT + scale with N

        fvec = fvec(1:40);   % Take only 40 first coefficients for visual clarity
        Fsig = Fsig(1:40);


        [~, Is] = min(abs(fvec(:) - freqs), [], 1);  % Compute the frequency domain axis bin closest to current component

        plot3(fvec(Is(i))*ones(size(t)), t, sig_aux(:, i), 'LineWidth',1.5, 'Color',cm(i+1,:)); hold on;

        xlabel('Frequency (Hz)')

        ylabel('Time (s)')
        zlabel('Amplitude')
        xlim tight


        grid on
        view(-45, 45)

    end

    %%% Plot the square wave + axis
    sig0 = pi/4 * repmat([-1*ones(1, fs/(freqs(1)*2)), 1*ones(1, fs/(freqs(1)*2))], 1, 4);
    plot3(0*ones(size(t)), t, sig0, 'k--', 'LineWidth',1)

    plot3(fvec,0*ones(size(fvec)), 2*abs(Fsig), 'Color',cm(1,:).^2, 'LineWidth',3);
    plot3(0*ones(size(t)), t, sig, 'Color', cm(1,:), 'LineWidth',3); hold on;
    plot3([0, 0], [0, 0], [-1, 1], 'k-', 'LineWidth',0.5);
    plot3([0, fvec(end)], [0, 0], [1, 1], 'k-', 'LineWidth',0.5);
    plot3([0, 0], [0, 1], [1, 1], 'k-', 'LineWidth',0.5);

    exportgraphics(gcf, ['ft3d_' num2str(j) '.png'])
end


% Plot initial figure with the square wave
figure('Position',[1,1,800,250]);
plot3(nan, nan, nan); hold on;
plot3(0*ones(size(t)), t, sig0, 'k--', 'LineWidth',1)
plot3([0, 0], [0, 0], [-1, 1], 'k-', 'LineWidth',0.5);
plot3([0, fvec(end)], [0, 0], [1, 1], 'k-', 'LineWidth',0.5);
plot3([0, 0], [0, 1], [1, 1], 'k-', 'LineWidth',0.5);
plot3(fvec,0*ones(size(fvec)), 0*abs(Fsig), 'Color',cm(1,:).^2, 'LineWidth',3);

xlabel('Frequency (Hz)')

ylabel('Time (s)')
zlabel('Amplitude')
xlim tight

grid on
view(-45, 45)
exportgraphics(gcf, 'ft3d_0.png')



%%% Helper function to generate sinewaves;
% In: (N samples, frequency f, sampling frequency fs, phase alpha)
% Out: sig_out [1xN] signal; t timestamp
function [sig_out, t] = sine_generator(f, fs, N, alpha)
alpha_rad = alpha * pi/180;
t = (0:N-1)/fs;
sig_out = cos(2*pi*f*t + alpha_rad);
end

