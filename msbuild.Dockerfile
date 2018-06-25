FROM microsoft/windowsservercore:10.0.14393.206

#maontainer email
LABEL maintainer="derek.chen@skymirror.com.tw"

#use powershell run command

SHELL [ "powershell" ]

# Note : Get MSBuild 15.0
COPY '.\\Tools\\' 'C:\\TEMP\\'

COPY '.\\Tools\\nuget.exe' 'C:\\windows\\nuget.exe'

# Note: Add .NET + ASP.NET runtime
RUN Install-WindowsFeature NET-Framework-45-Core
RUN Install-WindowsFeature NET-Framework-45-ASPNET
RUN Install-WindowsFeature Web-Asp-Net45

# Note: Add .NET 4.5 SDK (Windows 8)
#RUN "C:\\TEMP\\dotNetFx45_Full_setup.exe" '/q /norestart' -NoNewWindow -Wait
# RUN Start-Process "C:\\TEMP\\dotnet45sdksetup.exe" '/features + /q' -NoNewWindow -Wait
# RUN Remove-Item "C:\\TEMP\\dotnet45sdksetup.exe"

# # Note: Add .NET 4.6.2 SDK (Windows 10)
# RUN Start-Process "C:\\TEMP\\dotNetFx462_setup.exe" '/features + /q' -NoNewWindow -Wait
# RUN Remove-Item "C:\\TEMP\\dotNetFx462_setup.exe"

RUN Start-Process -FilePath ' C:\TEMP\vs_buildtools.exe' -ArgumentList \
  '--quiet', '--norestart', '--locale en-US','--add Microsoft.VisualStudio.Workload.WebBuildTools','--add Microsoft.Net.Component.4.5.TargetingPack' -Wait ; \
  Remove-Item -Force -Recurse 'C:\Program Files (x86)\Microsoft Visual Studio\Installer'

# Note : Add Microsoft Web Deploy
RUN msiexec /i "C:\\TEMP\\WebDeploy_amd64_en-US.msi" /quiet /qn /norestart

# # Note: Change WORKDIR
#WORKDIR "C:\\Program Files (x86)\\MSBuild\\Microsoft\\VisualStudio\\v14.0"

# # Note: Install Web Targets
# RUN &  "nuget.exe" Install MSBuild.Microsoft.VisualStudio.Web.targets -Version 14.0.0.3
# RUN mv 'C:\\Program Files (x86)\\MSBuild\\Microsoft\\VisualStudio\\v14.0\\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\\tools\\VSToolsPath\\*' 'C:\\Program Files (x86)\\MSBuild\\Microsoft\\VisualStudio\\v14.0\\'

# # Note: Add Msbuild to path
# RUN setx PATH '%PATH%;C:\\Program Files (x86)\\MSBuild\\14.0\\Bin\\msbuild.exe'
# CMD ["C:\\Program Files (x86)\\MSBuild\\14.0\\Bin\\msbuild.exe"]

RUN setx /M PATH $($Env:PATH + ';' + ${Env:ProgramFiles(x86)} + '\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin')

# Default to PowerShell if no other command specified.
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
