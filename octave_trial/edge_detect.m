pkg load image
ColorImage = imread("test_img/img7.jpg");
GrayImage = rgb2gray(ColorImage);
[~, threshold] = edge(GrayImage, 'sobel');
fudgeFactor = 1;
BWs = edge(GrayImage,'sobel', threshold * fudgeFactor);
figure, imshow(flipud(BWs)), title('gradient mask');
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se0]);
figure, imshow(flipud(BWsdil)), title('dilated gradient mask se90');
BWsdil2 = imdilate(BWs, [se0]);
figure, imshow(flipud(BWsdil2)), title('dilated gradient mask se0');
pause()
