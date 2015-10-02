import os
import shutil
import stat
import subprocess

# http://stackoverflow.com/questions/6657005/matlab-running-an-m-file-from-command-line

pathToMatlab = 'C:\Program Files\MATLAB\R2015a\bin\matlab.exe'
pathToCode = 'C:\Users\Anthony G\Git\3dPrintScript\STLRead\FourViews.m'



cmd = '-nodisplay -nosplash -nodesktop -r "run(\' %s \');exit;" ', pathToCode
print cmd
subprocess.call([pathToMatlab,cmd])


#C:\Users\Anthony G\Git\3dPrintScript\STLRead>"C:\Program Files\MATLAB\R2015a\bin\matlab.exe" -nodisplay -nosplash -nodesktop -r "run('C:\Users\Anthony G\Git\3dPrintScript\STLRead\FourViews.m');exit;"