# Sensors-and-Control-Group-Project
By:
Group number 7
Thomas Spiritosanto 13930603
Jeremy Mansfield 13204312

About the files in repository:
These files were worked on using Matlab. The files for the most part are 
testing and colaborative files that eventually make up the 
Centre_Point_Location.m file, thus this file will be heavily commented on
and of the files that are within this will not have detailed comments 
throughout.
When running the Centre_Point_Location.m file make sure all the files
present in the Github are added to the Path.
The only scripts that have not been created by the group is the 
DisplayMesh.m file (located in the Endovascular Datasets folder) and the 
line_intersection.m function filethat has appropriate referencing within 
the file.


Angle Functions tests folder:
These functions are used to test the lumen searching functions which are
put together in the Edge_Detection_v2.m file and the Centre_Point_location.m
file.

Folders added to the Endovascular Datasets folder:

    Centre Point Images folder:
    This folder contains figures saved as jpeg images with the centre point
    plotted on the image. It also contains the function that converts the 
    image.

    GSI Images folder:
    This folder contains the GSI converted images of the original images 
    given with the datasets. It also features the mask that was put into 
    place to make data manipulation easier. It also contains a file that 
    converted the original images to the processed image.
    
The .mlapp file:
This file is the GUI set up using Matlab's app designer where the design
of the GUI is made as well as specified callbacks that add functionalities
if an action is input by the user. This GUI is implimented in the
GUI_test.m file.

Errors found within the assignment:
Due to the methodology of the edge detection of the lumen there are 
centre points that are not an accurate representation of the centre of the
lumen. This is evident in the centre point images folder.

Future implimentations intended for the project:
- Fixing the centrepoint location of certain images so all are accurate
- Plotting the new updated planned path into the Mesh display of the aorta
- Implimenting the programmed path planning onto a real catheter that is 
  fed through a 3D printed aorta



