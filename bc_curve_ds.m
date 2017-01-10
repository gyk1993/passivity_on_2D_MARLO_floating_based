function dbds = bc_curve_ds( s,alpha)
M=length(alpha)-1;
for i=1:length(s)
    dbds(i)=0;
    for k=0:M-1
        dbds(i)= dbds(i) + (alpha(k+2)-alpha(k+1)) * (factorial(M)/(factorial(k)*factorial(M-k-1))) * s(i)^k * (1-s(i))^(M-k-1);
    end
end

