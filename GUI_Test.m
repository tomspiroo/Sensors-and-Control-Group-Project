%% GUI Test
%Open app with handle "GUI"
gui = srcapp
%Change number depending on what image you want processed
ImageNumber = 1800;
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
%Change rotation value
gui.RotationOut.Value = 145;

%Change bend value
gui.BendOut.Value = 70;
