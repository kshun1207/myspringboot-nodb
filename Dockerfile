FROM openjdk:21-jdk-slim
COPY build/libs/demo-0.0.1-SNAPSHOT.war app.jar
ENTRYPOINT ["java","-jar","/app.jar"]