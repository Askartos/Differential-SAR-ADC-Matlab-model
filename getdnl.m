function dnl=getdnl(vout,LSB,delta,Nbits)
        format long
        dnls=zeros(2^Nbits,1);
        value=vout(1);
        width=0;
        for i=1:length(vout)
            if(abs(value-vout(i))<1e-10)
                width=width+delta;
            else
                dnls(i)=(width/LSB)-1;
                width=delta;
                value=vout(i);
            end
        end
        [ ~ ,idx]=max(abs(dnls));
        dnl=dnls(idx);
end