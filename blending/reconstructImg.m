% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    reconstructingImg.m
% Input:        indexes:    h' x w' matrix representing the indices of 
%                           each replacement pixel.
%               red:        1 x n vector representing the red channel 
%                           intensity of replacement pixel.
%               green:      1 x n vector representing the green channel
%                           intensity of replacement pixel.
%               blue:       1 x n vector representing the blue channel
%                           intensity of replacement pixel.
%               targetImg:  h' x w' x 3 matrix representing target image.
% Output:       resultImg:  h' x w' x 3 matrix representing blending image.

function resultImg = reconstructImg(indexes, red, green, blue, targetImg)
    resultImg = targetImg;
    
    % Iterate through target image.
    for i = 1 : size(targetImg, 1)
        for j = 1 : size(targetImg, 2)
            index = indexes(i, j);
            
            if (index > 0)
                temp = zeros(1, 1, 3);
                temp(1, 1, 1) = red(index, 1);
                temp(1, 1, 2) = green(index, 1);
                temp(1, 1, 3) = blue(index, 1);
                
                resultImg(i, j, :) = temp;
            end
        end
    end
end