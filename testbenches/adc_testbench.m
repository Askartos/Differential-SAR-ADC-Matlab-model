format long 
addpath(genpath('../functions'));
Nbits=4; %Numero de bits
Cu=1; % Capacitancia Unitaria
sigmaCu=0; % desviacion est�ndar de la capacitancia unitaria
Vdd=1.8; % Tensi�n de referencia positiva
Vss=0; % Tensi�n de referencia negativa
Vcm=(Vdd-Vss)/2+Vss; %Tension de modo com�n
LSB=(Vdd-Vss)/(2^(Nbits-1));
input_number=5
Vin=LSB*input_number;
VinP=Vin/2  + Vcm;
VinN=-Vin/2 + Vcm;
cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];

BITS=SAR_ADC_signed(Nbits,cap_bank,Vdd, Vss, VinP, VinN, Vcm)
recoveredNumber_signed=(1-2*(~BITS(1)))*bits2num(BITS(:,2:Nbits))
Vin=LSB*input_number;
VinP=Vin/2  + Vcm;
VinN=-Vin/2 + Vcm;
BITS=SAR_ADC(Nbits-1,cap_bank,Vdd, Vss, VinP, VinN, Vcm)
recoveredNumber=bits2num(BITS)