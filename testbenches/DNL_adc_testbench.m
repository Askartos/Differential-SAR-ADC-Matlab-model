%close all
format long 
addpath(genpath('../functions'));
Nbits=3; %Numero de bits
Cu=35.56e-15; % Capacitancia Unitaria
sigmaCu=0*150.2e-16; % desviacion est�ndar de la capacitancia unitaria
Vdd=1.8; % Tensi�n de referencia positiva
Vss=0; % Tensi�n de referencia negativa
Vcm=(Vdd-Vss)/2+Vss; %Tension de modo com�n
DNLS=ADC_DNL_sweep(Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)
