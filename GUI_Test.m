%% GUI Test
%Open app with handle "GUI"
gui = srcapp
%Change RawImage
gui.RawImage.ImageSource = '1200.jpg';
%OR
img = imread('1200.jpg');
gui.RawImage.ImageSource = img;
%Change ProcImage same as above, with handle gui.ProcImage. Centrepoint
%same as above with gui.CentreImage

%Change rotation value
gui.RotationOut.Value = 145;

%Change bend value
gui.BendOut.Value = 70;
