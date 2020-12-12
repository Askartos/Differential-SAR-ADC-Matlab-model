 close all
 format long
 Vdd=1.8; % Tensi�n de referencia positiva
 Vss=0; % Tensi�n de referencia negativa
 Vcm=(Vdd-Vss)/2 +Vss; %Tension de modo comun
 Nsamples=10;
 Cu_Mean=[35.56e-15, 54.22e-15, 76.79e-15, 103.3e-15, 133.6e-15, 167.9e-15,...
        206.1e-15, 248.2e-15, 294.2e-15, 344.1e-15, 398e-15, 455.7e-15,...
        517.3e-15, 582.9e-15, 652.3e-15, 725.7e-15];%Vector de medias de Capacitancia Unitaria
 
Cu_Sigma=[154.2e-18, 188e-18, 221.9e-18, 255.7e-18, 289.6e-18 323.5e-18,...
        357.3e-18, 391.2e-18, 425e-18, 458.9e-18, 492.8e-18, 526.6e-18,...
        560.5e-18, 594.3e-18, 628.2e-18, 662.1e-18];%vector de desviacion estandar de la capacitancia unitaria
 
 NBits=(6:14);%Numero de Bits
 uDNL=zeros(1,length(Cu_Mean));
 sDNL=zeros(1,length(Cu_Mean));
 tic
 parfor(i=1:length(Cu_Mean),4)
   [uDNL(i),sDNL(i)]=montecarloDNL(Nsamples,6,Cu_Mean(i),Cu_Sigma(i),Vdd, Vss,Vcm)
 end
 toc
 %[uDNL,sDNL]=montecarloDNL(Nsamples,6,35.56e-15,154.2e-18,Vdd, Vss,Vcm)