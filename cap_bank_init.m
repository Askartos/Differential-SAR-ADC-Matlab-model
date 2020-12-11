function cap_bank=cap_bank_init(mCu,sigmaCu,N)
    cap_bank=zeros(N,1);
    for i=N:-1:1
        cap_bank(N+1-i)=sum(normrnd(mCu,sigmaCu,[(2^(i-1)) 1]));
    end
    cap_bank=[cap_bank;normrnd(mCu,sigmaCu)];
end