# jenkins-docker

[![Build Status](https://travis-ci.org/visibilityspots/dockerfile-jenkins-docker.svg?branch=master)](https://travis-ci.org/visibilityspots/dockerfile-jenkins-docker) [![Anchore Image Overview](https://anchore.io/service/badges/image/bdeaa14096117dfdc2ebb6ba9452dbee8e2e4c9dc0d0147098d3504acd8eb5ba)](https://anchore.io/image/dockerhub/visibilityspots%2Fjenkins-docker%3Alatest)

Have jenkins running as a docker container with the docker client preinstalled.

At one of our clients we setted up a dockerized jenkins master/slave setup. To build the docker images used in the environment we used the [docker-pipeline](https://plugins.jenkins.io/docker-workflow) plugin. Therefore we also needed to install the docker-ce client on the jenkins master.

By using the [jenkins/jenkins:lts](https://hub.docker.com/r/jenkins/jenkins/) image we are using upstream, installing the docker debian repository for the docker-ce package and adding the jenkins user to the docker group which has been statically configued with GID 900.

Nothing more nothing less.

## Run

```
# docker run --rm -ti visibilityspots/jenkins-docker
```

## Configuration

Make sure the docker group on the host running the jenkins container is mapped to GID 900 too.

```
# groupmod -g 900 docker

# service docker restart
or
# systemctl restart docker
```

Mount the docker daemon, expose port 8080, set the timezone to CET and mount a volume for the persistent data:

```
# mkdir /opt/jenkins
# chown 1000: /opt/jenkins
# docker run --name jenkinsmaster --rm -ti -p 8080:8080 -e TZ=CET -v /var/run/docker.sock:/var/run/docker.sock -v /opt/jenkins:/var/jenkins_home visibilityspots/jenkins-docker
```

cfr https://github.com/jenkinsci/docker/blob/master/README.md

## Test

I wrote some tests in a goss.yaml file which can be executed by [dgoss](https://github.com/aelsabbahy/goss/tree/master/extras/dgoss)

```
$ dgoss  run --name jenkinsmaster-test --rm -ti visibilityspots/jenkins-docker
INFO: Starting docker container
INFO: Container ID: 0ca7b874
INFO: Sleeping for 0.2
INFO: Running Tests
Group: docker: exists: matches expectation: [true]
Group: docker: gid: matches expectation: [900]
User: jenkins: exists: matches expectation: [true]
User: jenkins: groups: matches expectation: [["jenkins","docker"]]
Package: file: installed: matches expectation: [true]
Package: docker-ce: installed: matches expectation: [true]
Command: /usr/bin/file /etc/localtime: exit-status: matches expectation: [0]
Command: /usr/bin/file /etc/localtime: stdout: matches expectation: [/etc/localtime: symbolic link to /usr/share/zoneinfo/Etc/UTC]

Total Duration: 0.026s
Count: 8, Failed: 0, Skipped: 0
INFO: Deleting container
```

## License
Distributed under the MIT license
