I         = imread('Images/outdoors.jpg');
[Ic, T] = carv(I, 200, 0);

figure;
image(Ic);
hold on;
axis off;
title('Remove 250 Vertical Seams', 'FontSize', 15);