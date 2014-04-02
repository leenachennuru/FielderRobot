%function [W V q E] = BackPropogation(inP, inI, inJ, inK, inZ, inD, inEmax, inlambda)
%BackPropogation(No of patterns, No of inputs, No of neurons in hidden layer, No of neurons in output layer,
%Pattern matrix, Desired Output Matrix, Max error, Lambda)

%General: BackPropogation(5,8,3,7,rand(8,5),rand(7,5),.001,.7)
%XOR: BackPropogation(4,3,2,1,[0,0,1,1;0,1,0,1;-1,-1,-1,-1],[1,-1,-1,1],.001,.7)
P = input('please input a value for inP:');
J = input('please input a value for inJ:');
K = input('please input a value for inK:');
I = input('please input a value for inI:');
Z = input('please input a matrix for inZ:');
D = input('please input a matrix for inD:');
Emax = input('please input a value for inEmax:');
lambda = input('please input a value for inlambda:');

%rachana-i think not needed; still just check
P = inP;              %No of input patterns
I = inI;              %No of inputs per pattern
J = inJ;              %No of neurons in hidden layer
K = inK;              %No of neurons in output layer

%Some error checking for consistent dimensions of Z and D
%RAchana-what is inZ and inD; not defined earlier and was showing error
[zrow, zcol] = size(inZ);
[drow, dcol] = size(inD);
if zrow~=inI || zcol~=inP;
    display('Dimension of Z must be IxP')
    return
end
if drow~=inK || dcol~=inP;
    display('Dimension of D must be KxP')
    return
end

Z = inZ;        %Input Pattern Matrix, I rows, P columns. Each column is a input pattern
D = inD;        %Desired Output Matrix, K rows, P colums. Each column has desired output for a pattern

n = 0.1;            %eta
Emax = .001;        %Maximum error
lambda = .5;        %lambda

W = rand(K, J);     %Randomly initialize weights matrix for output layer
V = rand(J, I);     %Randomly initialize weights matrix for hidden layer
Y=zeros(J,1);       %Initialize output of hidden layer
O=zeros(K,1);       %Initialize output of output layer

%Step 1. Counter Initializations.
q = 1;
p = 1;
E = Inf;            %Initialize to Infinity to enter while loop

%Step 8. Check if iterations are complete.
while E>Emax
    E=0;            %To recalculate E
    p=1;            %Start from 1st sample
    
    while(p < P)
        
        %Step 2. Training start.
        f=@(net)(2/(1+exp(-lambda*net))-1);
        
        for j=1:J
            Y(j)=f((V(j,:))*Z(:,p));            %Output Matrix of hidden layer
        end
        
        
        for k=1:K
            O(k)=f((W(k,:))*Y);                 %Output Matrix of Output layer
        end
        
        %Step 3. Compute Error.
        for k=1:K
            E = 0.5*(D(k)-O(k))^2 + E;          %rachana-Error for current sample isn't this wrong? E=0.5*(sum(D-O))^2 +E
        end
        
        %Step 4. Compute error signal vectors for both layers.
        DelO=zeros(K,1);
        DelY=zeros(J,1);
        
        for k=1:K
            DelO(k) = 0.5*(D(k)-O(k))*(1-(O(k))^2);         %Error signal for Output Layer
        end
        
        for j=1:J
            SigmaTerm=0;
            for k=1:K
                SigmaTerm=SigmaTerm+DelO(k)*W(k,j);         %Error signal for Hidden Layer
            end
            DelY(j) = 0.5*(1-Y(j)^2)*SigmaTerm;
        end
        
        %Step 5. Adjust Output Layer weights
        for k=1:K
            for j=1:J
                W(k,j)=W(k,j)+n*DelO(k)*Y(j);               %Adjust weights of Output Layer
            end
        end
        
        %Step 6. Adjust Hidden Layer weights
        for j=1:J
            for i=1:I
                V(j,i)=V(j,i)+n*DelY(j)*Z(i);               %Adjust weights of Hidden Layer
            end
        end
        
        p = p+1;            %Increment p, go to next sample
        q = q+1;            %Increment q, total no of iterations
    end
    
    if E<Emax               %If error less than threshold, Output and break.
        W
        V
        q
        E
        break 
    end
    %Step 8. One Training Cycle complete for P input vectors.
end