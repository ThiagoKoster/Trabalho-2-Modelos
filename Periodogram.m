function [a,varu] = Periodogram( signal ,p ,nome)

%Parametros
N = length(signal);
Nfft = 1024;
freq = [0:Nfft-1]'/Nfft -0.5;
%-------------------------------

P_per = (1/N)*abs(fftshift(fft(signal,Nfft))).^2;   %Periodograma

for k=1:p+1
    rX(k,1) = (1/N)*sum(signal(1:N-k+1).*signal(k:N));
end

r=rX(2:p+1);                            %matriz r
for i = 1:p
    for j=1:p
        R(i,j) = rX(abs(i-j) + 1);      %popular matriz R
    end
end

a = inv(R)*r;                           %Equação Yule-Walker
varu = rX(1) -a'*r;                     %Calculo da Variancia de u(n)

den=abs(fftshift(fft([1;-a],Nfft))).^2;     %denominador da eq. de Px(f)
P_AR = varu./den;                           %Modelo AR PSD


figure('Name','Periodograma');
plot(freq,10*log(P_per),'color','b');
title(sprintf('Periodograma de %s',nome));
xlabel('f');
ylabel('10logPx(f)');
hold on;
plot(freq,10*log(P_AR),'LineWidth',3,'color','g');


end
