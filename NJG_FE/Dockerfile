# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-oracle

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container at /app
COPY target/security-0.0.1-SNAPSHOT.war /app

# Specify the command to run on container start
CMD ["java", "-jar", "security-0.0.1-SNAPSHOT.war"]

