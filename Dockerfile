FROM openjdk:17.0

WORKDIR /app

COPY /app/target/Uber.jar /app/

EXPOSE 9090

CMD [ "java","-jar","Uber.jar" ]
