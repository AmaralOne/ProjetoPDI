close all
clear

x = imread('10-10.jpg');
figure();imshow(x);
x = imread('9-10.jpg');
figure();imshow(x);
x = imread('1-03.jpg');
figure();imshow(x);

h = fspecial('average',[7 7]);
B = imfilter(x,h);
%figure();imshow(B);
x = imresize(B,0.5);
%x = imcrop(x,[65 1 200 210]);
x = imcrop(x,[50 0 220 240]);
figure();imshow(x);
%x = rgb2gray(x);
%figure();imshow(x);
x = imread('10-10.jpg');
faceDetector = vision.CascadeObjectDetector;
bboxes = faceDetector(x);

Ifaces = insertObjectAnnotation(x,'rectangle',bboxes,'Face');
figure
imshow(Ifaces)
title('Detected faces');

x = imcrop(x,bboxes);
figure
imshow(x)
title('faces');
