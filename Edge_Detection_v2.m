close all
clear all
%% Initilisation of image
I = imread('1200.jpg');
GSI = rgb2gray(I);

for i=1:784
    for j=1:784
        if GSI(i,j) < 150
            GSI(i,j) = 0;
        end
    end
end
%Diameter of the centre circle is approx 80 pixles

%% Calculating points around lumen
% Top right points
x1 = zeros(1,8);
y1 = zeros(1,8);
for t = 10:10:80
    x1(:,t/10) = round(392 + (40 * sin (deg2rad(t))));
    y1(:,t/10) = round(392 - (40 * cos (deg2rad(t))));
end
for i = 1:8
    z = 40;
    while GSI(y1(1,i),x1(1,i)) == 0
        x1(1,i) = round(392 + (z * cos (deg2rad(i * 10))));
        y1(1,i) = round(392 - (z * sin (deg2rad(i * 10))));
        z = z + 1;
    end
end


% Top left points
x2 = zeros(1,8);
y2 = zeros(1,8);
for t = 10:10:80
    x2(:,t/10) = round(392 - (40 * sin (deg2rad(t))));
    y2(:,t/10) = round(392 - (40 * cos (deg2rad(t))));
end
for i = 1:8
    z = 40;
    while GSI(y2(1,i),x2(1,i)) == 0
        x2(1,i) = round(392 - (z * sin (deg2rad(i * 10))));
        y2(1,i) = round(392 - (z * cos (deg2rad(i * 10))));
        z = z + 1;
    end
end


% Bottom right points
x3 = zeros(1,8);
y3 = zeros(1,8);
for t = 10:10:80
    x3(:,t/10) = round(392 + (35 * cos (deg2rad(t))));
    y3(:,t/10) = round(392 + (35 * sin (deg2rad(t))));
end
for i = 1:8
    z = 35;
    while GSI(y3(1,i),x3(1,i)) == 0
        x3(1,i) = round(392 + (z * cos (deg2rad(i * 10))));
        y3(1,i) = round(392 + (z * sin (deg2rad(i * 10))));
        z = z + 1;
    end
end


% Bottom left points
x4 = zeros(1,8);
y4 = zeros(1,8);
for t = 10:10:80
    x4(:,t/10) = round(392 - (40 * sin (deg2rad(t))));
    y4(:,t/10) = round(392 + (40 * cos (deg2rad(t))));
end
for i = 1:8
    z = 40;
    while GSI(y4(1,i),x4(1,i)) == 0
        x4(1,i) = round(392 - (z * cos (deg2rad(i * 10))));
        y4(1,i) = round(392 + (z * sin (deg2rad(i * 10))));
        z = z + 1;
    end
end

%% Plotting points
figure (1)
imshow(GSI);
axis on
hold on
for g = 1:8
    plot(x1(:,g),y1(:,g),'r.', 'MarkerSize', 10);
    plot(x2(:,g),y2(:,g),'y.', 'MarkerSize', 10);
    plot(x3(:,g),y3(:,g),'g.', 'MarkerSize', 10);
    plot(x4(:,g),y4(:,g),'b.', 'MarkerSize', 10);
end

%% Finding maximums and minimums

