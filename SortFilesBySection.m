function newListOfStlFiles = SortFilesBySection(settings, listOfStlFiles)

% read .csv files that have username and section number
% assign the .stl file object a section number
% sort by section number.



% Step 1
% http://www.mathworks.com/matlabcentral/answers/218762-matlab-failing-to-import-data
% [pathstr,name,ext] = fileparts(settings.csvFileWithUsernamesAndSections)
[num,txt,raw] = xlsread(  settings.csvFileWithUsernamesAndSections);

raw_usernames=lower(raw(:,3)); % for some reason some usernames are uppercase
indexArray =[]; % has two columns, [sectionNumber, index]

% Step 2, assign first and last name and section number to each stlFile
% object
for count = 1:length(listOfStlFiles)
    u =  listOfStlFiles(count).username; % ge the username for this .stl file
    index = find(ismember(raw_usernames, u)); % find the index of the row with the corresponding username.
    row = raw(index,:) % get the row based off the index.
    
    % if NOT empty, then proceed, if empty then skip
    if(isempty(row) ==0)    
        % update the list element directly
        listOfStlFiles(count).LastName=char(row(1));
        listOfStlFiles(count).FirstName=char(row(2));
        %listOfStlFiles(count).sectionNumber=int32(cell2mat(row(4)));
        listOfStlFiles(count).sectionNumber=str2double(row{1,4});

        indexArray = [indexArray; listOfStlFiles(count).sectionNumber count];
    else
        message = strcat('skipped: ', u)
    end
end


% step 3


% sort by the first column 'section number'
indexArray = sortrows(indexArray); 

% make a new list of stlFile objects that are sorted by section number. 
for count = 1:length(indexArray)
    indexInListOfSTLFiles =int32( indexArray(count,2));
    obj =  listOfStlFiles(indexInListOfSTLFiles);
    newListOfStlFiles(count) = obj;
end



% Check to make sure it works. Can comment out latter. 
for count = 1:length(newListOfStlFiles)
    u =  newListOfStlFiles(count).username; % ge the username for this .stl file
     s =  newListOfStlFiles(count).sectionNumber; % ge the username for this .stl file
   % index = find(ismember(raw(:,3), u)); % find the index of the row with the corresponding username.
   % row = raw(index,:) % get the row based off the index.
   r = [u ' ' int2str(s) ' ' int2str(count)]
    
end

t= '1';



