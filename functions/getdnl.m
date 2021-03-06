function dnls=getdnl(vout,LSB,delta,Nbits)
        format long
        dnls=zeros(2^Nbits -1,1);
        value=vout(1);
        width=0;
        count=1;
        for i=1:length(vout)
            if(abs(value-vout(i))<1e-10)
                width=width+delta;
            else
                dnls(count)=(width/LSB)-1;
                width=delta;
                value=vout(i);
                count=count+1;
            end
        end
end