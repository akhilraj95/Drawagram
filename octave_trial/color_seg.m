pkg load image

RGBImage = imread("test_img/img7.jpg");
#Removing the page
GrayImage = rgb2gray(RGBImage);
mask = GrayImage < 130;
#imshow(flipud(mask))
alpha = mask*255;

#wrinting back the page
imwrite(RGBImage,'your_image.png','Alpha',alpha);

pause()
