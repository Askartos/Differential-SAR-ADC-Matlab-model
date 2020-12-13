function [uDNL,sDNL]=montecarloDNL(Nsample,Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)
format long
    if(Nbits<10)
        substeps=200-40*(Nbits-6);
    elseif(Nbits<12)
       substeps=80-20*(Nbits-9);
    else
        substeps=40;
    end
    LSB=(Vdd-Vss)/(2^Nbits);
    delta=LSB/substeps;
    dnls=zeros(Nsample,1);
    
    Vin_vector=0:delta:(2^(Nbits-1)+1)*LSB;

    for sample=1:Nsample
        cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
        Vout_vector=zeros(length(Vin_vector),1);
        for step=1:length(Vin_vector)
            VinP=Vin_vector(step)/2  + Vcm;
            VinN=-Vin_vector(step)/2 + Vcm;
            BITS=SAR_ADC(Nbits,cap_bank,Vdd, Vss, VinP, VinN, Vcm);
            Vout_vector(step)=bits2num(BITS);
        end
        dnls(sample)=getdnl(Vout_vector,LSB,delta,Nbits);
    end
    uDNL=mean(dnls);
    sDNL=std(dnls);
end