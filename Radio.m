clc
clear
close all

txt_file = fopen('input.txt', 'r');
data = fscanf(txt_file, '%f');
Length_Data=length(data);

spectrum_data=fft(data);

F_sampling=480000;

figure
plot([1:Length_Data],fft(data));

for i=1:4

    channel = input('Ava=1  /  Eghtesad=2  /  Goftogo=3  /  Farhang=4 :');
    if channel==1
        Fc=96000;
    elseif  channel==2
        Fc=144000;
    elseif  channel==3
        Fc=288000;
    elseif  channel==4
        Fc=240000;
    end
    
    signal=zeros(Length_Data,1);
    signal((Fc-10000)*Length_Data/F_sampling:(Fc+10000)*Length_Data/F_sampling)=spectrum_data((Fc-10000)*Length_Data/F_sampling:(Fc+10000)*Length_Data/F_sampling);
    signal(Length_Data-(Fc+10000)*Length_Data/F_sampling:Length_Data-(Fc-10000)*Length_Data/F_sampling)=spectrum_data(Length_Data-(Fc+10000)*Length_Data/F_sampling:Length_Data-(Fc-10000)*Length_Data/F_sampling);
    figure
    plot([1:Length_Data],signal);
    
    cartier=-cos(2*pi*(Fc/F_sampling)*(1:Length_Data))';
    signal=ifft(signal);
    signal=signal.*cartier;
    signal=fft(signal);
    figure
    plot([1:Length_Data],signal);
    
    signal(10000*Length_Data/F_sampling:Length_Data-10000*Length_Data/F_sampling)=0;
    figure
    plot([1:Length_Data],signal);
    
    signal=ifft(signal);
    signal=signal-mean(signal);
    signal=signal/max(abs(signal));
    signal=2*real(signal(1:10:Length_Data));
    sound(signal,F_sampling/10);
    
end