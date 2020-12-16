function [uDNL,sDNL]=montecarloDNL(Nsample,Nbits,Cu,sigmaCu,Vdd, Vss,Vcm)
format long
    if(Nbits<10)%sub resolution adjustment required in order to get results in reasonable time
        substeps=200-40*(Nbits-6);
    elseif(Nbits<12)
       substeps=80-20*(Nbits-9);
    else
        substeps=40;
    end
    LSB=(Vdd-Vss)/(2^Nbits);
    delta=LSB/substeps;
    dnls=zeros(Nsample,1);
    
    Vin_vector=0:delta:1.8-delta;
    stairs(Vin_vector,floor(Vin_vector/LSB),'LineWidth',1.5);
    hold on;
    Vout=zeros(length(Vin_vector),Nsample);
    parfor sample=1:Nsample %parallel execution for loop
        cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
        Vout_vector=zeros(length(Vin_vector),1);
        for step=1:length(Vin_vector)
            VinP=Vin_vector(step)/2  + Vcm;
            VinN=-Vin_vector(step)/2 + Vcm;
            BITS=SAR_ADC(Nbits,cap_bank,Vdd, Vss, VinP, VinN, Vcm);
            Vout_vector(step)=bits2num(BITS);
        end
        Vout(:,sample)=Vout_vector;
        dnls_sub=getdnl(Vout_vector,LSB,delta,Nbits);
        
        [ ~ ,idx]=max(abs(dnls_sub));
        dnls(sample)=dnls_sub(idx);
    end
    stairs(Vin_vector,Vout,'LineWidth',1.5);
    xlabel("Input voltage");
    ylabel("Digital word");
    title("Digital word vs Input voltage");
    xlim([0,1.8]);
    uDNL=mean(dnls);
    sDNL=std(dnls);
end