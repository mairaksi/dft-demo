%%% Visualization of a speech signal segment of the vowel '/a/' in
% 1) Time-domain
% 2) Frequency domain (direct form spectrum)
% 3) Frequency domain (magnitude specturm)
% 4) Frequency domain (phase spectrum)

close all;
clear;

load('example_frame.mat');
starts = [1, 30];  % Specify the starting indices for the signal segments
winlen = 512; % Window length (samples)

% Plot as many figures as there are starting points
for i = 1:length(starts)
    start = starts(i);
    sig = frame(start:start+winlen-1)*5;  % Scale with for visualization

    % Initialize figure
    xres=400;
    yres = 600;
    lw=2;
    fig = figure('Position',[1,1,xres, yres]);

    % Plot time-domain signal
    tcl = tiledlayout(4,1);  
    tcl.TileSpacing = 'compact';
    nexttile;

    t = (0:(length(sig)-1))/fs * 1000;  % Timestamp vector
    plot(t, sig, 'LineWidth',lw);

    xlabel('Time (ms)');
    ylabel('Amplitude');
    xlim tight
    ylim tight;
    title('Time domain')

    % Plot direct form frequency-domain signal
    nexttile;
    N = length(sig);
    D = dftmtx(N);  % Get DFT matrix

    fvec = (0:N-1)/N * fs;
    Fsig = D*sig(:) / N;  % Compute the DFT

    plot(fvec, real(Fsig),'LineWidth',lw); hold on;
    plot(fvec, imag(Fsig),'LineWidth',lw);

    legend({'Real part', 'Imaginary part'},  'Location','northeast','Orientation','horizontal');
    xlabel('Frequency (Hz)')
    ylabel('Amplitude')
    xlim([0, 2000]);
    ylim([-0.15, 0.15]);
    title('Frequency domain - Direct form spectrum')

    % Plot magnitude spectrum
    nexttile
    plot(fvec, (abs(Fsig)),'LineWidth',lw);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude')
    xlim([0, 2000]);
    ylim([0, 0.15]);
    title('Frequency domain - Magnitude spectrum')

    % Plot phase spectrum
    nexttile
    plot(fvec, 180/pi * angle(Fsig),'LineWidth',lw);
    xlabel('Frequency (Hz)');
    ylabel('Phase (deg)')
    xlim([0, 2000]);
    ylim([-180, 180]);
    yticks([-180, 0, 180]);
    title('Frequency domain - Phase spectrum')

    exportgraphics(gcf, ['spectrum_' num2str(i) '.png'])
end

