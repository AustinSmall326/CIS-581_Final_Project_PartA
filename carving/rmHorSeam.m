% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    rmHorSeam.m
% Input:        I:      n x m x 3 matrix representing the input image.
%               My:     n x m matrix representing the cumulative minimum
%                       energy map along horizontal direction.
%               Tby:    n x m matrix representing the backtrack table along
%                       horizontal direction.
% Output:       Iy:     (n - 1) x m x 3 matrix representing the image with
%                       the column removed.
%               E:      the cost of seam removal.

function [Iy, E] = rmHorSeam(I, My, Tby)
    [ny, nx, nz] = size(I);
    rmIdx = zeros(nx, 1);
    Iy = uint8(zeros(ny - 1, nx, nz));

    % Determine pixel in last column to remove.
    [val, idx]    = min(My(:, end));
    rmIdx(end, 1) = idx;
    E             = val;
    
    for i = nx - 1 : -1 : 1
        shift = Tby(rmIdx(i + 1, 1), i + 1) - 2;
        
        rmIdx(i, 1) = rmIdx(i + 1, 1) + shift;                
    end
    
    % Copy pixels by row into output image.
    for i = 1 : nx
        tempCol = I(:, i, :);
        tempCol(rmIdx(i, 1), :, :) = [];
        Iy(:, i, :) = tempCol;
    end
end