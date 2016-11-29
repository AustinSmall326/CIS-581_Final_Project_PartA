% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    maskImage.m
% Input:        img:    h x w x 3 matrix representing the source image.
% Output:       mask:   h x w logical matrix representing the replacement
%                       region.

function [mask] = maskImage(Img)
    figure;
    image(Img);
    h = imfreehand;
    mask = createMask(h);
    close all;
end

