% Visualization of the periodicity assumption held in the DFT

close all;
clear;

% Generate example signal
N = 1000;
xvec = (0:(N-1))/N;
s0 = cos(2*pi*xvec * 1.5 + 15);
s1 =  sin(2*pi*xvec * 4.1);
s = s0+s1; s = s./max(abs(s));

% Plot unperiodic signal
figure('Position',[1,1, 600, 150]);
tcl = tiledlayout(2,1, 'TileSpacing','tight');
nexttile;

t1 = -3; t2=0; t3=1; t4= 4;
plot([t1, t2, xvec, t3, t4], [0,0,s,0,0]); hold on;
title('Non-periodic signal');
yticks([-1, 0, 1]);
ylim([-1, 1])
xticks(-3:4)
xticklabels({'-\infty', '-2', '-1', '0', '1', '2', '3', '+\infty'});

% Plot periodic version
nexttile;
plot([xvec-3, xvec-2, xvec-1, xvec, xvec+1, xvec+2, xvec+3], [s,s,s,s,s,s,s]); hold on;
for i = -2:3
    plot([i, i], [-1, 1], 'k--')
end

title('Periodic signal')
ylabel(tcl, 'Amplitude');
xlabel(tcl, 'Time (s)');
ylim([-1, 1]);
yticks([-1, 0, 1]);
xticks(-3:4)
xticklabels({'-\infty', '-2', '-1', '0', '1', '2', '3', '+\infty'});

exportgraphics(gcf, 'periodic.png');