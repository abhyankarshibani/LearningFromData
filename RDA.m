%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Rda Train Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=0;b=0;c=0;num(numofClass)=0;

[m,m1] = size(TrainData);
cov_f =zeros(m1);
final = zeros(m1);
size_train =length(TrainLAbel);

un_1 = length( unique(TrainLAbel));
training = cell(numofClass,1);

for i =0:numofClass
   a=0;
    for k=1:size_train
        
        if TrainLAbel(k) == i
            a=a+1;
            temp(a,:) = TrainData(k,:);
           
            
        end
    end
    num(i+1) =a;
    training(i+1,1) ={temp([1:a],:)};
end

for k=0:numofClass-1
    Mu(k+1,:) = mean(training{k+1,1});
    pi(k+1,1) = num(k+1)/size_train;
    covt(:,:) = cov(training{k+1,1}) .*pi(k+1,1);
    
    cov_f(:,:) = cov_f(:,:) + covt(:,:);
    
end

final(:,:) = (gamma.*diag(diag(cov_f))) + ((1-gamma).*cov_f);
s = struct('MU',Mu,'pi',pi,'cov',final);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RDA test data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d(numberofclass,1)=0;
[r,c] = size(TestData);
for k= 1:r
     for l =1:numberofclass
	se=[];
	se = LDAmodel.MU(l,:) * (inv(LDAmodel.cov));
   	eq(l,1) = se * TestData(k,:)' - 0.5*(se*LDAmodel.MU(l,:)') +log(LDAmodel.pi(l,1));
	      d(l,1) = log(eq(1,1));
	      d(2,1) = log(eq(2,1));
     end
      [c,I] = max(d);
      PredicitedLabel(k,1) = I-1;

end


