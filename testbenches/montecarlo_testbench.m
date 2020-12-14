 close all
 format long
 addpath(genpath('../functions'));
 Vdd=1.8; % Tensi�n de referencia positiva
 Vss=0; % Tensi�n de referencia negativa
 Vcm=(Vdd-Vss)/2 +Vss; %Tension de modo comun
 Nsamples=200;
 Cu_Mean=[35.56e-15, 54.22e-15, 76.79e-15, 103.3e-15, 133.6e-15, 167.9e-15,...
        206.1e-15, 248.2e-15, 294.2e-15, 344.1e-15, 398e-15, 455.7e-15,...
        517.3e-15, 582.9e-15, 652.3e-15, 725.7e-15];%Vector de medias de Capacitancia Unitaria
 
Cu_Sigma=[154.2e-18, 188e-18, 221.9e-18, 255.7e-18, 289.6e-18 323.5e-18,...
        357.3e-18, 391.2e-18, 425e-18, 458.9e-18, 492.8e-18, 526.6e-18,...
        560.5e-18, 594.3e-18, 628.2e-18, 662.1e-18];%vector de desviacion estandar de la capacitancia unitaria

 NBits=6:7;%Numero de Bits
 uDNL=zeros(length(NBits),length(Cu_Mean));
 sDNL=zeros(length(NBits),length(Cu_Mean));
 for k=1:length(NBits)
 tic
     parfor i=1:length(Cu_Mean)%parallel execution for loop
       [uDNL(k,i),sDNL(k,i)]=montecarloDNL(Nsamples,NBits(k),Cu_Mean(i),Cu_Sigma(i),Vdd, Vss,Vcm);
     end
 toc
 end