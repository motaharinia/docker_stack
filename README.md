# docker_stack
docker stack with a demo application


## Prepare a local docker registry if you want to work without company docker registry
```console
docker run -d -p 5000:5000 --name local-registry registry:2
```


## Prepare back-end docker image:
### Build back-end (jar) application (cleanBuild will clean and run tests and build. bootJar specific task added by Spring Boot Gradle plugin)
You want to use bootJar if you're only interested in building the executable jar and not interested in executing tests, code coverage, static code analysis or whatever is attached to the check lifecycle task.
```console
cd ./demo
gradlew cleanBuild
gradlew bootJar
```
### Build docker image and push it to the personal/company registry (you can replace localhost:5000 with your company docker registry)
```console
cd ./demo
docker build --build-arg JAR_FILE=build/libs/*.jar -t localhost:5000/demo:latest .
docker push localhost:5000/demo:latest
```


## Prepare front-end docker image:
### Build front-end application
```console
cd ./demo_frontend
npm run build
```
### Build docker image and push it to the personal/company registry (you can replace localhost:5000 with your company docker registry)
```console
cd ./demo_frontend
docker build -t localhost:5000/demo_frontend:latest .
docker push localhost:5000/demo_frontend:latest
```


## Run stack and check endpoints
### Run stack
```console
cd ./stack
docker compose up
```
### Check the Kafka topics
```console
http://localhost:9080
```
### Check the back-end service endpoint on your browser
```console
http://localhost:8080
```
### Check the front-end service endpoint on your browser
```console
http://localhost:3000
```