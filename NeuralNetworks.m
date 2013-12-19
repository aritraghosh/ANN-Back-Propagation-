test=csvread('/home/aritrag/CS5011/Assignment3/Question3data/test.csv');
test_labels=csvread('/home/aritrag/CS5011/Assignment3/Question3data/testlabels.csv');
X=csvread('/home/aritrag/CS5011/Assignment3/Question3data/train.csv');
y=csvread('/home/aritrag/CS5011/Assignment3/Question3data/trainlabels.csv');

a=-0.2;
b=0.2;
[N,p]=size(X);
X=[ones(N,1),X];
M=10;
K=4;
eta=0.01;
loopscount=10000;
alphanew=zeros(M,p+1);
betanew=zeros(K,M+1);
truelabel=zeros(N,K);
Z=zeros(N,M+1);
f=zeros(N,K);
deltaki=zeros(N,K);
alpha= a + (b-a).*rand(M,p+1);
beta=a + (b-a).*rand(K,M+1);

for(i=1:N)
  truelabel(i,y(i))=1;
end


for loop=1:loopscount
    
    Z=[ones(N,1),sigma(X*alpha')];
    f=sigma(Z*beta');
    alphanew=alpha;
    betanew=beta;
    gkdash=sigmadash(Z*beta');
    deltaki=-2*(truelabel-f).*gkdash;
    
        betanew=betanew-eta*deltaki'*Z;
        x=[(deltaki*beta).*[ones(N,1),sigmadash(X*alpha')]]'*X; %updating beta
        x=x(2:M+1,:);
        alphanew=alphanew-eta*x; %updating alpha
        alpha=alphanew;
        beta=betanew;
end
    
        Z=[ones(N,1),sigma(X*alpha')];
        f=sigma(Z*beta');
        idx1=[];
        for loop = 1:N
           [val idx]  = max(f(loop,:));
           idx1=[idx1;idx];
        end
        
        count=0;
       for(i=1:N)
           if(idx1(i)==y(i))
               count=count+1;
           end
       end
        
       [Ntest,temp] = size(test);
       test=[ones(Ntest,1),test];
        Z=[ones(Ntest,1),sigma(test*alpha')];
        f=sigma(Z*beta');
        idx1=[];
        for loop = 1:Ntest
           [val idx]  = max(f(loop,:));
           idx1=[idx1;idx];
        end
        
        counttest=0;
        class=zeros(4,2);
       for(i=1:Ntest)
          
               
                   if(idx1(i)==ceil(i/20))
                       class(ceil(i/20),1)=class(ceil(i/20),1)+1;
                       
                   else
                       
                       class(idx1(i),2)=class(idx1(i),2)+1;
                   
                   end
       end
               
    
               
       
%Accuracy,Precision and Recall      
 accuracy=zeros(4,3);
 for(i=1:4)
 accuracy(i,1)=class(i,1)/(class(i,1)+class(i,2));
 accuracy(i,2)=class(i,1)/20;
 accuracy(i,3)=2*accuracy(i,2).*accuracy(i,1)/(accuracy(i,2)+accuracy(i,1));
      
 end
    


    
    
        
        
        
    