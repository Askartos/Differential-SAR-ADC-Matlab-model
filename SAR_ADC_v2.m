function [bits]=SAR_ADC_v2(Nbits,cap_bank,Vdd, Vss,vinP, vinN, Vcm)    
    bits=zeros(1,Nbits);
    vouts=cap_bank_dac(cap_bank,Vdd,Vss,Vcm,vinP,vinN,bits(:,2:Nbits));
    bits(1)= ( vouts(1)>vouts(2) );
    for count=2:Nbits
        bits(count)=1;
        if(bits(1))            
            vouts=cap_bank_dac(cap_bank,Vss,Vdd,Vcm,vinP,vinN,bits(:,2:Nbits));
            comp_out=~(vouts(1)>vouts(2));
        else            
            vouts=cap_bank_dac(cap_bank,Vdd,Vss,Vcm,vinP,vinN,bits(:,2:Nbits));
            comp_out=vouts(1)>vouts(2);
        end
        if (comp_out)
            bits(count)=0;
        end
    end
    
end