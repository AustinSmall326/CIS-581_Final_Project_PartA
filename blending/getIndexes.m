% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    getIndexes.m
% Input:        mask:    h x w logical matrix representing the replacement
%                        region.
%               targetH: target image height, h'.
%               targetW: target image width, w'.
%               offsetX: the x axis offset of source image regard of target
%                        image.
%               offsetY: the y axis offset of source image regard of target
%                        iamge.
% Output:       indexes: h' x w' matrix representing the indices of each
%                        replacement pixel.  0 means not a replacement
%                        pixel.

function indexes = getIndexes(mask, targetH, targetW, offsetX, offsetY)
    indexes = zeros(targetH, targetW);
    indexes(offsetY + 1 : offsetY + size(mask, 1), ...
            offsetX + 1 : offsetX + size(mask, 2)) = mask;
        
    % Iterate through indexes matrix.
    index = 1;
    
    for i = 1 : targetH
        for j = 1 : targetW
            if (indexes(i, j) == 1)
                indexes(i, j) = index;
                index = index + 1;
            end
        end
    end
end
