function [W V q E] = BackPropogation(inP, inI, inJ, inK, inZ, inD, inEmax, inlambda)
%BackPropogation(No of patterns, No of inputs, No of neurons in hidden layer, No of neurons in output layer,
%Pattern matrix, Desired Output Matrix, Max error, Lambda)

%General: BackPropogation(5,8,3,7,rand(8,5),rand(7,5),.001,.7)
%XOR: BackPropogation(4,3,2,1,[0,0,1,1;0,1,0,1;-1,-1,-1,-1],[1,-1,-1,1],.001,.7)

            %eta


inP = input('please input a value for number of training patterns (P):');
inJ = input('please input a value for number of neurons in the hidden layer(J):');
inK = input('please input a value for number of neurons in the output layer(K):');
inI = input('please input dimensionality of input (I):');
inZ = input('please input the training patterns in the form [P1;P2;...] :');
inZ=inZ'
inD = input('please input a row matrix for desired output:');
inEmax = input('please input a value for max tolerance:');
inlambda = input('please input a value for lambda for bipolar activation function:');
inn = input('please input a value for training constant eta:');

P = inP;              %No of input patterns
I = inI+1;              %No of inputs per pattern
J = inJ;              %No of neurons in hidden layer
K = inK;  
n=inn;
%No of neurons in output layer
Emax = inEmax;
lambda = inlambda;

for p=1:P
    inZ(I,p)=-1;
end

%Some error checking for consistent dimensions of Z and D
[zrow, zcol] = size(inZ);
[drow, dcol] = size(inD);
if zrow~=(I) || zcol~=inP;
    display('Dimension of Z must be IxP')
    return
end
if drow~=inK || dcol~=inP;
    display('Dimension of D must be KxP')
    return
end

Z = inZ;        %Input Pattern Matrix, I rows, P columns. Each column is a input pattern
D = inD;        %Desired Output Matrix, K rows, P colums. Each column has desired output for a pattern

%W=[-1.7   -1.5    2.4    1.5    1.8];
V=rand(J,I);
W=rand(K,J+1);
%W=[-1 1 -1];
%V=[1 0 +0.5; 0 1 0.5;1 0 -0.5;0 1 -0.5]; 
%{
%V =[1.4402    0.0473    0.6673
   -0.0345    3.0020    1.5078
    1.7872   -0.0215   -0.9384
    0.0125    2.3374   -1.1621]
%}

%W =[-1.2888   -1.7532    1.4735    1.5670    3.7489];

%W = [.1 .5];     %Randomly initialize weights matrix for output layer
%V = [.2 .1 .3;.1 .3 .5];     %Randomly initialize weights matrix for hidden layer
Y=zeros(J+1,1);       %Initialize output of hidden layer
O=zeros(K,1);       %Initialize output of output layer

%Step 1. Counter Initializations.
q = 1;
p = 1;
E = Inf;            %Initialize to Infinity to enter while loop


%Step 8. Check if iterations are complete.
while E>Emax

    E=0;            %To recalculate E
    p=1;            %Start from 1st sample
    
   while(p <= P)
        
        %Step 2. Training start.
        f=@(net)(2/(1+exp(-lambda*net))-1);
        
        
        for j=1:J
            Y(j)=f((V(j,:))*Z(:,p));           %Output Matrix of hidden layer
        end
        Y(J+1)=-1;
                     
        
        for k=1:K
            O(k)=f((W(k,:))*Y);                 %Output Matrix of Output layer
        end
        
                 
        %Step 3. Compute Error.
        for k=1:K
            M = 0.5*(D(k,p)-O(k))^2;
            E = M + E;          %Error for current sample isn't this wrong? E=0.5*(sum(D-O))^2 +E
        end
        
               
        
        %Step 4. Compute error signal vectors for both layers.
        DelO=zeros(K,1);
        DelY=zeros(J,1);
        
        for k=1:K
            DelO(k) = 0.5*(D(k,p)-O(k))*(1-O(k))*(1+O(k));         %Error signal for Output Layer (CHANGE)
        end
       
        for j=1:J
            SigmaTerm=0;
            for k=1:K
                SigmaTerm=SigmaTerm+DelO(k)*W(k,j);         %Error signal for Hidden Layer CAN BE CHANGED
            end
            DelY(j) = 0.5*(1-Y(j))*(1+Y(j))*SigmaTerm;  %CHANGE
        end
        
        %Step 5. Adjust Output Layer weights
        for k=1:K
            for j=1:(J+1)
                W(k,j)=W(k,j)+n*DelO(k)*Y(j);               %Adjust weights of Output Layer
            end
        end
        
        
        %Step 6. Adjust Hidden Layer weights
        for j=1:J
            for i=1:I
                V(j,i)=V(j,i)+n*DelY(j)*Z(i,p);               %Adjust weights of Hidden Layer
            end
        end
        
        p = p+1;
        
         
        %Increment p, go to next sample
   
    end                     %Increment q, total no of iteration
    q = q+1; 
    E
      

   if E<Emax               %If error less than threshold, Output and break.
       break; 
    end
        
    %Step 8. One Training Cycle complete for P input vectors.
end
if(nargout == 0)
    V
    W
    (q-1)

Q=input('input the test pattern in augmented matrix form:');
n1=input('input the number of test patterns');
p=1;

%V =[1.4402    0.0473    0.6673
 %  -0.0345    3.0020    1.5078
  %  1.7872   -0.0215   -0.9384
   % 0.0125    2.3374   -1.1621];

%W =[-1.2888   -1.7532    1.4735    1.5670    3.7489];
%J=4;
%Y=zeros(J,1);
while p<=n1
    f=@(net)(2/(1+exp(-10*net))-1);
        
        
        for j=1:J
            Y(j)=f((V(j,:))*Q(:,p));           %Output Matrix of hidden layer
        end
        Y(J+1)=-1;
     
        for k=1:1
            O(k)=f((W(k,:))*Y);                 %Output Matrix of Output layer
        end
        O
        p=p+1;
end
end
end
