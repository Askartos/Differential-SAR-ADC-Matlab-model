close all
format long

addpath(genpath('../functions'));
load("../mat_files/sDNL_uDNL_mix.mat");

Cu_L=(4e-6:1e-6:19e-6);%Vector de longitudes de los capacitores caracterizados
Cu_Area=Cu_L.^2;%Vector de areas de cada capacitancia unitaria

Cu_Mean=[35.56e-15, 54.22e-15, 76.79e-15, 103.3e-15, 133.6e-15, 167.9e-15,...
        206.1e-15, 248.2e-15, 294.2e-15, 344.1e-15, 398e-15, 455.7e-15,...
        517.3e-15, 582.9e-15, 652.3e-15, 725.7e-15];%Vector de medias de Cu
 
Cu_Sigma=[154.2e-18, 188e-18, 221.9e-18, 255.7e-18, 289.6e-18 323.5e-18,...
        357.3e-18, 391.2e-18, 425e-18, 458.9e-18, 492.8e-18, 526.6e-18,...
        560.5e-18, 594.3e-18, 628.2e-18, 662.1e-18];%vector de sigma Cu
    
k=1.3806e-23;%constante de boltzman
T=273.15+50;%Temperatura (50�C)
Vdd=1.8;%Tension de referencia positivo
Vss=0;% Tension de referencia negativa
NBits=(6:14);%Numero de Bits en los que se desee evaluar
LSB=(Vdd-Vss)./(2.^NBits);%Delta de paso segun el numero de Bits
Sigma_Mean=Cu_Sigma./Cu_Mean;%Relaci�n entre el Sigma y la media de los capacitores caracterizados
Var1=(NBits-1)/2;%Vector relacionado con Nbits para calcular sigmaDNL
sigmaDNL=zeros(length(Sigma_Mean),length(NBits));%Vector en el que se registraran los valores de sigma DNL (varia con Nbits y con cada Cu)
Ch_Area=zeros(length(NBits),length(Sigma_Mean));%Vector en el que se registran los valores de cada area de dependiendo del numero de Bits
AREA=zeros(2,length(NBits));%Vector para almacenar el area minima necesaria en cada numero de Bits para cumplir con el criterio de los 3 sigmas

ChMin=24*(k*T)./(LSB.^2);%Capacitacia de hold minima para cada numero de Bits
CuMin=ChMin./(2.^NBits);%Capacitancia minima para

%%Calculo de DNL y de Areas, dependiendo de cada capacitancia, cada
%numero de Bits
for count1=1:length(NBits)
    sigmaDNL(:,count1)=(2.^Var1(count1)).*Sigma_Mean;
    Ch_Area(count1,:)=Cu_Area*2.^NBits(count1);
    for count2=1:length(Cu_Mean)
        if(sigmaDNL(count2,count1)<0.16)
            AREA(1,count1)=Ch_Area(count1,count2);
            break; 
        end 
    end
    
    for count2=1:length(Cu_Mean)
        if(sDNL(count2,count1)<0.16)
            AREA(2,count1)=Ch_Area(count1,count2);
            break; 
        end 
    end
end

%Impresion de resultados de sigmaDNL
Plot_Results(Cu_Mean,sigmaDNL,NBits);
title('Virtuoso Sigma DNL Vs C_u_n_i_t')
Plot_Results(Cu_Mean,sDNL,NBits);
title('Matlab model Sigma DNL Vs C_u_n_i_t')

%Impresion de reusltados de area, para todos Nbits, y todas las Cunitarias
figure
plot(NBits,Ch_Area*1e12,'-o','LineWidth',3,'MarkerSize',5)
%ax.XAxis.Exponent = -15;
gca.YAxis.Exponent = -12;
xlabel('Number of Bits')
ylabel('Capacitors Area [u^2 m]')
title(legend('4u','5u','6u','7u','8u','9u','10u','11u','12u','13u','14u','15u','16u','17u','18u','19u','Location','northwest'),'Capacitor lengths')
title('Capacitors Area Vs Number of Bits')

%Impresion de la curva del area minima para cada numero de BITS
figure
semilogy(NBits,AREA*1e12,'-o','LineWidth',3,'MarkerSize',5)
gca.YAxis.Exponent = -12;
xlabel('Number of Bits')
ylabel('Capacitors Area [um^2]')
gca.FontSize = 20;
legend('Virtuoso model', 'Matlab model','Location','northwest')
title('Minimum Area Vs Number of Bits')

figure
semilogy(NBits, ChMin*1e15,'b-*','LineWidth',3,'MarkerSize',5)
hold on
Cu_sigma=[35.56e-15 35.56e-15 35.56e-15 35.56e-15 35.56e-15 35.56e-15 54.22e-15 103.3e-15 206.1e-15];
Ch_sigma=(2.^(6:14)).*Cu_sigma;
semilogy(NBits, Ch_sigma*1e15,'-*','Color',[39/255 119/255 20/255],'LineWidth',3,'MarkerSize',5)
xlabel('Number of Bits')
ylabel('Minimum sampling capacitance [fF]')
title('Minimum sampling capacitance Vs Number of Bits')
legend('Noise based equation','3σDNL','Location','northwest')
figure 
bar(NBits, log(ChMin*1e18))
xlabel('Number of Bits')
ylabel('Minimum sampling capacitance [fF]')
title('Minimum sampling capacitance Vs Number of Bits')
