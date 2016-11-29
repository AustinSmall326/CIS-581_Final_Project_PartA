target = imread('Images/target.jpg');
source = imread('Images/planes.jpg');

% Specify source image size and position within target image.
sourceOffsetX = 350;
sourceOffsetY = 0;
% 
sourceWidth = 300;
sourceHeight = 250;


% Generate resized source image.
%target = imresize(target, [targetHeight, targetWidth]);
source = imresize(source, [sourceHeight, sourceWidth]);

figure(100);
image(source)
figure;
% Generate source mask.
[sourceMask] = maskImage(source);

% Convert source and target to doubles.
target = double(target);
source = double(source);

% source = [8 1 8 9;
%           1 0 7 10;
%           2 5 6 7;
%           3 4 5 6];
% target = [1 8 3 5 6 3 2 6;
%           2 5 7 3 4 5 6 1;
%           5 6 7 4 9 8 9 9;
%           9 3 5 6 2 3 4 1;
%           2 3 2 2 2 3 5 6;
%           3 4 6 6 1 9 8 8;
%           3 2 1 1 1 1 9 8;
%           9 3 3 1 3 2 0 0];
      
%       sourceOffsetX = 2;
%       sourceOffsetY = 2;
%       
%       sourceMask = [0 0 1 1;
%                     1 0 1 1;
%                     1 1 1 0;
%                     1 1 0 0];

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

image(uint8(resultImg));