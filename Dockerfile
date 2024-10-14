# Stage 1: Build the project
FROM ubuntu:latest AS build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
RUN apt-get install maven -y

# Copy the entire project into the container
COPY . .

# Build the Spring Boot application with Maven
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk-slim
EXPOSE 8080

# Copy the jar file from the build stage to the run stage
COPY --from=build /target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
