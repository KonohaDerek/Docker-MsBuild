# Docker-MsBuild

 #建立 建置環境
docker build -f .\msbuild.Dockerfile -t msbuild .

#建置 WEB API 並 Deploy
docker build -f .\build.Dockerfile -t main.app.api .

#建立可執行 Web & 執行Container
docker build -f .\iis.Dockerfile -t webmain .
docker-compose up -d

#查詢容器IP
docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}" 'CONTAINER ID'

#Windows Docker Issue
Windows does not support host IP addresses in NAT settings
