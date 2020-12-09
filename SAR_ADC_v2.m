function [bits]=SAR_ADC_v2(Nbits,Cu,sigmaCu,Vdd, Vss,vinP, vinN, Vcm)
    cap_bank=[cap_bank_init(Cu,sigmaCu,Nbits-1),cap_bank_init(Cu,sigmaCu,Nbits-1)];
    bits=zeros(1,Nbits);
    vouts=cap_bank_dac(cap_bank,Vdd,Vss,Vcm,vinP,vinN,bits(:,2:Nbits));
    bits(1)= ( vouts(1)>vouts(2) );
    if(bits(1))
        tmp=vinP;
        vinP=vinN;
        vinN=tmp;
    end
    for count=2:Nbits
        bits(count)=1;
        vouts=cap_bank_dac(cap_bank,Vdd,Vss,Vcm,vinP,vinN,bits(:,2:Nbits));
        comp_out=vouts(1)>vouts(2);
        if (comp_out)
            bits(count)=0;
        end
    end
    
end