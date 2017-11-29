clear


[y,Fs] = audioread('ss.wav');
fn = 11025;                         %Vamos fazer um downsampling de 11025Hz
[P,Q] = rat(fn/Fs);
y_r = resample(y,P,Q);

sample = 0.02 * fn;                %Começar a amostra de 20 ms
y_r = y_r(sample:sample+441,:);    % Utilizar uma amostra de 40ms do sinal que sofreu downsampling


p=12; % Ordem

tamanho = length(y_r);


[a,varu] = Periodogram(y_r,p);


u = normrnd(0,sqrt(varu),tamanho,2);                       %ruido branco u(n) e variância varu

x = filter(1,[1 -a'],u,[]);                                %gerar o x(n)


                                      
% for n = p+1:tamanho                             %Sem o somatório fica
%                                                 bem mais parecido...
%     for k = 1:p
%         x(n) = a(k)*x(n-k)  + u(n) ;
%     end
% end


figure;
subplot(2,1,1);
plot(x);
subplot(2,1,2);
plot(y_r);



Periodogram(x,p);

figure;
subplot(2,1,1);
plot([1:length(y)]/Fs, y);
xlabel('Tempo (s)');
subplot(2,1,2);
stem(y_r);


