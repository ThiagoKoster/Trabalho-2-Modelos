clear

[y,Fs] = audioread('ss.wav');       %Carregar o sinal original
fn = 11025;                         %Vamos fazer um downsampling de 11025Hz
[P,Q] = rat(fn/Fs);                 %pois o sinal foi gravado em 44100Hz
y_r = resample(y,P,Q);



p=12;                               %numero de polos do filtro

tamanho = length(y_r);

[a,varu] = Periodogram(y_r,p,'Sinal original amostrado'); %Gerar periodograma do sinal original amostrado

u = normrnd(0,sqrt(varu),tamanho,1);                    %ruido branco u(n) e variância varu

x = filter(1,[1 -a'],u);                                %gerar o x(n)




audiowrite('Sintetizado.wav',x,11025);                 %gravar sinal gerado
audiowrite('Original.wav',y_r,11025);                  %gravar sinal original
                                      


Periodogram(x,p,'Sinal sintetizado');                  %Gerar periodograma do sinal sintetizado


%Figuras adicionais%

%Sinal original e sinal original amostrado %
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

%Sinal original e sinal sintetizado no tempo
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



