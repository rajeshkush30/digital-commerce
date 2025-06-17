# Simple Java/Maven Example
FROM maven:3.8.5-openjdk-17
COPY . /app
WORKDIR /app
RUN mvn clean install -DskipTests
CMD ["java", "-jar", "target/DIGITAL-COMMERCE-0.0.1-SNAPSHOT.jar"]