FROM jenkins/jenkins:lts
USER root
RUN set -x \
	&& apt-get update -y \
	&& apt-get install apt-utils -y \
	&& apt-get install apt-transport-https -y \
	&& apt-get install ca-certificates -y \
	&& apt-get install curl -y \
	&& apt-get install gnupg2 -y \
	&& apt-get install software-properties-common -y \
	&& curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
	&& echo "does the fingerprint of next command matches 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88" \
	&& apt-key fingerprint 0EBFCD88 \
	&& add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
	&& apt-get update -y \
	&& apt-get install docker-ce -y \
	&& groupmod -g 900 docker \
	&& usermod -a -G docker jenkins \
	&& rm -rf /var/lib/apt/lists/*
