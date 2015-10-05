% Assume that all the student's work is in a folder with their user name. 
% So if Anthony Garland and John Minor have submitted files, then the dir
% tree looks like

% .
% ..
% apg/
% jminor/

% Within each student's folder, there should be some .stl files. 
% Find these .stl files, and put into a list. 

clear
close all
clc

% ---------------------
% Settings
% --------------------


% Get a list of all files and folders in this folder.
targetDir = 'E:\Fall2015\P1\Unzipped';
numberOfFilesPerGroup = 10;
foldercount =1; % folder numbering starts at this value. (should be 1 for most applications)
makeImages = 0; % Set to 1 to make the 4 vies of each .stl file. 
doRenameFiles = 0; % Set to 1 for normal use, set to 0 while developing code
doCopyFilesToNewLocation = 0; % Set to 1 for normal use. 0 while developing. 
makeNewdirectories = 0; % set to 1 for normal use, 0 while developing. 


% ---------------------
% Main code. 
% Find all the student folders
% --------------------

files = dir(targetDir);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
% Print folder names to command window.


count = 1;
% Get folders in the array 1 by 1
% ignore the first two directories (. and ..)
for i = 3:length(subFolders)
    % fprintf( '%s\n', subFolders(i).name); % Print the name
     
     studentFolder = fullfile(targetDir,subFolders(i).name);
     fprintf( '%s\n',   studentFolder); 
     
     % Get a list of all the files a student submitted
     filelist = getAllFiles(studentFolder);    
     
     fileNum = 1;
     for j =1:length( filelist)
         
         % seperate each file into its path, name, and extension type
         pathOriginal = char(filelist(j));
         [pathstr,name,ext] = fileparts(pathOriginal);
         
         % covert the extension to lower case
         ext = lower(ext);
         
         % check if a .stl file
         if(strcmp(ext,'.stl'))
             
              % -------------------------------
              % Rename the file 
              % username)_file#
              % -------------------------------             
             renamedFileName = sprintf('%s_file%i.stl',char(subFolders(i).name),fileNum);
             fileNum = fileNum+1;
             renamedFileNamePath = fullfile(pathstr,renamedFileName);             
             if(doRenameFiles==1)
                movefile(pathOriginal,renamedFileNamePath);
             
             end
             
            
             % --------------------
             % Save the .stl file in a list
             % ----------------
             stl = stlFile;
             stl.username = char(subFolders(i).name);
             stl.originalPath = pathOriginal;
             stl.renamedPath = renamedFileNamePath;
              stl.renamedFileName = renamedFileName;
             
             listOfSTLFiles(count) = stl;
             count = count+1;
             
            
             
         end
     end
end


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


% csvwrite(csvFileName,csvFileArray);


% fprintf(fileID,'%6s %12s\n','x','exp(x)');
% fprintf(fileID,'%6.2f %12.8f\n',A);
fclose(fileID);
csvFileName