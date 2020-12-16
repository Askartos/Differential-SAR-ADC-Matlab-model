format long
addpath(genpath('../functions'));
Nbits=4; %Numero de bits
Cu=1; % Capacitancia Unitaria
sigmaCu=0; % desviacion est�ndar de la capacitancia unitaria
Vdd=8; % Tensi�n de referencia positiva
Vss=-8; % Tensi�n de referencia negativa
Vcm=(Vdd-Vss)/2 + Vss; %Tension de modo com�n
Vin=12;
VinP=Vin/2  + Vcm
VinN=-Vin/2 + Vcm
cap_banks=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
bits=[1;0;0;0];
vouts=cap_bank_dac(cap_banks,Vdd,Vss,Vcm,VinP,VinN,bits);
vouts
voutp_tp=Vcm-VinP %+ Vdd/2 + Vdd/4 + Vdd/8 + Vdd/16
voutp_tn=Vcm-VinN %+ Vss/2 + Vss/4 + Vss/8 + Vss/16
