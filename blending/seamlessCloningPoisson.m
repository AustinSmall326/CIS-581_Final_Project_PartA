% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    seamlessCloningPoisson.m
% Input:        sourceImg:  h x w x 3 matrix representing source image.
%               targetImg:  h x w' x 3 matrix representing target image.
%               mask:       h x w logical matrix representing the
%                           replacement region.
%               offsetX:    the x axis offset of source image regard of 
%                           target image.
%               offsetY:    the y axis offset of source image regard of 
%                           target image.
% Output:       resultImg:  h' x w' x 3 matrix representing blending 
%                           image.

function resultImg = seamlessCloningPoisson(source, target, sourceMask, sourceOffsetX, sourceOffsetY)
    % Convert source and target to doubles.
    target = double(target);
    source = double(source);

    % Index replacement pixels.
    indexes = getIndexes(sourceMask, size(target, 1), size(target,2 ), sourceOffsetX, sourceOffsetY);

    % Generate coefficient matrix.
    [coefM] = getCoefMatrix(indexes);

    % Generate solution vectors for RBG color components.
    [solVectorR] = getSolutionVect(indexes, source(:, :, 1), target(:, :, 1), sourceOffsetX, sourceOffsetY);
    [solVectorG] = getSolutionVect(indexes, source(:, :, 2), target(:, :, 2), sourceOffsetX, sourceOffsetY);
    [solVectorB] = getSolutionVect(indexes, source(:, :, 3), target(:, :, 3), sourceOffsetX, sourceOffsetY);

    % Solve for RGB intensity values of replacement pixels.
    R = mldivide(coefM, solVectorR);
    G = mldivide(coefM, solVectorG);
    B = mldivide(coefM, solVectorB);

    % Construct output image.
    resultImg = reconstructImg(indexes, R, G, B, target);

    resultImg = uint8(resultImg);
end