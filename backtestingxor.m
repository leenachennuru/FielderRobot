%function BackPropogation(inP, inI, inJ, inK, inZ, inD, inEmax, inlambda)%
%BackPropogation(No of patterns, No of inputs, No of neurons in hidden layer *(Includes Dummy neuron), No of neurons in output layer,
%Pattern matrix, Desired Output Matrix, Max error, Lambda)

%General: BackPropogation(5,8,3,7,rand(8,5),rand(7,5),.001,.7)
%XOR: BackPropogation(4,3,3,1,[0,0,1,1;0,1,0,1;-1,-1,-1,-1],[1,-1,-1,1],.001,10)


inP = input('number of patterns');              %No of input patterns
inI = input('number of inputs');              %No of inputs per pattern
inJ = input('neurons in hidden layer');              %No of neurons in hidden layer
inK = input(' number in output layer');              %No of neurons in output layer
inZ = input('matrix Z');
inD = input('matrix D');
inEmax = input('max error');
inlambda = input('lamda...');
inn = input('input neta value');
%Some error checking for consistent dimensions of Z and D
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
K= inK;
J = inJ;
I = inI;
P= inP;
n = inn;        %eta
Emax = inEmax;        %Maximum error
lambda = inlambda;        %lambda

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
   Earray = [];
   Earray1 = [];          %To recalculate E
    p=1;            %Start from 1st sample
    
    while(p <= P)
        
        %Step 2. Training start.
        f=@(net)(2/(1+exp(-lambda*net))-1);
        
        for j=1:J-1
            Y(j)=f((V(j,:))*Z(:,p));            %Output Matrix of hidden layer
        end
        Y(J) = -1;
        
        for k=1:K
            O(k)=f((W(k,:))*Y);                     %Output Matrix of Output layer
        end
        
        %Step 3. Compute Error.
        for k=1:K
            M = 0.5*(D(k,p)-O(k))^2;
         Earray(k) = M;                              %Error for current sample 
        end
        
        Earray1 = [Earray1 Earray];
        E = max(Earray1);
        
        %Step 4. Compute error signal vectors for both layers.
        DelO=zeros(K,1);
        DelY=zeros(J,1);
        
        for k=1:K
            DelO(k) = 0.5*(D(k,p)-O(k))*(1-O(k))*(1+O(k));          %Error signal for Output Layer
        end
        
        for j=1:J-1
            SigmaTerm=0;
            for k=1:K
                SigmaTerm=SigmaTerm+DelO(k)*W(k,j);                 %Error signal for Hidden Layer
            end
            DelY(j) = 0.5*(1-Y(j))*(1+Y(j))*SigmaTerm; 
        end
        
        %Step 5. Adjust Output Layer weights
        for k=1:K
            for j=1:J
                W(k,j)=W(k,j)+n*DelO(k)*Y(j);               %Adjust weights of Output Layer
            end
        end
        
        %Step 6. Adjust Hidden Layer weights
        for j=1:J-1
            for i=1:I
                V(j,i)=V(j,i)+n*DelY(j)*Z(i,p);              %Adjust weights of Hidden Layer
            end
        end
        
        p = p+1;            %Increment p, go to next sample
        
    end
    q = q+1 %Increment q, total no of epochs
     W
     E
    if E<Emax               %If error less than threshold, Output and break.
        W
        V(1:J-1,:)
        q
        E
       
        %Step 8.Training complete for P input vectors.
        
        Q=inZ;
        
        for p=1:P
            f=@(net)(2/(1+exp(-lambda*net))-1);
            
            
            for j=1:J-1
                Y(j)=f((V(j,:))*Z(:,p));           %Output Matrix of hidden layer
            end
            Y(J)=-1;
            
            
            for k=1:K
                O(k)=f((W(k,:))*Y);                 %Output Matrix of Output layer
            end
            
            O                                       
              
        end
        break
       
    end
end
