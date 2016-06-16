function outputListOfStlFiles = GetListOfStlFiles(settings)

% ---------------------
% Find all the student folders
% --------------------
files = dir(settings.targetDir);
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
    
    studentFolder = fullfile(settings.targetDir,subFolders(i).name);
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
            renamedFileName = sprintf('%s-file%i.stl',char(subFolders(i).name),fileNum);
            fileNum = fileNum+1;
            renamedFileNamePath = fullfile(pathstr,renamedFileName);
            %if(settings.doRenameFiles==1)
            %    movefile(pathOriginal,renamedFileNamePath);
            % end
            
            % --------------------
            % Save the .stl file in a list
            % ----------------
            stl = stlFile;
            stl.username = char(subFolders(i).name);
            stl.originalPath = pathOriginal;
            stl.renamedPath = renamedFileNamePath;
            stl.renamedFileName = renamedFileName;
            
            outputListOfStlFiles(count) = stl;
            count = count+1;
        end
    end
end
