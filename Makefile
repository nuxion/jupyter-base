
.EXPORT_ALL_VARIABLES:
VERSION := $(shell git describe --tags)
BUILD := $(shell git rev-parse --short HEAD)
PROJECTNAME := $(shell basename "$(PWD)")

LDFLAGS=-ldflags "-X=main.Version=$(VERSION) -X=main.Build=$(BUILD)"
STDERR := /tmp/.$(PROJECTNAME)-stderr.txt
DOCKER_REGISTRY :="registry.int.deskcrash.com:5000"

.PHONY: cert
cert: 
	openssl req -x509 -newkey rsa:4096 -keyout certs/server-key.pem -out certs/server-cert.pem -days 365 -nodes -subj '/CN=localhost'

.PHONY: tar
tar:
	tar cvf releases/jupyter_$(VERSION)-$(BUILD).tar src/jupyter_notebook_config.py requirements.txt notebooks/ src/postBuild

.PHONY: copy
copy:
	cp releases/jupyter_$(VERSION)-$(BUILD).tar jupyter.tar

.PHONY: clean
clean:
	rm jupyter.tar

.PHONY: build
build:
	docker build -t nuxion/jupyterlab .
	docker tag nuxion/jupyterlab:latest nuxion/jupyterlab:$(VERSION)

.PHONY: publish
publish:
	docker tag nuxion/jupyterlab $(DOCKER_REGISTRY)/nuxion/jupyterlab
	docker tag nuxion/jupyterlab:$(VERSION) $(DOCKER_REGISTRY)/nuxion/jupyterlab:$(VERSION)
	docker push $(DOCKER_REGISTRY)/nuxion/jupyterlab:$(VERSION)
	docker push $(DOCKER_REGISTRY)/nuxion/jupyterlab:latest

.PHONY: release
release: tar copy build publish clean


