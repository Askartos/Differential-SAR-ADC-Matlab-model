function [BITS_vector]=montecarloDNL(Nsample,Nbits,Cu,sigmaCu,Vdd, Vss,Vin)
 Vcm=(Vdd-Vss)/2; %Tension de modo comun
    for count1=1:Nsample
        for count2=1:(Vin*10)
            VinP=count2/20  + Vcm;%entrada en el +
            VinN=-count2/20 + Vcm;%entrada en el -
            [BITS]=SAR_ADC(Nbits,Cu,sigmaCu,Vdd, Vss, VinP, VinN, Vcm);
            BITS_vector(count2,:)=BITS;
            inldnl(BITS,count2/10,[0 1.8],'ADC','GenPlotData','on','INLMethod','All','DNLMethod','All')
        end
    end
end