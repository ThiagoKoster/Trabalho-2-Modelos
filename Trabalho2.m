[y,Fs] = audioread('ss.wav');
fn = 11025;                         %Vamos fazer um downsampling de 11025Hz
[P,Q] = rat(fn/Fs);
y_r = resample(y,P,Q);

sample = 0.02 * fn;                %Começar a amostra de 20 ms
y_r = y_r(sample:sample+441,:);    % Utilizar uma amostra de 40ms do sinal que sofreu downsampling



%Figura 18.12 do artigo %

N = length(y_r);
Nfft = 1024;
freq = [0:Nfft-1]'/Nfft -0.5;
P_per = (1/N)*abs(fftshift(fft(y_r,Nfft))).^2;
p = 12;
for k=1:p+1
    rX(k,1) = (1/N)*sum(y_r(1:N-k+1).*y_r(k:N));
end
r=rX(2:p+1);
for i = 1:p
    for j=1:p
        R(i,j) = rX(abs(i-j) + 1);
    end
end

a = inv(R)*r;
varu = rX(1) -a'*r;
den=abs(fftshift(fft([1;-a],Nfft))).^2;
P_AR = varu./den;

figure;
plot(freq,10*log(P_per),'color','b');
hold on;
plot(freq,10*log(P_AR),'LineWidth',3,'color','g');

%End figura 18.12%

figure;
subplot(2,1,1);
plot([1:length(y)]/Fs, y);
xlabel('Tempo (s)');
subplot(2,1,2);
stem(y_r);


