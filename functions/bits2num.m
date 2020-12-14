function num = bits2num(bits)
    num=0;
    Nbits=length(bits);
    for i=1:Nbits
        num=num+ bits(i)*(2^(Nbits-i));
    end
end