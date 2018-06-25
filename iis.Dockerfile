#use microsoft/aspnet:4.7.1-windowsservercore-1709
FROM microsoft/aspnet:4.7.1-windowsservercore-1709

#set maintainer email
LABEL maintainer="derek.chen@skymirror.com.tw"

#change workdir
WORKDIR /inetpub/wwwroot

#use VOLUME binding with wwwroot
VOLUME C:\inetpub\wwwroot

# Open 80 Port
EXPOSE 80
