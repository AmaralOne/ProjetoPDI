close all
clear


x = imread('100-10.jpg');
figure();imshow(x);

h = fspecial('average',[2 2]);
B = imfilter(x,h);
%figure();imshow(B);
B = imadjust(B,[],[],0.8); % Gamma correction.
x = imresize(B,0.5);
%x = imcrop(x,[65 1 200 210]);
d = imcrop(x,[50 0 220 240]);
figure();imshow(d);
y = imcrop(x,[63 25 207 180]);
figure();imshow(y);
%x = rgb2gray(x);
%figure();imshow(x);
%x = imread('10-10.jpg');
%faceDetector = vision.CascadeObjectDetector;
%bboxes = faceDetector(x);

%Ifaces = insertObjectAnnotation(x,'rectangle',bboxes,'Face');
%figure
%imshow(Ifaces)
%title('Detected faces');

%x = imcrop(x,bboxes);
%figure
%imshow(x)
%////title('faces');
