function vouts=cap_bank_dac(cap_banks,vdd,vss,vcm,vinP,vinN,bits)
format long
cap_bankp=cap_banks(:,1);
cap_bankn=cap_banks(:,2);

total_capP = sum(cap_bankp);
total_capN = sum(cap_bankn);
Cvrefp=0;
Cvrefn=0;
N=length(bits);
for i=1:N
    if(bits(i) == 1)
        Cvrefp=Cvrefp+cap_bankp(i);
        Cvrefn=Cvrefn+cap_bankn(i);
    end
end

voutp= vcm-vinP + vdd*(Cvrefp/total_capP);
voutn= vcm-vinN + vss*(Cvrefn/total_capN);
vouts=[voutp voutn];
end