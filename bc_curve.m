function b = bc_curve( s,alpha)
M=length(alpha)-1;
for i=1:length(s)
    b(i)=0;
    for k=0:M
        b(i)= b(i) + alpha(k+1) * (factorial(M)/(factorial(k)*factorial(M-k))) * s(i)^k * (1-s(i))^(M-k);
    end
end

