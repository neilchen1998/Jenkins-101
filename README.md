# Jenkins

## Build Docker Image For Jenkins

Build the custom Jenkins iamge

```sh
$ docker build -t myjenkins:bookworm-jdk21 .
```

Get the image ID

```sh
$ docker images
```

Tag the image

```sh
docker tag <image_id> <username>/myjenkins:<tag>
```

Push the image to [Docker Hub](https://hub.docker.com/)

```sh
docker push <username>/myjenkins:<tag>
```

## Create Jenkins Network

Create Jenkins network if it is not present (skip this step if it is present)

``` sh
docker network create jenkins
```

## Start Jenkins Container

Start the container

```sh
docker run --name jenkins-blueocean \
    --restart=on-failure \
    --detach \
    --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
    --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
    --publish 8080:8080 --publish 50000:50000 \
    --volume jenkins-data:/var/jenkins_home \
    --volume jenkins-docker-certs:/certs/client:ro \
    myjenkins:bookworm-jdk21
```

## Setup Jenkins GUI

Generate the admin password

```sh
docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword
```

Go to the [port](http://localhost:8080/) and setup the password with the password from the previous step.
NOTE: the port specified in Step 3 is 8080, please change it accordingly.

Run Alpine Socat

```sh
docker run -d --restart=always -p 127.0.0.1:2376:2375 --network jenkins \
    -v /var/run/docker.sock:/var/run/docker.sock alpine/socat:1.8.0.3 tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock
```

Grab the IP of Alpine Socat by inspecting the docker image. Find the value in the **IPAddress** section.

```sh
docker inspect <alpine_socat_id>
```

Create the first admin account.

In the **Cloud My-Cloud Configuration -> Docker Agent Template -> Docker Image**, enter `<username>/myjenkins`.
So that Jenkins can grab the docker image correctly.



## Troubleshoot

### If the initial admin password cannot be retreived

1. Stop the container

```sh
docker stop jenkins-blueocean
```

2. Remove the container

```sh
docker rm jenkins-blueocean
```

3. Remove the volume

```sh
docker volume rm jenkins-data
```

4. Rerun the command
