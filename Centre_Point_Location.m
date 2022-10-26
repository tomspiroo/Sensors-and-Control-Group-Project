close all
clear all

set(0,'DefaultFigureWindowStyle','docked')
gui = srcapp;
drawnow
for imgno = 1:2002
    %% Initilisation of image

    % Read the designated original image and convert it to grey scale
    I = imread(strcat(num2str(imgno),'.jpg'));
    GSI = rgb2gray(I);

    % Apply the mask that turns all values less than 150 to 0, making them
    % black
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

    % Setting up the x and y matrixes and making 8 points that are 40 pixles from
    % the centre of the image at different angles. Angles of 0 and 90 degrees
    % are not included since it will hit the intense points of the cross hairs
    % of the ultrasound camera. This occurs for four quadrants of the images
    % starting from its center.
    % After which a for loop iterates the point along the its angle until it
    % reaches an intense point and stores the x and y coordinate within an
    % array.

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

    % This section plots the processed image and plots all of the edge
    % detection points from the stored x and y values, thus lining the inner
    % ring of the lumen.
    figure (1)
    imshow(GSI);
    axis on
    hold on
    for g = 1:8
        plot(x1(:,g),y1(:,g),'r.', 'MarkerSize', 10);
        plot(x3(:,g),y3(:,g),'g.', 'MarkerSize', 10);
        plot(x4(:,g),y4(:,g),'b.', 'MarkerSize', 10);
        plot(x2(:,g),y2(:,g),'y.', 'MarkerSize', 10);
    end

    %% Finding maximums and minimums

    % This section determines the maximum and minimum points stored within the
    % x and y arrays our of all four quadrants.

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
        plot(maxCoordY(1,1),maxCoordY(1,2), 'r.', 'MarkerSize',20);
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
        plot(maxCoordY(1,1),maxCoordY(1,2), 'r.', 'MarkerSize',20);
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
        plot(minCoordX(1,1),minCoordX(1,2), 'r.', 'MarkerSize',20);
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
        plot(minCoordX(1,1),minCoordX(1,2), 'r.', 'MarkerSize',20);
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
        plot(maxCoordX(1,1),maxCoordX(1,2), 'r.', 'MarkerSize',20);
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
        plot(maxCoordX(1,1),maxCoordX(1,2), 'r.', 'MarkerSize',20);
    end

    %% Centre point from min and max values

    % This section takes the maximums and minimums and drawns a line between
    % them, this it used the line_intersection function to get the centrepoint
    % location

    plot([maxCoordX(1) minCoordX(1)], [maxCoordX(2) minCoordX(2)], 'w-', 'LineWidth', 1);
    plot([maxCoordY(1) minCoordY(1)], [maxCoordY(2) minCoordY(2)], 'w-', 'LineWidth', 1);

    line1 = [maxCoordX(1) maxCoordX(2) minCoordX(1) minCoordX(2)];
    line2 = [maxCoordY(1) maxCoordY(2) minCoordY(1) minCoordY(2)];

    [x_int, y_int] = line_intersection(line1,line2);

    plot(x_int, y_int, 'rx', 'MarkerSize', 20);



    %% GUI Demo

    %Change number depending on what image you want processed
    ImageNumber = num2str(imgno);
    %Change RawImage
    gui.RawImage.ImageSource = strcat(num2str(ImageNumber),'.jpg');
    %OR
    img = imread(strcat(num2str(ImageNumber),'.jpg'));
    gui.RawImage.ImageSource = img;
    %Change ProcImage same as above, with handle gui.ProcImage. Centrepoint
    %same as above with gui.CentreImage
    GSI_Masked = imread(strcat(num2str(ImageNumber),'p.jpg'));
    SmallConvert = cat(3, GSI_Masked,GSI_Masked,GSI_Masked);
    gui.ProcImage.ImageSource = SmallConvert;

    CentrePointLoc = imread(strcat(num2str(ImageNumber),'c.jpg'));
    gui.CentreImage.ImageSource = CentrePointLoc;
    
    centrepoint = [x_int,y_int];
    camcentre = [392,392];
    distancebetween = norm(centrepoint - camcentre);
    slope = (y_int - 392) / (x_int - 392);
    angle = atan(slope);
    angledeg = rad2deg(angle);
    angleout = 180+angledeg;
    %Change rotation value
    gui.RotationOut.Value = angleout;

    %Change bend value
    gui.BendOut.Value = distancebetween*100/392;
    drawnow
    
end

    %% Distance function

    % This is a brief function to determine the distance between an inputted x
    % and y point.

    function distance = dist(x , y)
        distance = sqrt((392 - x)^2 + (392 - y)^2);
    end