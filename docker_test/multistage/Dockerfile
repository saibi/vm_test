# build
FROM openjdk:8 AS BUILD_IMAGE
RUN apt-get update && apt-get install maven -y
RUN git clone -b vp-docker https://github.com/imranvisualpath/vprofile-repo.git 
RUN cd vprofile-repo && mvn install 

# app
FROM tomcat:8-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-repo/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME /usr/local/tomcat/webapps
