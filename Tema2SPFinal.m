close all
clear all
clc

P=40; %perioada
D=17; %durata din perioada in care semnalul e 1
N=50; %numarul de coeficienti Fourier
f=1/P; %frecventa semnalului
w=2*pi*f; %frecventa normata
r=4*f; %rezolutia semnalului

s1=[ones(1,D/r),zeros(1,(P-D)/r)]; %o perioada din semnalul dreptunghiular
t=0:r:P; %timpul echivalent petru o perioada
perioada=P/r;%cate esantioane avem intr-o perioada
inter1=0:r:P;
stem(inter1(1:400),s1)
title('O perioada din semnalul dreptunghiular')
xlabel('Timp [secunde]')
ylabel('Amplitudine')

semnal=repmat(s1,1,5);%repetam semnalul initial de 5 ori
figure
plot(semnal)
title('5 perioade din semnal')
xlabel('Timp [secunde]')
ylabel('Amplitudine')

%calculam coeficientii Xk corespunzatori seriei Fourier Complexa
xk=zeros(1,2*N+1);
for m=-N:1:N
    for l=1:1:perioada
    xk(m+N+1)= xk(m+N+1)+semnal(l)*exp(-1i*m*w*t(l));
    end
end
figure
stem((-N:N),abs(xk))
title('Spectrul semnalului') 
s_rec=zeros(1,perioada); %initializam semnalul ce va fi reconstruit
for l=1:1:perioada
    for m=-N:1:N
        s_rec(l)= s_rec(l)+xk(m+N+1)*exp(1i*m*w*t(l));
    end
end
s_rec=s_rec/perioada;%normam semnalul reconstruit
figure
plot(real(s_rec))
hold on
plot(s1,'color','g')
title('Semnalul initial cu verde, semnalul reconstruit cu albastru')