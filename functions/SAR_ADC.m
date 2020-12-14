function [bits]=SAR_ADC(Nbits,cap_bank,Vdd, Vss,vinP, vinN, Vcm)
    format long
    bits=zeros(1,Nbits);
    for count=1:Nbits
        bits(count)=1;
        vouts=cap_bank_dac(cap_bank,Vdd,Vss,Vcm,vinN,vinP,bits);
        comp_out= (vouts(1)-vouts(2)) > 1e-15;%this its due to an unspected error in the comparator
        if (comp_out)
            bits(count)=0;
        end
    end
    
end