# spring-boot-app

## Docker build strategy

### Get source code

1. clone the spring-boot-app example repository,

    ```
    git clone https://github.com/vibhor-voicebot/spring-boot-app.git
    cd spring-boot-app
    ```

### Test Maven

1. Test maven build

    ```
    mvn clean install
    ```
### Deploy to OpenShift

1. oc login to openshift cluster,

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
1. curl "http://$ROUTE/api/hello?name=Vibhor"
1. oc delete

    ```
    oc delete project oc-docker-build
    ```

## Set Build Environment

oc new-app . --build-env strategy.dockerStrategy.dockerfilePath=./Dockerfile1 --strategy=docker

