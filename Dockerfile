FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY . .
RUN mvn clean install

FROM eclipse-temurin:21-jre
WORKDIR /app
EXPOSE 8083
COPY --from=builder /app/target/*.jar controle-requisicoes.jar
ENTRYPOINT ["java", "-jar", "controle-requisicoes.jar"]