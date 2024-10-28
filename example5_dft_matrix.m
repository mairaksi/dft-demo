%%% Image visualization of the DFT matrix 

close all;
clear;

% Specify which Ns are to be plotted
Ns = [4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096];

for i = 1:length(Ns)
N = Ns(i);

D = dftmtx(N);  % Get DFT matrix
iD = 1/N * conj(D);  % Get inverse transform matrix


figure('Position',[1,1,600, 900]);
tcl = tiledlayout(3,2);
tcl.TileSpacing = 'compact';

nexttile;
plotmtx((real(D)+1)*255/2);
axis equal
title('Real(D)')

nexttile;
plotmtx((imag(D)+1)*255/2)
axis equal
title('Imag(D)')

nexttile;
plotmtx(abs(D)*255);
axis equal
title('Abs(D)')

nexttile;
plotmtx((angle(D)/pi +1)*255/2)
axis tight;
axis equal
title('Angle(D)')


% Show that the inverse transform is perfect reconstruction:
nexttile;
plotmtx(real(iD*D)*255);
axis equal
title('Real(D^{-1} * D)')

nexttile;
plotmtx(imag(iD*D)*255)
axis equal
title('Imag(D^{-1} * D)')

title(tcl, ['DFT Matrix (D) and its inverse (D^{-1}), N=' num2str(N)]);
ylabel(tcl, 'k = 1\ldotsN')
xlabel(tcl, 'n = 1\ldotsN');

exportgraphics(gcf, ['ex2_dftmtx_' num2str(N) '.png']);

end



function plotmtx(M)
   image(M);
   axis equal;
   axis tight;
end
