function  createOuputFolder(settings)



 b = exist (settings.outputDir);
 if(b==0)
     mkdir(settings.outputDir);
 end