close all
format long 
addpath(genpath('../functions'));
Nbits=6; %Numero de bits
Cu=35.56e-15; % Capacitancia Unitaria
sigmaCu=60*154.2e-18; % desviacion est�ndar de la capacitancia unitaria
Vdd=1.8; % Tensi�n de referencia positiva
Vss=0; % Tensi�n de referencia negativa
Vcm=(Vdd-Vss)/2+Vss; %Tension de modo com�n
DNLS=ADC_DNL_sweep(Nbits,Cu,sigmaCu,Vdd, Vss,Vcm);
figure
stem(abs(DNLS),'LineWidth',2,'Color',[0.7 0.4 0.6]);
xlabel("Digital word");
ylabel("DNL");
title("Digital word vs DNL");
xlim([0,64]);