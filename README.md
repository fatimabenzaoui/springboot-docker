# Générer un projet Springboot
Project : Maven
Language : Java
Spring Boot : 3.2.5
Group : com.fb
Artifact : shop
Name : shop
Description : test springboot with docker
Package Name : com.fb.shop
Packaging : Jar
Java : 17
Dependencies : Spring Web

# Générer le .jar de l'application dans le dossier target
.\mvnw.cmd package

NB : Le jdk 21 et le jdk 22 ne sont pas supportés -> Utiliser le jdk 17

# Créer un fichier Dockerfile à la racine du projet
# Ce fichier spécifie comment Docker doit construire votre image
FROM openjdk:17-jdk-slim
# Copier le jar de l'application dans le conteneur
COPY target/shop-0.0.1-SNAPSHOT.jar /shop.jar
# Commande pour exécuter l'application Spring Boot lorsque le conteneur démarre
CMD ["java", "-jar", "/shop.jar"]

# Construire l'image Docker (Lancer Docker au préalable)
docker build -t my-jdk-17 .

# Une fois que l'image Docker est construite, exécuter un conteneur à partir de cette image
docker run -p 8080:8080 my-jdk-17

# Créer un fichier docker-compose.yml à la racine du projet
version: '3.8'<br>
services:<br>
  app:<br>
    image: my-jdk-17<br>
    build:<br>
      context: .<br>
      dockerfile: Dockerfile<br>
    ports:<br>
      - "8000:8080"<br>
    depends_on:<br>
      - db<br>
    environment:<br>
      SPRING_DATASOURCE_URL: jdbc:mysql://db:3306/shopdb<br>
      SPRING_DATASOURCE_USERNAME: root<br>
      SPRING_DATASOURCE_PASSWORD: root<br>
      SPRING_JPA_HIBERNATE_DDL_AUTO: update<br>
  db:<br>
    image: mysql:8.0<br>
    environment:<br>
      MYSQL_ROOT_PASSWORD: root<br>
      MYSQL_DATABASE: shopdb<br>
    ports:<br>
      - "3306:3306"<br>
    volumes:<br>
      - db_data:/var/lib/mysql<br>
volumes:<br>
  db_data:<br>

# Renseigner le fichier application.properties
# DATASOURCE MYSQL
spring.datasource.url=jdbc:mysql://db:3306/shopdb?createDatabaseIfNotExist=true
spring.datasource.username=root
spring.datasource.password=root
# JPA - HIBERNATE (create, create-drop, validate, update) - MYSQL
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format-sql=true

# Construire et lancer les conteneurs
docker-compose up --build

# Vérifier que les conteneurs sont en cours d'exécution
docker-compose ps
