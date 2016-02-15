 function ExportStlFilesInFolderGroupsWithImages(settings,listOfSTLFiles)
 
 count2 = 1;
% make a new folder
folder = sprintf('Group%i',foldercount);
foldercount = foldercount+1;

newFolderName = fullfile(targetDir,folder);
if(makeNewdirectories ==1)
    mkdir(newFolderName);
end

csvFileName = fullfile(targetDir, '3dprint.csv');
fileID = fopen(csvFileName,'w');

for i = 1:length(listOfSTLFiles)
  
    % -------------------------
    % Make a new folder every "numberOfFilesPerGroup"    
    % -------------------------
    
    if(mod(i,numberOfFilesPerGroup)==0)
        folder = sprintf('Group%i',foldercount);
        foldercount = foldercount+1;
        newFolderName = fullfile(targetDir,folder);        
         fprintf(fileID,'\n');         
        if(makeNewdirectories ==1)            
            mkdir(newFolderName);
        end        
    end
    
    % -------------------------
    % Copy the file to the new folder
    % -------------------------
    stl  = listOfSTLFiles(i);    
    newFilePath = fullfile(newFolderName,stl.renamedFileName);
    if(doCopyFilesToNewLocation==1)
        copyfile(stl.renamedPath,newFilePath);
    end
    % temp = [cellstr(num2str(foldercount)),   cellstr(num2str(i)),cellstr(newFolderName),cellstr( stl.renamedPath)]
    %temp = temp
    % csvFileArray(i,:) =  temp;
    fprintf(fileID,'%i, %i, %s, %s ,%s\n',foldercount-1,i,newFolderName,stl.renamedPath, stl.username );
    
   fprintf('%i   %s cpy to %s\n',i, stl.renamedPath,newFilePath);
   
   if(makeImages ==1)
       try
         FourViews(newFilePath)
       catch
            warning('Some problem creating the 4 views for the current model');
       end
       close all; % reset the figure
   end
end

fclose(fileID);
csvFileName
