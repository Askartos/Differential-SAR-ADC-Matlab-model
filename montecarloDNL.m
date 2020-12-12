function [uDNL,sDNL]=montecarloDNL(Nsample,Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)
format long
    substeps=200;
    LSB=(Vdd-Vss)/(2^Nbits);
    delta=LSB/substeps;
    steps=(2^Nbits)*substeps-1;
    dnls=zeros(Nsample,1);
    Vin_vector=0:delta:steps*delta;
    for sample=1:Nsample
        cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
        Vout_vector=zeros(steps,1);
        for step=1:steps+1
            VinP=Vin_vector(step)/2  + Vcm;
            VinN=-Vin_vector(step)/2 + Vcm;
            BITS=SAR_ADC(Nbits,cap_bank,Vdd, Vss, VinP, VinN, Vcm);
            Vout_vector(step)=bits2num(BITS);
        end
        dnls(sample)=getdnl(Vout_vector,LSB,steps,delta,Nbits);
    end
    uDNL=mean(dnls);
    sDNL=std(dnls);
end