% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    rmVerSeam.m
% Input:        I:      n x m x 3 matrix representing the input image.
%               Mx:     n x m matrix representing the cumulative minimum
%                       energy map along vertical direction.
%               Tbx:    n x m matrix representing the backtrack table along
%                       vertical direction.
% Output:       Ix:     (n - 1) x m x 3 matrix representing the image with
%                       the row removed.
%               E:      the cost of seam removal.

function [Ix, E] = rmVerSeam(I, Mx, Tbx)
    [ny, nx, nz] = size(I);
    rmIdx = zeros(ny, 1);
    Ix = uint8(zeros(ny, nx - 1, nz));

    % Determine pixel in last row to remove.
    [val, idx]    = min(Mx(end, :));
    rmIdx(end, 1) = idx;
    E             = val;
    
    for i = ny - 1 : -1 : 1
        shift = Tbx(i + 1, rmIdx(i + 1, 1)) - 2;
        rmIdx(i, 1) = rmIdx(i + 1, 1) + shift;                
    end
    
    % Copy pixels by row into output image.
    for i = 1 : ny
        tempRow = I(i, :, :);
        tempRow(:, rmIdx(i, 1), :) = [];
        Ix(i, :, :) = tempRow;
    end
end