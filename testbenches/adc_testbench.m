format long 
addpath(genpath('../functions'));
Nbits=5; %Numero de bits
Cu=1; % Capacitancia Unitaria
sigmaCu=0; % desviacion est�ndar de la capacitancia unitaria
Vdd=1.8; % Tensi�n de referencia positiva
Vss=0; % Tensi�n de referencia negativa
Vcm=(Vdd-Vss)/2+Vss; %Tension de modo com�n
LSB=(Vdd-Vss)/(2^(Nbits-1));
Vin=LSB*2;
input_number=(Vin/(Vdd-Vss))*(2^(Nbits-1))
VinP=Vin/2  + Vcm;
VinN=-Vin/2 + Vcm;
cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
BITS=SAR_ADC_signed(Nbits,cap_bank,Vdd, Vss, VinP, VinN, Vcm)
BITS=SAR_ADC(Nbits-1,cap_bank,Vdd, Vss, VinP, VinN, Vcm);
BITS=[Vin<0 BITS] %this its just to get comparable results
recoveredNumber=(1-2*BITS(1))*bits2num(BITS(:,2:Nbits))