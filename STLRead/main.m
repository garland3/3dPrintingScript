% Assume that all the student's work is in a folder with their user name. 
% So if Anthony Garland and John Minor have submitted files, then the dir
% tree looks like
% .
% ..
% apg/
% jminor/
% Within each student's folder, there should be some .stl files. 
% Find these .stl files, and put into a list. 


function main
clear
close all
clc
% ---------------------
% Settings
% --------------------
settings = Configuration; % generate a configuraation object. 
settings.targetDir = 'E:\ENGR2080\P1_test'; % target Folder
settings.numberOfFilesPerGroup = 20;
settings.foldercount = 1; % folder numbering starts at this value. (should be 1 for most applications)
settings.makeImages = 0; % Set to 1 to make the 4 vies of each .stl file. 
settings.doRenameFiles = 0; % Set to 1 for normal use, set to 0 while developing code
settings.doCopyFilesToNewLocation = 0; % Set to 1 for normal use. 0 while developing. 
settings.makeNewdirectories = 0; % set to 1 for normal use, 0 while developing. 
settings.csvFileWithUsernamesAndSections = 'C:\Users\Anthony G\Box Sync\Clemson\ENGR2080_nonshare\Spring2015\Roll\allSectionUserNameSectionNumber.csv';

% Run the main program
list_of_stl_files = ListOfStlFiles(settings); % get a list of stl files
list_of_stl_files = SortFilesBySection(settings, list_of_stl_files);
ExportStlFilesInFolderGroupsWithImages(settings,list_of_stl_files)



end



