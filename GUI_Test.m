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
GSI_Masked = imread('1200p.jpg');
SmallConvert = cat(3, GSI_Masked,GSI_Masked,GSI_Masked);
gui.ProcImage.ImageSource = SmallConvert;

CentrePointLoc = imread('1200c.jpg');
gui.CentreImage.ImageSource = CentrePointLoc;
%Change rotation value
gui.RotationOut.Value = 145;

%Change bend value
gui.BendOut.Value = 70;
