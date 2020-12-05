function cap_bank=cap_bank_init(mCu,sigmaCu,N)
    cap_bank=normrnd(mCu,sigmaCu,[N 1]);
    for i=N:-1:1
        cap_bank(N+1-i)=(2^(i-1))*cap_bank(N+1-i);
    end
    cap_bank=[cap_bank;normrnd(mCu,sigmaCu)];
end