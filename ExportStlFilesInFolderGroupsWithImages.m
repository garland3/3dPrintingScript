function ExportStlFilesInFolderGroupsWithImages(settings,listOfSTLFiles)

count2 = 1;
localFolderCounter=settings.foldercount;
% make a new folder
folder = sprintf('Group%i',localFolderCounter);
localFolderCounter = localFolderCounter+1;

newFolderName = fullfile(settings.outputDir,folder);
if(settings.makeNewdirectories ==1)
    mkdir(newFolderName);
end

summer = 0;% by default, not in summer mode. 
% Do a single string compare, and then just use the summer var afterward. 
if(strcmp(settings.semester,'summer'))
    summer = 1;
end


csvFileName = fullfile(settings.outputDir, '3dprint.csv');
%fileID = fopen(csvFileName,'w');

if(summer==0)
   
else(summer==1)
    % Change the list of list .stl files to be only those that were
    % requested.
    listOfSTLFiles = GetListOfRequestedSTLFiles(settings,listOfSTLFiles);
end

 numFiles = length(listOfSTLFiles);

for i = 1:numFiles
    
    % -------------------------
    % Make a new folder every "numberOfFilesPerGroup"
    % -------------------------
    
    if(mod(i,settings.numberOfFilesPerGroup)==0)
        folder = sprintf('Group%i',localFolderCounter);
        localFolderCounter = localFolderCounter+1;
        newFolderName = fullfile(settings.outputDir,folder);
        fprintf(newFolderName,'\n');
        if(settings.makeNewdirectories ==1)
            mkdir(newFolderName);
        end
    end
    
    % -------------------------
    % Copy the file to the new folder
    % -------------------------
    stl  = listOfSTLFiles(i);
    newFilePath = fullfile(newFolderName,stl.renamedFileName);
    if(settings.doCopyFilesToNewLocation==1)
        copyfile( stl.originalPath,newFilePath);
    end
    % temp = [cellstr(num2str(foldercount)),   cellstr(num2str(i)),cellstr(newFolderName),cellstr( stl.renamedPath)]
    %temp = temp
    % csvFileArray(i,:) =  temp;
    %     fprintf(fileID,'%i, %i, %s, %s ,%s , %s, %s\n',foldercount-1,i,newFolderName,stl.renamedPath, stl.username, stl.sectionNumber, );
    temp1 = {int2str(localFolderCounter-1), int2str(i), newFolderName, stl.renamedPath , stl.username , stl.sectionNumber, stl.FirstName,  stl.LastName};
    fileInfo(i,:) = temp1;
    
    fprintf('%i   %s cpy to %s\n',i, stl.renamedPath,newFilePath);
    
    if(settings.makeImages ==1)
        try
            FourViews(newFilePath)
        catch
            warning('Some problem creating the 4 views for the current model');
        end
        close all; % reset the figure
    end
end

% fclose(fileID);
% csvwrite(csvFileName, fileInfo)
cell2csv(csvFileName,fileInfo,',')
csvFileName
