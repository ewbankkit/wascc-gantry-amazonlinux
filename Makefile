LOCAL=wascc-gantry:0.0.3-amazonlinux2018.03.0.20191219.0
REMOTE=ewbankkit/wascc-gantry-amazonlinux:0.0.3-2018.03.0.20191219.0

.PHONY: all image push

all: push

image:
	git clone https://github.com/wascc/gantry.git
	docker build --file Dockerfile --tag ${LOCAL} .
	docker tag ${LOCAL} ${REMOTE}

# Don't forget to docker login.
push: image
	docker push ${REMOTE}
