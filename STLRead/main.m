% Assume that all the student's work is in a folder with their user name. 
% So if Anthony Garland and John Minor have submitted files, then the dir
% tree looks like

% .
% ..
% apg/
% jminor/

% Within each student's folder, there should be some .stl files. 
% Find these .stl files, and put into a list. 



% Get a list of all files and folders in this folder.
targetDir = 'E:\Fall2015\P1\Unzipped';
numberOfFilesPerGroup = 10;

doRenameFiles = 0; % Set to 1 for normal use, set to 0 while developing code



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
foldercount =1;

% make a new folder
folder = sprintf('Group%i',foldercount);
foldercount = foldercount+1;

newFolderName = fullfile(targetDir,folder);
mkdir(newFolderName);

for i = 1:length(listOfSTLFiles)
  
    % -------------------------
    % Make a new folder every "numberOfFilesPerGroup"    
    % -------------------------
    
    if(mod(i,numberOfFilesPerGroup)==0)
        folder = sprintf('Group%i',foldercount);
        foldercount = foldercount+1;
        newFolderName = fullfile(targetDir,folder);
        mkdir(newFolderName);
        
    end
    
    % -------------------------
    % Copy the file to the new folder
    % -------------------------
    stl  = listOfSTLFiles(i);    
    newFilePath = fullfile(newFolderName,stl.renamedFileName);
    copyfile(stl.renamedPath,newFilePath);
   
   fprintf('%i   %s cpy to %s\n',i, stl.renamedPath,newFilePath);
   
   FourViews(newFilePath)
   close all; % reset the figure
    
    % copy numberOfStlfilesPerGroup here
  
    % run the script to make the 4 views of the .stl file. 
    
    
    
    
end



