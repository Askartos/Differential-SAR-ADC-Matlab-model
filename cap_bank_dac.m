function vouts=cap_bank_dac(cap_banks,vdd,vss,vcm,vinP,vinN,bits)
cap_bankp=cap_banks(:,1);
cap_bankn=cap_banks(:,2);

total_capP = sum(cap_bankp);
total_capN = sum(cap_bankn);
Cvddp=0;
Cvddn=0;
N=length(bits);
for i=1:N
    if(bits(i) == 1)
        Cvddp=Cvddp+cap_bankp(i);
        Cvddn=Cvddn+cap_bankp(i);
    end
end
voutp= vcm-vinP + vdd*(Cvddp/total_capP);
voutn= vcm-vinN + vss*(Cvddn/total_capN);
vouts=[voutp voutn];
end