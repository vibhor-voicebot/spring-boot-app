ARG JAR_FILE=target/*.jar

FROM registry.access.redhat.com/ubi8/openjdk-11
COPY . .
RUN mvn clean install -DskipTests

FROM registry.access.redhat.com/ubi8/openjdk-11
COPY --from=0 /home/jboss/target/*.jar /home/jboss/app.jar
ENTRYPOINT ["java","-jar","app.jar"]