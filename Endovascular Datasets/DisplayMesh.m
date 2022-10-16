clc;
clear;

load Mesh_Soft_EM_Mod_0601;

%%
figure(1);
trimesh(tri,ver(:,1),ver(:,2),ver(:,3));
axis equal;

%%
FV.vertices = ver;
FV.faces = tri;

figure(2);
patch(FV,'facecolor',[1 0 0],'facealpha',0.8,'edgecolor','none');
view(3)
camlight 
axis equal;