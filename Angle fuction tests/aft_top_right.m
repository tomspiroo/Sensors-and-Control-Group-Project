close all
clear all

I = imread('1200.jpg');
GSI = rgb2gray(I);

for i=1:784
    for j=1:784
        if GSI(i,j) < 150
            GSI(i,j) = 0;
        end
    end
end

%Diameter of the centre circle is approx 60 pixles
x = zeros(1,8);
y = zeros(1,8);
for t = 10:10:80
    x(:,t/10) = round(392 + (40 * sin (deg2rad(t))));
    y(:,t/10) = round(392 - (40 * cos (deg2rad(t))));
end


for i = 1:8
    z = 40;
    while GSI(y(1,i),x(1,i)) == 0
        x(1,i) = round(392 + (z * cos (deg2rad(i * 10))));
        y(1,i) = round(392 - (z * sin (deg2rad(i * 10))));
        z = z + 1;
    end
end

figure (1)
imshow(GSI);
axis on
hold on
for g = 1:8
    plot(x(:,g),y(:,g),'r.', 'MarkerSize', 10);
end
