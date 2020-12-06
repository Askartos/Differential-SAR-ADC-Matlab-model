function [bits]=SAR_ADC(Nbits,Cu,Ocu,Nsample,Vee, Vss, vinP, vinN, Vcm,Vdif)
    cap_bank=[cap_bank_init(Cu,Ocu,Nbits),cap_bank_init(Cu,Ocu,Nbits)];
    bits=zeros(1,Nbits);
    
    for count=1:Nbits
        bits(count)=1;
        vouts=cap_bank_dac(cap_bank,Vee,Vss,vinP,vinN,bits);
        if (vouts(1)<vouts(2))
            bits(count)=0;
        end
    end
    
end