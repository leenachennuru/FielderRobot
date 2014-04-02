S = rand(40,3);
for i = 1:40
    S(i,:) = S(i,:)/(sqrt((S(i,1)*S(i,1))+ (S(i,2)*S(i,2))+ (S(i,3)*S(i,3))));
end

U = []; 
for i = 1:20
a =  i;
b = i +1;
Un = a + (b-a)*rand(2,1);
U = [U; Un];
end

US = [U S];
for i = 1:40
    SX(i,1) = 2*U(i,1)*U(i,1)*S(i,1)*S(i,3)/9.8;
    SX(i,2) = 2*U(i,1)*U(i,1)*S(i,2)*S(i,3)/9.8;
end

ResultMat = [];
for i = 1:40
    for h = 0:9
        for k = 0:9
            if ((SX(i,1)> h) && (SX(i,1)< h+1 )&& (SX(i,2)>k) && (SX(i,2)< k+1))
                ResultMat = [ResultMat; US(i,:) (h*10)+k];
            else
                ResultMat = ResultMat;
            end
        end
    end
    if ((SX(i,1)> 10)|| (SX(i,2)>10))
        ResultMat = [ResultMat; US(i,:) 1000];
    end
end

ResultMat(:,5) = ResultMat(:,5) + ones(40,1);
D = -1*ones(100,40);
for i = 1:100
    for j = 1:40 
        if (i == ResultMat(j,5) )
            D(i,j) = 1;
        else
            D(i,j) = D(i,j);
        end
    end
end
D = D';
for i = 1:40
USnew(i,1) = US(i,1)*US(i,2);
USnew(i,2) = US(i,1)*US(i,3);
USnew(i,3) = US(i,1)*US(i,4);
end

xlswrite('UStest1mat',US);
xlswrite('SXtest1mat',SX);
xlswrite('Dtest1mat',D);
xlswrite('Stest1mat',S);
xlswrite('Utest1mat',U);
xlswrite('UStest1newmat',USnew);

