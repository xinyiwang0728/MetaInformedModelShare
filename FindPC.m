function [ Feature1,q1 ] = FindPC(FeatureNew)
%Generate the Pincipal component through community detection analysis and principal component analysis
% FeatureNew: the all feature set of seven seed region
% Feature1: the combine principal components
% q1: the modularity coefficients.
Feature=[];
q=[];
% % determine each pc
        for i=1:length(FeatureNew)
            feature=FeatureNew{:,i};
            averagefea=mean(feature,1);
            indexav= find(averagefea==0);
            feature(:,indexav)=[];
            tempfea=corr(feature);
           [Ci,Q]=modularity_und(tempfea,1);
           fea_pca=[];
           for k=1:max(Ci)
               pc1=feature(:,find(Ci==k));
               X = pc1-repmat(mean(pc1),size(pc1,1),1);
%                [eignvector, eignvalue]=eig(cov(X));
%                w=eignvector(end,:)';
%                pc=X*w;
            [coff,score]=pca(X);
            pc=score(:,1);
            fea_pca=[fea_pca,pc];
           end
           Feature=[Feature,fea_pca];
        end
 Feature1= Feature;
 q1=q;
end
