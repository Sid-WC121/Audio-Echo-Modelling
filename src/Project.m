clc;
clear all;
close all;

%% TO GENERATE 2 ECHOES OF DELAYS 0.35sec AND 0.65sec WITH A GAIN OF 0.7 AND 0.3

%% READING THE AUDIO
[y, fs] = audioread("countdown.mp3");
p = audioplayer(y, fs);
play(p);
stop(p);

%% VALUES FOR ZEROPADDING
n1 = round(0.35 * fs);  % n1 IS FOR THE NUMBER OF ZEROS TO DELAY THE SIGNAL
n2 = round(0.65 * fs);  % n2 IS FOR THE NUMBER OF ZEROS TO DELAY THE SIGNAL

num1 = [1, zeros(1, n1-1), 0.7];  % 1st echo with delay of 0.35sec and gain 0.7
num2 = [1, zeros(1, n2-1), 0.3];  % 2nd echo with delay of 0.65sec and gain 0.3

NUM = [1, zeros(1, n1), 0.7, zeros(1, n2-n1), 0.3];  % Combined filter coefficients

figure(1)
x1 = filter(num1, 1, y);
subplot(2, 1, 1);
plot(y);
title("Input signal");
xlabel("time");
ylabel("amplitude");

% Save the 1st echoed signal as a WAV file
audiowrite("1st_echoed_signal.wav", x1, fs);

x2 = filter(num2, 1, y);
subplot(2, 1, 2);
plot(x2);
title("2nd echoed signal");
xlabel("time");
ylabel("amplitude");

% Save the 2nd echoed signal as a WAV file
audiowrite("2nd_echoed_signal.wav", x2, fs);

figure(2)
freqz(num1, 1);
title("Spectrum of 1st echoed signal");

figure(3)
pzmap(num1, 1)
title("Pole-Zero map of 1st echoed signal");
 
figure(4)
freqz(num2, 1);
title("Spectrum of 2nd echoed signal");

figure(5)
pzmap(num2, 1);
title("Pole-Zero map of 2nd echoed signal");

figure(6)
x = filter(NUM, 1, y);  % Filtering the signal with the combined filter coefficients
plot(x);
title("Final output signal");
xlabel("time");
ylabel("amplitude");

figure(7)
freqz(NUM, 1);
title("Spectrum of Final output signal");

figure(8)
pzmap(NUM, 1);
title("Pole-Zero map of final output signal");

% Save the output signal as a WAV file
audiowrite("output_signal.wav", x, fs);
