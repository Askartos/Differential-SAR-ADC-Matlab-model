function vouts=cap_bank_dac(cap_banks,vdd,vss,vcm,vinP,vinN,bits)
format long
cap_bankp=cap_banks(:,1);
cap_bankn=cap_banks(:,2);
total_capP = sum(cap_bankp);
total_capN = sum(cap_bankn);
N=length(bits);
Cvrefp=0;
Cvrefn=0;
for i=1:N
    if(bits(i) == 1)
        Cvrefp=Cvrefp+cap_bankp(i);
        Cvrefn=Cvrefn+cap_bankn(i);
    end
end
Cvmcp=total_capP-Cvrefp;
Cvmcn=total_capN-Cvrefn;
voutp= vinP-vcm + vdd*(Cvrefp/total_capP)+vcm*(Cvmcp/total_capP);
voutn= vinN-vcm + vss*(Cvrefn/total_capN)+vcm*(Cvmcn/total_capN);
vouts=[voutp voutn];
end