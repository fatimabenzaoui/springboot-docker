FROM openjdk:17-jdk-slim

# Copier le jar de l'application dans le conteneur
COPY target/shop-0.0.1-SNAPSHOT.jar /shop.jar

# Commande pour exécuter l'application Spring Boot lorsque le conteneur démarre
CMD ["java", "-jar", "/shop.jar"]