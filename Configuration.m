classdef Configuration
    
    properties
        % --------
        targetDir;
        numberOfFilesPerGroup;       
        
        foldercount =1; % folder numbering starts at this value. (should be 1 for most applications)
        makeImages = 0; % Set to 1 to make the 4 vies of each .stl file.
        doRenameFiles = 0; % Set to 1 for normal use, set to 0 while developing code
        doCopyFilesToNewLocation = 0; % Set to 1 for normal use. 0 while developing.
        makeNewdirectories = 0; % set to 1 for normal use, 0 while developing.
        csvFileWithUsernamesAndSections;
        semester = 'summer'; % Either 'semester' for normal, or 'summer' for printing requested bottles.
        csvFileWithRequestedFilesFromGoogleForm;
        outputDir; % output the groups to this directory. 
        
    end
    
    methods
    end
end