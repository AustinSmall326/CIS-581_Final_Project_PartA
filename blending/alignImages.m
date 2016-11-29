target = imread('Images/target.jpg');
source = imread('Images/source.jpg');

sourceOffsetX = 200;
sourceOffsetY = 10;

sourceWidth = 300;
sourceHeight = 250;

newSource = imresize(source, [sourceHeight, sourceWidth]);

image(target);
hold on;
image(sourceOffsetX, sourceOffsetY, newSource);