function vouts=cap_bank_dac(cap_banks,vrefp,vrefn,vinP,vinN,bits)
cap_bankp=cap_banks(:,1);
cap_bankn=cap_banks(:,2);

total_capP = sum(cap_bankp);
total_capN = sum(cap_bankn);
Crefp=0;
Crefn=0;
N=length(bits);
for i=1:N
    if(bits(i) == 0)
        Crefp=Crefp+cap_bankp(i);
    end
    if(bits(i) == 1)
        Crefn=Crefn+cap_bankp(i);
    end
end
Crefp=Crefp+cap_bankp(N+1);%additional cap

voutp= -vinP + vrefp*(Crefp/total_capP);
voutn= -vinN + vrefn*(Crefn/total_capN);

vouts=[voutp voutn];
end