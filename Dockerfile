FROM ubuntu:latest as build

# Atualiza a lista de pacotes e instala o JDK 17
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package
# Copia todo o conteúdo do diretório local para o contêiner
COPY . .

# Instala o Maven e compila o projeto com Maven
RUN apt-get install -y maven && \
    mvn clean install

# Segunda stage do Dockerfile
FROM openjdk:17-jdk-slim
WORKDIR /app

# Expõe a porta 8080 (necessário apenas para documentação, não abre a porta)
EXPOSE 8080

# Copia o arquivo JAR construído na stage anterior para a imagem atual
COPY --from=build /target/deploy_render-1.0.0.jar app.jar

# Comando a ser executado ao iniciar o contêiner
ENTRYPOINT ["java", "-jar", "app.jar"]