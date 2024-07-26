# Stage 1: Build the application
FROM maven:3.8.6-openjdk-11-slim AS build
WORKDIR /app

# Copy the pom.xml and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code and build the application
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Run the application
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the Spring Boot JAR file from the previous stage
COPY --from=build /app/target/demo-1.0.2.jar ./app.jar

# Expose the application port
EXPOSE 8090

# Set the environment variables for MySQL
ENV SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/springbootdb
ENV SPRING_DATASOURCE_USERNAME=opstree
ENV SPRING_DATASOURCE_PASSWORD=Opstree@123

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

