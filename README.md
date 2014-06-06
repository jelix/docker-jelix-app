
Docker environnement to develop a PHP application with Jelix. Based on Ubuntu.

 * THIS IS EXPERIMENTAL. WORK IN PROGRESS*


## Usage

### Install

```
git clone https://github.com/Jelix/docker-app-base.git
docker build -t jelix/app-base .
```


### Run


Create your own docker file: copy the directory example/myapp/docker in your jelix
application. Change things in it.


The build your app image:

```
cd yourapp/docker
./build-image.sh vendor/myapp
```

You have a example/myapp/docker/launch.sh script. You can modify it to add your own
docker options to launch the image.

```
./launch.sh vendor/myapp
```

## Services

- ssh
- apache
- mysql
- php5 mod & cli
