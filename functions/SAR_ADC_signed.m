function [bits]=SAR_ADC_signed(Nbits,cap_bank,Vdd, Vss,vinP, vinN, Vcm)
format long
    bits=zeros(1,Nbits);
    vouts=cap_bank_dac(cap_bank,Vdd,Vss,Vcm,vinP,vinN,bits(:,2:Nbits));
    bits(1)= (vouts(2)-vouts(1)) > 1e-15;%this its due to an unspected error in the comparator
    for count=2:Nbits
        bits(count)=1;
        if(~bits(1))            
            vouts=cap_bank_dac(cap_bank,Vdd,Vss,Vcm,vinP,vinN,bits(:,2:Nbits));
            comp_out=((vouts(2)-vouts(1)) > 1e-15);%this its due to an unspected error in the comparator
        else            
            vouts=cap_bank_dac(cap_bank,Vss,Vdd,Vcm,vinP,vinN,bits(:,2:Nbits));
            comp_out= ((vouts(1)-vouts(2)) > 1e-15);%this its due to an unspected error in the comparator
        end
        if (comp_out)
            bits(count)=0;
        end
    end
    
end