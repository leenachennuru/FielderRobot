S = rand(32,3);
for i = 1:32
    S(i,:) = S(i,:)/(sqrt((S(i,1)*S(i,1))+ (S(i,2)*S(i,2))+ (S(i,3)*S(i,3))));
end

U = []; 
for i = 1:8
a =  i;
b = i +1;
Un = a + (b-a)*rand(4,1);
U = [U; Un];
end

US = [U S];
for i = 1:32
    SX(i,1) = 2*U(i,1)*U(i,1)*S(i,1)*S(i,3)/9.8;
    SX(i,2) = 2*U(i,1)*U(i,1)*S(i,2)*S(i,3)/9.8;
end

ResultMat = [];
for i = 1:32
    for h = 0:3
        for k = 0:3
            if ((SX(i,1)> h) && (SX(i,1)< h+1 )&& (SX(i,2)>k) && (SX(i,2)< k+1))
                ResultMat = [ResultMat; US(i,:) (h*10)+k];
            else
                ResultMat = ResultMat;
            end
        end
    end
    if ((SX(i,1)> 4)|| (SX(i,2)>4))
        ResultMat = [ResultMat; US(i,:) 1000];
    end
end

ResultMat(:,5) = ResultMat(:,5) + ones(32,1);
D = -1*ones(16,32);
for i = 1:16
    for j = 1:32
        if (i == ResultMat(j,5) )
            D(i,j) = 1;
        else
            D(i,j) = D(i,j);
        end
    end
end
D = D';
for i = 1:32
USnew(i,1) = US(i,1)*US(i,2);
USnew(i,2) = US(i,1)*US(i,3);
USnew(i,3) = US(i,1)*US(i,4);
end

xlswrite('USmat44',US);
xlswrite('SXmat44',SX);
xlswrite('Dmat44',D);
xlswrite('Smat44',S);
xlswrite('Umat44',U);
xlswrite('USnewmat44',USnew);
xlswrite('ResultMat44',ResultMat);
