function Plot_Results(Cu_Mean,sigmaDNL,NBits)
%% Funcion para graficar los resultados del DNL Cu_Mean es un vector fila
% de tamaño 1*Ncu y sigmaDNL es una matriz de tamaño Ncu*Nbits,donde Ncu es 
% el numero de capacitancias unitarias que se encuentren en comparacion y
% Nbits el numero de Bits que se deseen evaluar. Nbits es el vector que
% contiene los Bits que se encuentran en comparacion
limite=ones(1,length(Cu_Mean))*0.16;
figure
Cu_Mean=Cu_Mean*1e15;

plot(Cu_Mean,sigmaDNL,'-o','LineWidth',2,'MarkerSize',5)
xlabel('Capacitancia Unitaria (fF)')
ylabel('DNL')
xlim([min(Cu_Mean)-10 max(Cu_Mean)+10])
hold on
plot(Cu_Mean,limite,'k--','LineWidth',1.5)
Vec=cell(size(NBits));
for count1=1:length(NBits)
    vec=sprintf('%d BITS \n', NBits(count1));
    Vec(count1)={vec};
end
title(legend(Vec),'Numero de Bits')

end
