FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/apigateway-1.0-SNAPSHOT.jar app.jar

EXPOSE 8068

ENTRYPOINT ["java", "-jar", "app.jar"]