target = imread('Images/target.jpg');
source = imread('Images/source.jpg');

% Specify source image size and position within target image.
sourceOffsetX = 200;
sourceOffsetY = 10;

sourceWidth = 300;
sourceHeight = 250;

% Generate resized source image.
source = imresize(source, [sourceHeight, sourceWidth]);

% Generate source mask.
[sourceMask] = maskImage(source);

[resultImg] = seamlessCloningPoisson(source, target, sourceMask, sourceOffsetX, sourceOffsetY);

image(resultImg);
