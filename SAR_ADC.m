function [bits]=SAR_ADC(Nbits,Cu,sigmaCu,Vdd, Vss,vinP, vinN, Vcm)
    cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits),cap_bank_init(Cu,sigmaCu,Nbits)];
    bits=zeros(1,Nbits);
    for count=1:Nbits
        bits(count)=1;
        vouts=cap_bank_dac(cap_bank,Vdd,Vss,Vcm,vinP,vinN,bits);
        comp_out=vouts(1)<=vouts(2);
        if (comp_out==0)
            bits(count)=0;
        end
    end
    
end