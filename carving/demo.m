I         = imread('Images/im3.jpg');
[Ic, T] = carv(I, 0, 400);

figure;
image(Ic);