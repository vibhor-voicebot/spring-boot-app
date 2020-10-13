# spring-boot-app

## Docker build strategy

1. clone the spring-boot-app example repository,

    ```
    git clone https://github.com/remkohdev/spring-boot-app.git
    cd spring-boot-app
    ```

2. Test maven build

    ```
    mvn clean install
    ```

3. docker build -t spring-boot-app .
4. docker run --name spring-boot-app -d -p 8080:8080 spring-boot-app
5. docker ps -a
6. docker logs spring-boot-app
7. docker rm spring-boot-app
8. oc login to your openshift cluster,

    ```
    oc login --token=abc --server=https://c321d.us-east.containers.cloud.ibm.com:31333
    ```

9.  oc new-project oc-docker-build
10. oc new-app . --strategy=docker

    ```
    oc get bc
    oc get builds
    oc get dc
    ```

11. oc expose svc spring-boot-app
12. ROUTE=$(oc get routes -o json | jq -r '.items[0].spec.host')
13. curl "http://$ROUTE/api/hello?name=Tao"
14. oc delete

    ```
    oc delete project oc-docker-build
    ```
