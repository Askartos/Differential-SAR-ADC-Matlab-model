function [uDNL,sDNL]=montecarloDNL(Nsample,Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)
format long
    substeps=200;
    LSB=(Vdd-Vss)/(2^Nbits);
    delta=LSB/substeps;
    steps=(2^Nbits)*substeps-1;
    dnls=zeros(Nsample,1);
    for sample=1:Nsample
        cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
        Vin_vector=zeros(steps,1);
        Vout_vector=zeros(steps,1);
        Vidl_vector=zeros(steps,1);
        for step=0:steps
            Vin=step*delta;
            VinP=Vin/2  + Vcm;
            VinN=-Vin/2 + Vcm;
            BITS=SAR_ADC(Nbits,cap_bank,Vdd, Vss, VinP, VinN, Vcm);
            Vin_vector(step+1)=Vin;
            Vidl_vector(step+1)=floor(Vin/LSB);
            Vout_vector(step+1)=bits2num(BITS);
        end
        dnls(sample)=getdnl(Vout_vector,Vin_vector,LSB,steps,delta);
        %figure;
        %stairs(Vin_vector,Vidl_vector)
        %hold on
        %stairs(Vin_vector,Vout_vector)
        %legend("output ideal","output real");
    end
    uDNL=mean(dnls);
    sDNL=std(dnls);
end