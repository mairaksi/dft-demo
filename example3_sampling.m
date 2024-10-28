% Example of sampling in time domain

close all;
clear;

% Specify sampling intervals (in samples)
Ts = [10; 20; 50; 100];

% Generate example signal s
N = 1000;
xvec = (0:(N-1))/N;
s0 = cos(2*pi*xvec * 1.5);
s1 =  sin(2*pi*xvec * 4.1);
s = s0+s1; s = s./max(abs(s));

% Plot unsampled figure
figure('Position',[1,1, 800, 100]);
plot(xvec, s); hold on;

ylabel('Amplitude');
xlabel('Time (s)');
title('Continuous signal');
yticks([-1, 0, 1]);
xlim([0, 1]);
ylim([-1.1, 1.1])
exportgraphics(gcf, ['sampling_0.png']);


% Plot sampled versions
for i = 1:length(Ts)
    T = Ts(i);
    figure('Position',[1,1, 800, 100]);

    plot(xvec, s); hold on;
    iT = T:T:(N-1);
    stem(xvec(iT), s(iT));

    % Compute sampling frequency
    fs = N/T;
    ts = (1/fs) * 1000;

    yticks([-1, 0, 1]);
    xlim([0, 1]);
    ylim([-1.1, 1.1])
    ylabel('Amplitude');
    xlabel('Time (s)');
    title(['Fs = ' num2str(fs) ' Hz']);
    exportgraphics(gcf, ['sampling_' num2str(i) '.png']);

end