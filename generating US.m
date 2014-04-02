S = rand(800,3);
for i = 1:800
    S(i,:) = S(i,:)/(sqrt((S(i,1)*S(i,1))+ (S(i,2)*S(i,2))+ (S(i,3)*S(i,3))));
end
a = 0; b = 20;
U = a + (b-a) * rand(800,1);
US = [U S];
for i = 1:800
    SX(i,1) = 2*U(i,1)*U(i,1)*S(i,1)*S(i,3)/9.8;
    SX(i,2) = 2*U(i,1)*U(i,1)*S(i,2)*S(i,3)/9.8;
end
D = [];
for i = 1:800
R = [SX(i,1)];SX(i,2)];
D = [D R];
end

ResultMat = [];
for i = 1:800
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

ResultMat(:,5) = ResultMat(:,5) + ones(800,1);
D = -1*ones(100,800);
for i = 1:100
    for j = 1:800 
        if (i == ResultMat(j,5) )
            D(i,j) = 1;
        else
            D(i,j) = D(i,j);
        end
    end
end
xlswrite('USmat',US);
xlswrite('SXmat',SX);
xlswrite('Dmat',D);
xlswrite('Smat',S);
xlswrite('Umat',U);
