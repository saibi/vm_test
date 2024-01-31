docker build -t saibi/nanoimg .

docker run -d --name nano -p 8080:80 saibi/nanoimg
