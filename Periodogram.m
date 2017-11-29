function [a,varu] = Periodogram( signal ,p )

N = length(signal);
Nfft = 1024;
freq = [0:Nfft-1]'/Nfft -0.5;
P_per = (1/N)*abs(fftshift(fft(signal,Nfft))).^2;

for k=1:p+1
    rX(k,1) = (1/N)*sum(signal(1:N-k+1).*signal(k:N));
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


end
