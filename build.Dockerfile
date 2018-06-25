#Note : in windows command the file path use the '\\' 
FROM msbuild

#set maintainer email
LABEL maintainer="derek.chen@skymirror.com.tw"

#use powershell run command
SHELL [ "powerchell" ]

#copy your solution project
COPY '.\\Project\\' 'C:\\build\\'

#change work dir 
WORKDIR 'C:\\build\\DockerWebApplication45\\'

#run nuget command to restroe used library
RUN ["nuget","restore"]

#run msbuild to build the project , use the version 14.0 (visual studio 2015)
RUN ["msbuild","C:\\build\\DockerWebApplication45\\DockerWebApplication45.sln","/p:DeployOnBuild=true /p:PublishProfile=DebugProfile"]

#use VOLUME binding with publish
VOLUME //c:/build/Publish

# Usage: build image, then create container and copy out the bin directory.
CMD ["powershell"]


