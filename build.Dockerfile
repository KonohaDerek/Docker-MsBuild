#Note : in windows command the file path use the '\\' 
FROM msbuild

#set maintainer email
LABEL maintainer="derek.chen@skymirror.com.tw"

#use powershell run command
SHELL [ "powerchell" ]

#copy your solution project
COPY '.\\projects\\' 'C:\\build\\'

#change work dir 
WORKDIR 'C:\\build\\Common\\'

#run nuget command to restroe used library
RUN ["C:\\TEMP\\nuget.exe","restore"]

#run msbuild to build the project , use the version 14.0 (visual studio 2015)
RUN ["C:\\Program Files (x86)\\MSBuild\\14.0\\Bin\\MSBuild.exe","C:\\build\\Common\\Common.sln"]

#change work dir 
WORKDIR 'C:\\build\\MainApp.Api\\'

#run nuget command to restroe used library
RUN ["C:\\TEMP\\nuget.exe","restore"]

#run msbuild to build the project , use the version 14.0 (visual studio 2015)
#RUN ["C:\\Program Files (x86)\\MSBuild\\14.0\\Bin\\MSBuild.exe","C:\\build\\MainApp.Api\\MainApp.Api.sln","/p:OutDir=C:\\publish /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True"]
RUN ["C:\\Program Files (x86)\\MSBuild\\14.0\\Bin\\MSBuild.exe","C:\\build\\MainApp.Api\\MainApp.Api.sln"]

#use VOLUME binding with publish
#VOLUME c:\publish

# Usage: build image, then create container and copy out the bin directory.
CMD ["powershell"]
