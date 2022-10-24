for t = 1:2002
I = imread(strcat(num2str(t),'.jpg'));
GSI = rgb2gray(I);

%Masking grey scale image
for i=1:784
    for j=1:784
        if GSI(i,j) < 125
            GSI(i,j) = 0;
        end
    end
end

% Making a white circle around the ultrasound image
xCenter = 392;
yCenter = 392;
radius = 391;
theta = linspace(0, 2*pi, round(4 * pi * radius));
xc = radius * cos(theta) + xCenter;
yc = radius * sin(theta) + yCenter;
for k = 1 : length(xc)
    row = round(yc(k));
    col = round(xc(k));
    GSI(row, col) = 255;
end

%imshow(GSI)
imwrite(GSI, strcat(num2str(t),'p.jpg'))
end