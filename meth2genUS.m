S = rand(1000,3);
for i = 1:1000
    S(i,:) = S(i,:)/(sqrt((S(i,1)*S(i,1))+ (S(i,2)*S(i,2))+ (S(i,3)*S(i,3))));
end
a = 3; b = 17;
U = a + (b-a) * rand(1000,1);
US = [U S];
for i = 1:1000
    SX(i,1) = 2*U(i,1)*U(i,1)*S(i,1)*S(i,3)/9.8;
    SX(i,2) = 2*U(i,1)*U(i,1)*S(i,2)*S(i,3)/9.8;
end
D = [];
for i = 1:1000
R = [SX(i,1);SX(i,2)];
D = [D R];
end

D = D'
xlswrite('Dmeth21',D);
xlswrite('USmeth21',US);