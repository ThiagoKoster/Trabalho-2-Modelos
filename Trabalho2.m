clear

[y,Fs] = audioread('ch.wav');
fn = 11025;                         %Vamos fazer um downsampling de 11025Hz
[P,Q] = rat(fn/Fs);
y_r = resample(y,P,Q);

sample = 0.02 * fn;                %Começar a amostra de 20 ms
y_r = y_r(sample:sample+882,:);    % Utilizar uma amostra de 80ms do sinal que sofreu downsampling


p=12; % Ordem

tamanho = length(y_r);

[a,varu] = Periodogram(y_r,p,'Sinal original amostrado');

u = normrnd(0,sqrt(varu),tamanho,1);                       %ruido branco u(n) e variância varu

x = filter(1,[1 -a'],u);                                %gerar o x(n)

audiowrite('Sintetizado.wav',100*x,11025);
audiowrite('Original.wav',100*y_r,11025);
                                      
% for n = p+1:tamanho                             %Sem o somatório fica
%                                                 %bem mais parecido...
%     for k = 1:p
%         x(n) = a(k)*x(n-k)  + u(n) ;
%     end
% end


Periodogram(x,p,'Sinal sintetizado');

figure('Name','Sinal original','NumberTitle','off')
subplot(2,1,1);
plot([1:length(y)]/Fs, y);
title('Sinal Original do fonema "ss"');
ylabel('Amplitude');
xlabel('Tempo (s)');
subplot(2,1,2);
stem(y_r);
title('Trecho amostrado em 11025Hz');
ylabel('Amplitude');
xlabel('n');

figure('Name','Comparação','NumberTitle','off')
hold on;
subplot(2,1,1);
plot(y_r);
title('Sinal Original');
xlabel('n');
ylabel('Amplitude');
hold off;

hold on;

subplot(2,1,2);
plot(x);
title('Sinal Sintetizado');
xlabel('n');
ylabel('Amplitude');
hold off;



