function DNLS=ADC_DNL_sweep(Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)
format long
    substeps=200;
    LSB=(Vdd-Vss)/(2^Nbits);
    delta=LSB/substeps;    
    Vin_vector=0:delta:(2^(Nbits)-1)*LSB;
    cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
    Vout_vector=zeros(length(Vin_vector),1);
    for step=1:length(Vin_vector)
        VinP=Vin_vector(step)/2  + Vcm;
        VinN=-Vin_vector(step)/2 + Vcm;
        BITS=SAR_ADC(Nbits,cap_bank,Vdd, Vss, VinP, VinN, Vcm);
        Vout_vector(step)=bits2num(BITS);
    end
    DNLS=getdnl(Vout_vector,LSB,delta,Nbits);
    stairs(Vin_vector,floor(Vin_vector/LSB),'LineWidth',2,'Color','k');
    hold on
    stairs(Vin_vector,Vout_vector,'LineWidth',2);
    legend("Ideal output","ADC output","location","northwest");
end