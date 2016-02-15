function listOfStlFiles = SortFilesBySection(settings, listOfStlFiles)

% read .csv files that have username and section number
% assign the .stl file object a section number
% sort by section number.



% Step 1
% http://www.mathworks.com/matlabcentral/answers/218762-matlab-failing-to-import-data
% [pathstr,name,ext] = fileparts(settings.csvFileWithUsernamesAndSections)
[num,txt,raw] = xlsread(  settings.csvFileWithUsernamesAndSections)


indexArray =[]; % has two columns, [sectionNumber, index]

% Step 2
for count = 1:length(listOfStlFiles)
    u =  listOfStlFiles(count).username; % ge the username for this .stl file
    index = find(ismember(raw(:,3), u)); % find the index of the row with the corresponding username.
    row = raw(index,:); % get the row based off the index.
    
    % update the list element directly
    listOfStlFiles(count).LastName=char(row(1));
    listOfStlFiles(count).FirstName=char(row(2));
    listOfStlFiles(count).sectionNumber=cell2mat(row(4));
    
    indexArray = [indexArray; listOfStlFiles(count).sectionNumber count];
end


% step 3

indexArray = sortrows(indexArray); % sort by the first column 'section number'
for count = 1:length(listOfStlFiles)
    index =int8( indexArray(count,2));
    obj =  listOfStlFiles(index);
    newListOfStlFiles(count) = obj;
end



% Check to make sure it works. Can comment out latter. 
for count = 1:length(newListOfStlFiles)
    u =  newListOfStlFiles(count).username; % ge the username for this .stl file
    index = find(ismember(raw(:,3), u)); % find the index of the row with the corresponding username.
    row = raw(index,:) % get the row based off the index.
    
end



