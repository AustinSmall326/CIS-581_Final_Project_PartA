target = imread('Images/target.jpg');
source = imread('Images/planes.jpg');

% target = 10 * ones(30);
% source = [1   5   6   3   120;
%           3   200 150 200 2;
%           3   150 140 30  100;
%           100 150 3   5   1;
%           100 10  20  25  1];

sourceOffsetX = 350;
sourceOffsetY = 0;
% 
sourceWidth = 300;
sourceHeight = 250;

newSource = imresize(source, [sourceHeight, sourceWidth]);

image(target);
hold on;
image(sourceOffsetX, sourceOffsetY, newSource);