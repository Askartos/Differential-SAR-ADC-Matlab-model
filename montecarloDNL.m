function Vidl_vector=montecarloDNL(Nsample,Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)
    substeps=100;
    LSB=(Vdd-Vss)/(2^Nbits);
    delta=LSB/substeps;
    steps=(2^Nbits)*substeps;
    for sample=1:Nsample
        cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
        %cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits-1),cap_bank_init(Cu,sigmaCu,Nbits-1)];
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
        getdnl(Vout_vector,Vin_vector,LSB,steps,delta)
        stairs(Vin_vector,Vidl_vector)
        hold on
        stairs(Vin_vector,Vout_vector)
        legend("output ideal","output real");
    end
end