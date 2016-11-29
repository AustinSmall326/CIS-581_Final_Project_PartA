I         = imread('Images/outdoors.jpg');
[Ic, T] = carv(I, 150, 5);

figure;
image(Ic);
hold on;
axis off;
