pkg load statistics
pkg load image

#------------------------------------------------------------------
# Removing the background
#------------------------------------------------------------------
RGBImage = imread("test_img/img7.jpg");
#Removing the page
GrayImage = rgb2gray(RGBImage);
mask = GrayImage < 130;
#imshow(flipud(mask))

#------------------------------------------------------------------
# Removing the parallel lines of a page
#------------------------------------------------------------------
mask = mask*1.0;
GrayImage = GrayImage .* mask;    #grayscale of only for background less page

#SUM OF THE PIXELS IN THE ROW
[m n]=size(GrayImage);
rowsum=zeros(m,1);
for i=1:m
  rowsum(i,1)=sum(GrayImage(i,:));
end

#FINDING THE FIRST DERIVATIVE
#first derivative
rowsum_d1=zeros(m,1);
for i=2:m
  rowsum_d1(i,1) = rowsum(i,1) - rowsum(i-1,1);
end

#PLOTING
#figure,plot(rowsum),title("ROWSUM")
#figure,plot(rowsum_d1),title("ROWSUM DERIVATIVE")

#FINDING PROBABLE ROW INDEX
[sortedValues,sortIndex] = sort(rowsum_d1(:),'descend');
maxIndex = sortIndex(1:20);

#FINDING THE COLORS CHANNELS
channelR = RGBImage(:, :, 1);
channelG = RGBImage(:, :, 2);
channelB = RGBImage(:, :, 3);

#MEAN R,G,B COLOR IN PREDICTED ROW INDEX
MEANR = 0;
MEANG = 0;
MEANB = 0;
cnt = 0;
channelR = channelR .* mask;
channelG = channelG .* mask;
channelB = channelB .* mask;

for i = 1:20
  MEANR = MEANR + sum(channelR(maxIndex(i),:));
  MEANG = MEANG + sum(channelB(maxIndex(i),:));
  MEANB = MEANB + sum(channelG(maxIndex(i),:));
  cnt = cnt + sum(mask(maxIndex(i),:));
end

MEANR = MEANR / cnt;
MEANG = MEANG / cnt;
MEANB = MEANB / cnt;

MEANR
MEANG
MEANB

#--------------------------------------------------------------
# IMAGE SEGMENTATION USING DETECTION USING LINE COLOR
#--------------------------------------------------------------


#FINDING THE COLORS CHANNELS
channelR = RGBImage(:, :, 1);
channelG = RGBImage(:, :, 2);
channelB = RGBImage(:, :, 3);

dR = double(channelR - MEANR);
dG = double(channelG - MEANG);
dB = double(channelB - MEANB);

# calculate overall distance from the given RGB color
 d = dR.^2 + dG.^2 + dB.^2;

# create a mask by thresholding the differences
mask_line = d < 3000;

figure,imshow(mask_line)

#mask = mask & mask_line;

#wrinting back the page
alpha = mask*255;
imwrite(RGBImage,'your_image.png','Alpha',alpha);

pause()
