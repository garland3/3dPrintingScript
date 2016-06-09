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
settings.targetDir = 'F:\ENGR2080\P1'; % target Folder
settings.outputDir = 'F:\ENGR2080\_P1groups_v2'
settings.numberOfFilesPerGroup = 18;
settings.foldercount = 1; % folder numbering starts at this value. (should be 1 for most applications)
settings.makeImages = 0; % Set to 1 to make the 4 vies of each .stl file. 
settings.doRenameFiles = 0; % Set to 1 for normal use, set to 0 while developing code
settings.doCopyFilesToNewLocation = 0; % Set to 1 for normal use. 0 while developing. 
settings.makeNewdirectories = 0; % set to 1 for normal use, 0 while developing. 
settings.csvFileWithUsernamesAndSections = 'C:\Users\garla\Box Sync\Clemson\ENGR2080_nonshare\Spring2015\Roll\allSectionUserNameSectionNumber.csv';
settings.semester = 'summer';
settings.csvFileWithRequestedFilesFromGoogleForm = 'C:\Users\garla\Downloads\ENGR 2080 Bottle Request form.csv';
% Run the main program

createOuputFolder(settings);

list_of_stl_files = ListOfStlFiles(settings); % get a list of stl files

if(strcmp(settings.semester,'summer'))
   list_of_stl_files = GetListOfRequestedSTLFiles(settings,list_of_stl_files);
end

list_of_stl_files_sorted = SortFilesBySection(settings, list_of_stl_files);
ExportStlFilesInFolderGroupsWithImages(settings,list_of_stl_files_sorted)








