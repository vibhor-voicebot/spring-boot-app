FROM registry.access.redhat.com/ubi8/openjdk-11

ARG MAVEN_VERSION=3.6.3
ARG JAR_FILE=target/*.jar

# curl -O needs write permissions
USER root

# cd WORKDIR/build
WORKDIR $HOME/build

RUN curl -O https://apache.osuosl.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
    tar xzvf apache-maven-3.6.3-bin.tar.gz && \
    rm apache-maven-3.6.3-bin.tar.gz
ENV PATH="./apache-maven-3.6.3/bin:$PATH"

COPY . .
RUN mvn clean install -DskipTests
RUN mv ${JAR_FILE} $HOME/app.jar

# cd $HOME
WORKDIR $HOME

# clean and rm WORKDIR/build
RUN rm -rf build &&\
    rm -rf .m2
RUN ls -al

# switch back to nonroot user
USER 1001

ENTRYPOINT ["java","-jar","app.jar"]s