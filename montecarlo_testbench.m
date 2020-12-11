 close all
 clear
 clc
 Nbits=4; %Numero de bits
 Cu=1; % Capacitancia Unitaria
 sigmaCu=0; % desviacion est�ndar de la capacitancia unitaria
 Vdd=1.8; % Tensi�n de referencia positiva
 Vss=0; % Tensi�n de referencia negativa
 Vcm=(Vdd-Vss)/2 +Vss; %Tension de modo com�n
 montecarloDNL(1,Nbits,Cu,sigmaCu,Vdd, Vss,Vcm);