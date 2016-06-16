function teststlwriterotate()
clc
clear
close all
supportTheta = pi/4; % 45 degrees needs support

% test read and write .stl
% Write ascii STL from gridded data
%[X,Y] = deal(1:40);             % Create grid reference
%Z = peaks(40);                  % Create grid height
%stlwrite('test.stl',X,Y,Z,'mode','ascii')


FILENAME = 'bottle.stl';
[F,V,N] = stlread(FILENAME) ;

% get the min and max size of the bounding box of the .stl file
[xmin, xmax, ymin, ymax, zmin, zmax] = FindMinAndMax(V)
xp= 0;
xn = 0;
yp=0;
yn=0;
zp=0;
zn = 0;

xpunit= [1 0 0];
xnunit = [-1 0 0];
ypunit=[0 1 0];
ynunit=[0 -1 0];
zpunit=[0 0 1];
znunit = [0 0 -1];

arrayOfVectors = [xpunit;
                xnunit;
                ypunit;
                ynunit;
                zpunit;
                znunit];

% find if the normal direction of each triangle is pointed more than
% 'supportTheta' witih respect to the ground in each direction, if so, then
% find the distance from the centriod to the 'ground'. Then find the area
% of the triangle, then estimate how much support material will be needed.
[rows, col] = size(N)
for i = 1:rows
    % area of this triangle. 
    ind = F(i,:); % get indexes of points
    point1 = V(ind(1),:);
    point2 = V(ind(2),:);
    point3 = V(ind(3),:);
    vector1 = point3-point1;
    vector2 = point2-point1;
    areaOfTriangle = polyarea(vector1,vector2); %https://www.mathworks.com/matlabcentral/answers/41148-area-of-a-triangle
    
    
    % find the centriod of the triangle
    centroidX = (point1(1)+point2(1)+point3(1))/3;
    centroidY = (point1(2)+point2(2)+point3(2))/3;
    centroidZ = (point1(3)+point2(3)+point3(3))/3;
    
    
    % dot  prodcut to get angle, 
    normal = N(i,:);
    [zp, sp(i,1)] = AddToSupportMetric(zpunit,zmin,centroidZ,zp,normal,supportTheta,areaOfTriangle );
    [zn,sp(i,2)] = AddToSupportMetric(znunit,zmax,centroidZ,zn,normal,supportTheta,areaOfTriangle );
    
   [xp, sp(i,3)] = AddToSupportMetric(xpunit,xmin,centroidX,xp,normal,supportTheta,areaOfTriangle );
    [xn,sp(i,4)] = AddToSupportMetric(xnunit,xmax,centroidX,xn,normal,supportTheta,areaOfTriangle );
       
    [yp,sp(i,5)] = AddToSupportMetric(ypunit,ymin,centroidY,yp,normal,supportTheta,areaOfTriangle );
    [yn,sp(i,6)] = AddToSupportMetric(ynunit,ymax,centroidY,yn,normal,supportTheta,areaOfTriangle );
   
end


% theta = pi;
% matrix = [cos(theta) -sin(theta) 0;
%            sin(theta) cos(theta) 0;
%            0            0         1];
% 
% [rows, col] = size(V)
% for i = 1:rows
%      currentV = V(i,:)';
%      newV = matrix*currentV;
%      V_new(i,:) = newV';
% end
% File = 'bottle_new.stl'
% stlwrite(File, F, V_new)% takes faces and vertices separately,

zp
zn
xp
xn
yp
yn
[m,i]= min([zp zn xp xn yp yn])


% -----------------------------------
%
% Show triangles that need support
%
% ----------------------------------
[rows,columns] = size(sp);
for p = 1:6
    colorVector = zeros(rows,3);
    for i = 1:rows
        if sp(i,p) ==1
            colorVector(i,:) = [0.8 0.8 1.0];
        else
          colorVector(i,:) = [0.8 0.1 1.0];
        end


    end
   figure(p);
    x = V(:,1);
    y = V(:,2);
    z = V(:,3);
    patch('Faces',F,'Vertices',V,'FaceVertexCData',colorVector,'FaceColor','flat')
    %    patch(x,y,z  ,'FaceColor',       colorVector, ...
    %          'EdgeColor',       'none',        ...
    %          'FaceLighting',    'gouraud',     ...
    %          'AmbientStrength', 0.15);

    % Add a camera light, and tone down the specular highlighting
    camlight('headlight');
    %lighting flat
    material('metal');

    % Fix the axes scaling, and set a nice view angle
    axis('image');
    view([35 35]);
end



function [newsum supporteNeeded] = AddToSupportMetric(inputUnitVector,baseLocation,centroidDim,currentsum,triangleNormalVector, supportTheta,areaOfTriangle)
supporteNeeded=0;
normal = triangleNormalVector;
dotresult = dot(normal,inputUnitVector);
% magnitude of normal is 1
% magnitude of unit vector is1
angle = acos(dotresult);    
if(angle>supportTheta ||angle<-supportTheta)        

    distanceToBase = baseLocation-centroidDim;
    supportMetric = abs(areaOfTriangle)*abs(distanceToBase); % ie a volume = area*height
    newsum = currentsum+supportMetric;
    supporteNeeded=1;

else
    newsum = currentsum;
end



function [xmin, xmax, ymin, ymax, zmin, zmax] = FindMinAndMax(vertices)
V= vertices;

x = V(:,1);
y = V(:,2);
z = V(:,3);
xmin = min(x); 
xmax =  max(x);
ymin = min(y);
ymax = max(y);
zmin  = min(z);
zmax = max(z) ;

