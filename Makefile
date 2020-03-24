LOCAL=wascc-gantry:0.0.3-amazonlinux2018.03.0.20191219.0
REMOTE=ewbankkit/wascc-gantry-amazonlinux:0.0.3-2018.03.0.20191219.0

.PHONY: all clean clone image push

all: push

clean:
	rm -fr gantry/
	rm -fr nats-provider/
	rm -fr redis-provider/
	rm -fr s3-provider/

clone:
	git clone https://github.com/wascc/gantry.git
	git clone https://github.com/wascc/nats-provider.git
	git clone https://github.com/wascc/redis-provider.git
	git clone https://github.com/wascc/s3-provider.git

image: clone
	docker build --file Dockerfile --tag ${LOCAL} .
	docker tag ${LOCAL} ${REMOTE}

# Don't forget to docker login.
push: image
	docker push ${REMOTE}
