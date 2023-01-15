function [ FeaAll] = randomMap_Fea_selectSphere( pathset,maskset )
% The function is for rank moved algorithmn
% Input: pathset: the direction stored the individual rsFC;
%         maskset: the corresponding density maps for each seed region
% Output: Feature after randomly-walk masks 
   
    nbmask=length(maskset);
    
    for i=1:nbmask
    mask_rand=zeros(61,73,61);
    mask=cell2mat(maskset(1,i));
    %random-walk
    [m,n,k]=size(mask);
    [row,col]=find(mask);
    x=row;
    y=rem((col-1),n)+1;
    z=fix((col-1)/n)+1;
    %random value
  move_x=randperm(61);
  move_y=randperm(73);
  move_z=randperm(61);
    
    mask_rand=zeros(m,n,k);
    if 0<move_x & move_x<m & 0<move_y & move_y<n & 0<move_z & move_z<k 
        for  move_index=1:length(move_x)
        mask_rand(move_x(move_index),move_y(move_index),move_z(move_index))=1;
        end
        break;
    end
        %random value
        rand_1=randperm(5);
        rand_2=randperm(5);
       rand_3=randperm(5);
    % random direction
      rand_direct=randperm(2);
    % the random walk
         if rand_direct(1)==1
             move_x=x+rand_1(1);
             move_y=y+rand_2(1);
             move_z=z+rand_3(1);
        else
            move_x=x-rand_1(1);
            move_y=y-rand_2(1);
            move_z=z-rand_3(1);
        end
%       determine whether the the length of step exceed the brain
        if 0<move_x & move_x<m & 0<move_y & move_y<n & 0<move_z & move_z<k 
        % move each voxel of the mask
		for  move_index=1:length(move_x)
        mask_rand(move_x(move_index),move_y(move_index),move_z(move_index))=1;
        end
        else 
            break;
        end
    end
    end
    path1=char(pathset(1,2*i-1));
    Fea1= ConstructFea( path1, mask_rand);
    FeaAll(2*i-1)={Fea1};
    path2=char(pathset(1,2*i));
    Fea2= ConstructFea( path2, mask_rand);
    FeaAll(2*i)={Fea2};
  
    
end

