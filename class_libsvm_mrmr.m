function [ Acc_overall,  Spec_overall,Sens_overall  ] = class_libsvm_mrmr( Feature, label, kfold )
% Use SVM discrminate two groups with mrmr feature selection
% Code by Xinyi Wang 20190306
% input: Feature ,N*M, N is the number of sample, and M indicate the number
% of feature
%%%% labels: N*1 vector, marked as -1 or 1;
%%%% kfold: k value setting by users to determine cross-validation
% output: accuracy: a array of accuracy.

 [nbsample,nbfeature]=size(Feature);
% Normalization
  for i=1:nbfeature
        features=Feature(:,i);
        flag=find(features==Inf | features==NaN);  
        if ~isempty(flag)
            continue;
        end
        feature_std = std(features,0,1);
        feature_std = ones(size(features,1),1)*feature_std;
        feature_mean = mean(features,1);
        feature_mean = ones(size(features,1),1)*feature_mean;
        features = (features-feature_mean)./feature_std;  
        data(:,i)=features;
        clear features feature_std feature_mean
  end
    %Shuffle the order
    feature=zeros(nbsample,nbfeature);
    Label=zeros(nbsample,1);
    feature(1:2:end-1,:)=data(1:nbsample/2,:);
    feature(2:2:end,:)=data(nbsample/2+1:end,:);
    Label(1:2:end-1)=label(1:nbsample/2);
    Label(2:2:end)=label(nbsample/2+1:end);
      
    numOfTest=round(nbsample/kfold);
    Idx=[1:nbsample];
       
   for N_fea=1:nbfeature
        
        for i = 1:kfold        
           tstidx=[(i-1)*numOfTest+1:min(i*numOfTest,nbsample)]; % test subjects's index 
           tstNo=Idx(tstidx);  %testing sample No. chosen from total training dataset
           trnNo=setdiff(Idx,tstNo);  %training sample No. chosen from total training dataset
           Labeltrain=Label(trnNo,1);    %Training Labels
           Labeltest=Label(tstNo,1);      %Test Labels
           Featuretrn=feature(trnNo,:);  %Training feature
           Featuretst=feature(tstNo,:);  %Test Feature
           
           fea = mrmr_miq_d(Featuretrn, Labeltrain, N_fea);
           Featuretrn_selected = Featuretrn(:,fea);%training feature,categ_training is train label
            model=libsvmtrain(Labeltrain,Featuretrn_selected,'-t 2');
            [predict_label,accuracy]=libsvmpredict(Labeltest,Featuretst(:,fea),model);
            Acc(i)=accuracy(1);
            Sens(i)= length(find(predict_label+Labeltest==2))/length(find(Labeltest==1)); %% for +1 specific
            Spec(i)= length(find(predict_label+Labeltest==-2))/length(find(Labeltest==-1));
        end
%         idx=ceil(N_fea/10);
       Acc_overall(1,N_fea)=mean(Acc);
       Spec_overall(1,N_fea)=nanmean(Spec)*100;
       Sens_overall(1,N_fea)=nanmean(Sens)*100;
   end

end



