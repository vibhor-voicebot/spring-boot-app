# spring-boot-app

## Docker build strategy

### Get source code

1. clone the spring-boot-app example repository,

    ```
    git clone https://github.com/remkohdev/spring-boot-app.git
    cd spring-boot-app
    ```

### Test Maven

1. Test maven build

    ```
    mvn clean install
    ```

### test Docker

1. docker build -t spring-boot-app .
2. docker tag spring-boot-app quay.io/remkohdev/spring-boot-app
3. docker login quay.io -u remkohdev@gmail.com
4. docker push quay.io/remkohdev/spring-boot-app
5. Go to quay.io > repositories > spring-boot-app > Settings > Repository Visibility > make repository public
6. docker run --name spring-boot-app -d -p 8080:8080 quay.io/remkohdev/spring-boot-app
7. curl -X GET "http://localhost:8080/api/hello?name=Kumar"
8. docker ps -a
9. docker logs spring-boot-app
10. docker rm spring-boot-app

### Deploy to OpenShift

1. oc login to your openshift cluster,

    ```
    oc login --token=abc --server=https://c321d.us-east.containers.cloud.ibm.com:31333
    ```

1. oc new-project oc-docker-build
1. oc new-app . --strategy=docker

    ```
    oc get bc
    oc get builds
    oc get dc
    ```

1. oc expose svc spring-boot-app
1. ROUTE=$(oc get routes -o json | jq -r '.items[0].spec.host')
1. curl "http://$ROUTE/api/hello?name=Tao"
1. oc delete

    ```
    oc delete project oc-docker-build
    ```

## Set Build Environment

oc new-app . --build-env strategy.dockerStrategy.dockerfilePath=./Dockerfile1 --strategy=docker

## Multi-stage Builds

When you start containerizing an application, it is common to start with one Dockerfile for building images and running containers. It is common to have one Dockerfile for development, and a minimal image for production. This has been referred to as the `builder pattern`, but maintaining two Dockerfiles is not ideal.

In `multi-stage builds`, you use multiple `FROM` statements in your Dockerfile. Each `FROM` statement begins a new stage of the build. You can selectively copy artifacts from one stage to another.

Compare `Dockerfile2` to `Dockerfile`.