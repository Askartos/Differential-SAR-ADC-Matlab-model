 close all
 %clear
 %clc
 format long
 Nbits=4; %Numero de bits
 Cu=48*(10^-15); % Capacitancia Unitaria
 sigmaCu=300*(10^-18); % desviacion est�ndar de la capacitancia unitaria
 Vdd=1.8; % Tensi�n de referencia positiva
 Vss=0; % Tensi�n de referencia negativa
 Vcm=(Vdd-Vss)/2 +Vss; %Tension de modo com�n
 Nsamples=200;
 [uDNL,sDNL]=montecarloDNL(Nsamples,Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)