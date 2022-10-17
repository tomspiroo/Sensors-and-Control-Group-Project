close all
clear all

set(0,'DefaultFigureWindowStyle','docked')
%% Initilisation of image
I = imread('571.jpg');
GSI = rgb2gray(I);

for i=1:784
    for j=1:784
        if GSI(i,j) < 125
            GSI(i,j) = 0;
        end
    end
end
%Diameter of the centre circle is approx 80 pixles

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
    while GSI(y1(1,i),x1(1,i)) == 0 && dist(x1(1,i),y1(1,i)) < 392
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
    while GSI(y2(1,i),x2(1,i)) == 0 && dist(x2(1,i),y2(1,i)) < 392
        x2(1,i) = round(392 - (z * sin (deg2rad(i * 10))));
        y2(1,i) = round(392 - (z * cos (deg2rad(i * 10))));
        z = z + 1;
    end
end


% Bottom right points
x3 = zeros(1,8);
y3 = zeros(1,8);
for t = 10:10:80
    x3(:,t/10) = round(392 + (35 * sin (deg2rad(t))));
    y3(:,t/10) = round(392 + (35 * cos (deg2rad(t))));
end
for i = 1:8
    z = 35;
    while GSI(y3(1,i),x3(1,i)) == 0 && dist(x3(1,i),y3(1,i)) < 392
        x3(1,i) = round(392 + (z * sin (deg2rad(i * 10))));
        y3(1,i) = round(392 + (z * cos (deg2rad(i * 10))));
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
    while GSI(y4(1,i),x4(1,i)) == 0 && dist(x4(1,i),y4(1,i)) < 392
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

% Minimum y (up)
miny1 = min(y1);
miny2 = min(y2);
if miny1 < miny2
    counter = 1;
    for i = 1:8
        if miny1 == y1(1,i)
            break
        else
            counter = counter + 1;
        end
    end
    minCoordY = [x1(1,counter) miny1];
else
    counter = 1;
    for i = 1:8
        if miny2 == y2(1,i)
            break
        else
            counter = counter + 1;
        end
    end
    minCoordY = [x2(1,counter) miny2];
end
    
% Maximum y (down)
maxy1 = max(y3);
maxy2 = max(y4);
if maxy1 > maxy2
    counter2 = 1;
    for i = 1:8
        if maxy1 == y3(1,i)
            break
        else
            counter2 = counter2 + 1;
        end
    end
    maxCoordY = [x3(1,counter2) maxy1];
    plot(maxCoordY(1,1),maxCoordY(1,2), 'w.', 'MarkerSize',20);
else
    counter2 = 1;
    for i = 1:8
        if maxy2 == y4(1,i)
            break
        else
            counter2 = counter2 + 1;
        end
    end
    maxCoordY = [x4(1,counter2) maxy2];
    plot(maxCoordY(1,1),maxCoordY(1,2), 'w.', 'MarkerSize',20);
end

% Min x (left)
minx1 = min(x2);
minx2 = min(x4);
if minx1 < minx2
    counter = 1;
    for i = 1:8
        if minx1 == x2(1,i)
            break
        else
            counter = counter + 1;
        end
    end
    minCoordX = [minx1 y2(1,counter)];
    plot(minCoordX(1,1),minCoordX(1,2), 'w.', 'MarkerSize',20);
else
    counter = 1;
    for i = 1:8
        if minx2 == x4(1,i)
            break
        else
            counter = counter + 1;
        end
    end
    minCoordX = [minx2 y4(1,counter)];
    plot(minCoordX(1,1),minCoordX(1,2), 'w.', 'MarkerSize',20);
end
        
% Maximum x (right)
maxx1 = max(x1);
maxx2 = max(x3);
if maxx1 > maxx2
    counter3 = 1;
    for i = 1:8
        if maxx1 == x1(1,i)
            break
        else
            counter3 = counter3 + 1;
        end
    end
    maxCoordX = [maxx1 y1(1,counter)];
    plot(maxCoordX(1,1),maxCoordX(1,2), 'w.', 'MarkerSize',20);
else
    counter3 = 1;
    for i = 1:8
        if maxx2 == x3(1,i)
            break
        else
            counter3 = counter3 + 1;
        end
    end
    maxCoordX = [maxx2 y3(1,counter3)];
    plot(maxCoordX(1,1),maxCoordX(1,2), 'w.', 'MarkerSize',20);
end

%% Centre point from min and max values

plot([maxCoordX(1) minCoordX(1)], [maxCoordX(2) minCoordX(2)], 'w-', 'LineWidth', 1);
plot([maxCoordY(1) minCoordY(1)], [maxCoordY(2) minCoordY(2)], 'w-', 'LineWidth', 1);

line1 = [maxCoordX(1) maxCoordX(2) minCoordX(1) minCoordX(2)];
line2 = [maxCoordY(1) maxCoordY(2) minCoordY(1) minCoordY(2)];

[x_int, y_int] = line_intersection(line1,line2);

plot(x_int, y_int, 'wx', 'MarkerSize', 20);

%% Distance function
function distance = dist(x , y)
    distance = sqrt((392 - x)^2 + (392 - y)^2);
end
