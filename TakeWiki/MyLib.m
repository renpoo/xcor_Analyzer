function H = MyFreqs(b, a, Ft)
    Fn = Ft/2;
	w = linspace(0, 2*pi*Fn, 512);
	f = w/(2*pi);
	% アナログフィルターの周波数特性を取得
	H = freqs(b, a, w);
	% プロット
	figure; 
	subplot(2, 1, 1);
	plot(f, abs(H));
	grid on;
	title('Filter response')
	xlabel('Frequency(Hz)')
	ylabel('Magnitude')
	
	subplot(2, 1, 2);
	plot(f, angle(H)*180);
	grid on
	xlabel('Frequency(Hz)')
	ylabel('Phase(degree)')
endfunction

function [H, W] = MyFreqz(b, a, Ft)
	[H, W] = freqz(b, a, 512, "half", Ft);
	Fn = Ft/2;
	w = linspace(0, 2*pi*Fn, 512);
	f = w/(2*pi);
	figure; 
	subplot(2, 1, 1);
	plot(f, abs(H));
	grid on;
	title('Filter response')
	xlabel('Frequency(Hz)')
	ylabel('Magnitude')
	
	subplot(2, 1, 2);
	plot(f, angle(H)*180);
	grid on
	xlabel('Frequency(Hz)')
	ylabel('Phase(degree)')
endfunction

function MySpectGram(sig, Fs)
	% ノイズ信号の周波数応答の表示
	figure
	subplot(2,1,1)
	[s1, f1] = periodogram(sig, hamming(length(sig)), length(sig), Fs);
	plot(f1, 20*log10(s1),'m-.'),grid
	xlim([0 f1(end)])
	title('Periodogram'),xlabel('Frequency(Hz)'),ylabel('Power/Frequency（dB/Hz）')
	subplot(2,1,2)
	specgram(sig, 512, Fs, hamming(512), 256)
	title('Spectrogram'),xlabel('Frequency(Hz)'),ylabel('Time(sec)')
endfunction
