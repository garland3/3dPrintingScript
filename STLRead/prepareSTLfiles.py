import os
import shutil
import stat
import subprocess


# specifiy the folder that contains the unzipped folders
#* loop over the folder
#* rename each .stl file with username_part1, username_part2, username_part3 , ...
#* Put into groups of 8 bottles and put each group in a folder
#* Rendering of each .stl file with file name and username output to a .pdf

folderWithStudentFolders = 'E:\Fall2015\P1\Unzipped'

#folders = os.listdir(folderWithStudentFolders)
#print folders



for root, dirs, files in os.walk(folderWithStudentFolders):
	
	for d in dirs:
		print d


