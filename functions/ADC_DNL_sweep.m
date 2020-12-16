function DNLS=ADC_DNL_sweep(Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)
format long
    substeps=400;
    LSB=(Vdd-Vss)/(2^Nbits)
    delta=LSB/substeps;
    Vin_vector=0:delta:Vdd-delta;
    cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
    Vout_vector=zeros(length(Vin_vector),1);
    tic
    for step=1:length(Vin_vector)
        VinP=Vin_vector(step)/2  + Vcm;
        VinN=-Vin_vector(step)/2 + Vcm;
        BITS=SAR_ADC(Nbits,cap_bank,Vdd, Vss, VinP, VinN, Vcm);
        Vout_vector(step)=bits2num(BITS);
    end
    toc
    DNLS=getdnl(Vout_vector,LSB,delta,Nbits);
    figure
    stairs(Vin_vector,(Vin_vector/LSB),'LineWidth',2,'Color',[0.4940, 0.1840, 0.5560]);
    hold on
    stairs(Vin_vector,Vout_vector,'LineWidth',2,'Color',[0.3010, 0.7450, 0.9330]);
    xlabel("Input voltage");
    ylabel("Digital word");
    title("Input voltage vs Output digital word");
    legend("ADC Input / LSB","ADC output","location","northwest");
end