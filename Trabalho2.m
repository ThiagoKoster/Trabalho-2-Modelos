clear


[y,Fs] = audioread('ss.wav');
fn = 11025;                         %Vamos fazer um downsampling de 11025Hz
[P,Q] = rat(fn/Fs);
y_r = resample(y,P,Q);

sample = 0.02 * fn;                %Come�ar a amostra de 20 ms
y_r = y_r(sample:sample+441,:);    % Utilizar uma amostra de 40ms do sinal que sofreu downsampling


p=12; % Ordem

[Ac,E] = lpc(y_r,p);

est_y = filter([0 -Ac(2:end)],1,y_r);
e = y_r - est_y;
[acs,lags] = xcorr(e,'coeff');


a_yk = aryule(acs,p);                        %talvez sejam j� os coeficientes a??


tamanho = 8000;

u = wgn(tamanho,1,0);                           %ruido branco U(n) tamanho 1000

x = wgn(tamanho,1,0);                           %gerar o X(n)

for n = 13:tamanho
    for k = 1:p
        x(n) = a_yk(k)*x(n-k) + u(n);
    end
end

figure;
subplot(2,1,1);
plot(x);
subplot(2,1,2);
plot(y);



figure;
hold on;
h1 = plot([1:length(y_r)],y_r,[1:length(y_r)],est_y);
xlabel 'Sample number', ylabel 'Amplitude';
legend({'Original signal','LPC estimate'});
hold off;
title 'Original Signal vs. LPC Estimate';


Periodogram(y_r,p);

Periodogram(x,p);

figure;
subplot(2,1,1);
plot([1:length(y)]/Fs, y);
xlabel('Tempo (s)');
subplot(2,1,2);
stem(y_r);


