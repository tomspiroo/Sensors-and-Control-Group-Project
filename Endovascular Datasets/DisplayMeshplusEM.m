clc;
clear;

load Mesh_Soft_EM_Mod_0601;
em = [];
currentdir = cd;
for i = 0:1:2002
    filepath = strcat('logfile_2014-12-05_17-32-16_Soft_pullback_1\EM\',string(i),'.txt');
    read = table2array(readtable(filepath,'Delimiter',' ','ReadVariableNames',false));
    for j = 1:1:size(read,2)
        em(i + 1,j) = read(1,j);
    end
end


%%
figure(1);
trimesh(tri,ver(:,1),ver(:,2),ver(:,3));
axis equal;

%%
FV.vertices = ver;
FV.faces = tri;

figure(2);
patch(FV,'facecolor',[1 0 0],'facealpha',0.3,'edgecolor','none');
view(3)
camlight 
hold on
for i = 1:1:size(em,1)
    scatter3(em(i,1),em(i,2),em(i,3))
    hold on
end