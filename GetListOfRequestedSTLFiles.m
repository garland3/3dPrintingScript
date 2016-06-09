function newlistOfStlFiles = GetListOfRequestedSTLFiles(settings,listOfSTLFiles)
% read the .csv file
% find the usersnames filees
% if cann't find, then put the information into a .csv file indicating that
% the usernames files could not be found. 

%file = 'C:\Users\garla\Desktop\ENGR 2080 Bottle Request form.csv'
[num,txt,raw] = xlsread(  settings.csvFileWithRequestedFilesFromGoogleForm);

numOrginalStlFiles =length(listOfSTLFiles);

index = 1;
unfoundIndex =1;

for i = 1:length(raw)
     row = raw(i,:); % get the row based off the index.
     username = lower(char(row(3)));
     found = 0;    
     
     
     for j = 1:numOrginalStlFiles         
         local_stlFile = listOfSTLFiles(j);
         if(strcmp(username, local_stlFile.username))
             found = found+1;
             newlistOfStlFiles(index) = local_stlFile;
             index = index+1;            
         end
     end
     
     % needs to find 2 files. 
     if(found<2 || found>2)
         listOfUnfoundUsernames(unfoundIndex,:) = {username,' # files found ' ,int2str( found)};
         unfoundIndex=unfoundIndex+1;
     end
        
end

unfoundFilesCSVName = fullfile(settings.outputDir,'unfoundFilesList.csv');
cell2csv(unfoundFilesCSVName,listOfUnfoundUsernames,',')

end