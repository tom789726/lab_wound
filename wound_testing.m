close; clc; clear all;
img = imread('C:\Users\tom78\Documents\MATLAB\img_test.jpg');


figure
subplot(1,2,1);
imshow(img,[]);

subplot(1,2,2);
imshow(img,[]);
colormap jet


figure
%Split into RGB Channels
Red = img(:,:,1);
Green = img(:,:,2);
Blue = img(:,:,3);
%Get histValues for each channel
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);
%Plot them together in one plot
% plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
subplot(3,1,1);
% plot(x,yRed,'r');
area(x,yRed);
% fill(x,yRed,'r');
% patch(yRed,x,'Red');
subplot(3,1,2);
plot(x,yBlue,'g');
subplot(3,1,3);
plot(x,yGreen,'b');
