close all
clear
format long

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
AREA=zeros(1,length(NBits));%Vector para almacenar el area minima necesaria en cada numero de Bits para cumplir con el criterio de los 3 sigmas

ChMin=(k*T)./(LSB.^2);%Capacitacia de hold minima para cada numero de Bits
CuMin=ChMin./(2.^NBits);%Capacitancia minima para

%%Calculo de DNL y de Areas, dependiendo de cada capacitancia, cada
%numero de Bits
for count1=1:length(NBits)
    sigmaDNL(:,count1)=(2.^Var1(count1)).*Sigma_Mean;
    Ch_Area(count1,:)=Cu_Area*2.^NBits(count1);
    ban1=1;
    for count2=1:length(Cu_Mean)
        if(sigmaDNL(count2,count1)<0.166)
            AREA(1,count1)=Ch_Area(count1,ban1);
            count2=length(Cu_Mean);
        else
        ban1=ban1+1;  
        end 
    end
end

%Impresion de resultados de sigmaDNL
Plot_Results(Cu_Mean,sigmaDNL,NBits);

%Impresion de reusltados de area, para todos Nbits, y todas las Cunitarias
figure
plot(NBits,Ch_Area*1e12,'-o','LineWidth',3,'MarkerSize',5)
%ax.XAxis.Exponent = -15;
gca.YAxis.Exponent = -12;
xlabel('N�mero de BITS')
ylabel('Area de los Capacitores [u^2 m]')
title(legend('4u','5u','6u','7u','8u','9u','10u','11u','12u','13u','14u','15u','16u','17u','18u','19u','Location','northwest'),'Longitud de C')
title('Area de los capacitores Vs Numero de Bits')

%Impresion de la curva del area minima para cada numero de BITS
figure
plot(NBits,AREA*1e12,'-o','LineWidth',3,'MarkerSize',5)
gca.YAxis.Exponent = -12;
xlabel('N�mero de BITS')
ylabel('Area de los Capacitores [u^2 m]')
title('Area minima Vs Numero de Bits')
