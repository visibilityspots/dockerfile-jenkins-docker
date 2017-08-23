# jenkins-docker

[![Build Status](https://travis-ci.org/visibilityspots/dockerfile-jenkins-docker.svg?branch=master)](https://travis-ci.org/visibilityspots/dockerfile-jenkins-docker)

Have jenkins running as a docker container with the docker client preinstalled.

At one of our clients we setted up a dockerized jenkins master/slave setup. To build the docker images used in the environment we used the [docker-pipeline](https://plugins.jenkins.io/docker-workflow) plugin. Therefore we also needed to install the docker-ce client on the jenkins master.

By using the [jenkins/jenkins:lts](https://hub.docker.com/r/jenkins/jenkins/) image we are using upstream and only adding the docker debian repository to install the docker-ce package and adding the jenkins user to the create docker group. 

Nothing more nothing less.

## Run

```docker run --name jenkinsmaster --rm -ti visibilityspots/jenkins-docker```

## Configuration

cfr https://github.com/jenkinsci/docker/blob/master/README.md


## Test

I wrote some tests in a goss.yaml file which can be executed by [dgoss](https://github.com/aelsabbahy/goss/tree/master/extras/dgoss)

```
$ dgoss  run --name jenkinsmaster-test --rm -ti visibilityspots/jenkins-docker
INFO: Starting docker container
INFO: Container ID: 99935bae
INFO: Sleeping for 0.2
INFO: Running Tests
User: jenkins: exists: matches expectation: [true]
User: jenkins: groups: matches expectation: [["jenkins","docker"]]
Package: docker-ce: installed: matches expectation: [true]
Command: docker --version: exit-status: matches expectation: [0]


Total Duration: 0.067s
Count: 4, Failed: 0, Skipped: 0
INFO: Deleting container

```

## License
Distributed under the MIT license
