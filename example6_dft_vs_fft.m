%%% Simulation of the computational time for naive DFT vs FFT at increasing
%%% N
N = [32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384];

Niter = 10;  % How many iterations to simulate;
times = zeros(length(N), Niter);  % Initialize result matrix for DFT
times2 = zeros(length(N), Niter);  % Initialize result matrix for FFT

for i = 1:length(N)
    D = dftmtx(N(i));  % Get DFT matrix
    sig = randn(N(i), 1);  % Get random N-length signal
    for n = 1:Niter
        tic;
        Fsig = D*sig;  % Naive form computation
        times(i, n) = toc;

        tic;
        Fsig2 = fft(sig);  % FFT computation
        times2(i, n) = toc;
    end
end

times = mean(times, 2);  % Get mean times over iterations
times2 = mean(times2, 2);


% Plot results
figure();
tcl = tiledlayout(2,1, "TileSpacing",'compact');
nexttile;
plot((times)); hold on;
plot((times2));
xticks(1:length(N));
xticklabels(N);
ylabel('Computation time (s)')
xlabel('N')
legend({'Naive DFT', 'FFT'}, 'Location','northwest')

nexttile;
plot((times./times2));
ylabel('Efficiency ratio')
xlabel('N');
xticks(1:length(N));
xticklabels(N);