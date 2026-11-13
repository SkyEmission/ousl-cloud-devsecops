FROM maven:3.9.9-eclipse-temurin-17-alpine AS builder
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests -B

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

RUN apk update && apk upgrade --no-cache && rm -rf /var/cache/apk/*
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /build/target/cloud-lab-api.jar /app/app.jar
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]