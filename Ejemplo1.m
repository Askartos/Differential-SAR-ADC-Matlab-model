Nbits=5; %Numero de bits
Cu=103-12; % Capacitancia Unitaria
Ocu=10e-3; % desviacion estándar de la capacitancia unitaria
Nsample=200; %Numero de muestras
Vee=15; % Tensión de referencia positiva
Vss=-15; % Tensión de referencia negativa
Vcm=0; %Tension de modo común
Vdif=Vee-Vss; %Tension diferencial
VinP=2;
VinN=-2;

[BITS]=SAR_ADC(Nbits,Cu,Ocu,Nsample,Vee, Vss, VinP, VinN, Vcm,Vdif);