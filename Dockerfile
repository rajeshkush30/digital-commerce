# Simple Java/Maven Example
FROM maven:3.8.5-openjdk-17
COPY . /app
WORKDIR /app
RUN mvn clean install
CMD ["java", "-jar", "target/your-app.jar"]
