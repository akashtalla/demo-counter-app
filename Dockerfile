FROM openjdk:17.0
WORKDIR /app
COPY /target/springboot-1.0.0.jar /app/springboot-1.0.0.jar
EXPOSE 9090
CMD [ "java","-jar","springboot-1.0.0.jar" ]
