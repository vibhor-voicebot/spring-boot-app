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
1. docker run --name spring-boot-app -d -p 8080:8080 spring-boot-app
1. docker ps -a
1. docker logs spring-boot-app
1. docker rm spring-boot-app

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
