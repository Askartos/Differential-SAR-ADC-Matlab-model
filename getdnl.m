function dnl=getdnl(vout,vin,LSB,steps,delta)

        dnls=[];
        vidl=zeros(size(vin));
        error=0;
        for i=1:steps+1
            vidl(i)=floor(vin(i)/LSB);
            if((vidl(i)-vout(i))~=0)
                error=error+delta;
            elseif(error~=0)
                dnls=[dnls;error/LSB];
                error=0;
            end
        end
        dnls
        dnl=max(abs(dnls));
end