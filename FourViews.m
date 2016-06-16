function FourViews(filePath)


 [pathstr,name,ext] = fileparts(filePath);

xviews = [0 0 90 35]; % the rotation in angle in for each view in the X
yviews = [0 90 90 35]; % the rotation angle for each view in the Y
for i = 1:4
    % use the same figure, but change the subplot
    figure(1)
    subplot(2,2,i)
    % stldemo( 'femur.stl', -135+90*i, 35)
   % stldemo( 'femur.stl', xviews(i),  yviews(i))
     stldemo( filePath, xviews(i),  yviews(i))
     
     % -------------------------------
     % Add a title
     % -------------------------------
     titleName = sprintf('%s ',name);
     title(titleName);
   
end

% --------------------------------------
% Save the image as a png file
% -------------------------------------

fName = sprintf('%s.png',name);
 nameGraph = fullfile(pathstr,fName);         
% nameGraph = sprintf('%s.png', renamedFileNamePath);
 print(nameGraph,'-dpng')