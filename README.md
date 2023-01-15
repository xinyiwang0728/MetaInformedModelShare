# MetaInformedModelShare
#The code is for developing a meta-analysis informed machine-learning model
There are three main components to the framework.
1. Find PC.m. 
The function is to generate the abnormal circuits representation at the individual level. As shown in the figure3 in manuscript, step (c) to step (h) show how to generate the principal component through community detection and principal component analysis. 

2。class_libsvm_mrmr.m. 
The function is to classify patients from healthy individuals through a support vector machine. The code of the support vector machine is from the libsvm toolbox.
3. randomMap_Fea_select.m. 
The function is to design a random mask with the same shape and voxel size. We proposed a permutation test with shuffled features. We generated random features according to the randomly moved map. The moved map and random features were generated through this function. 
