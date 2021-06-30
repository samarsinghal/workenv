build:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker build --rm -f build-tanzu-workshop-setup.dockerfile -t samarsinghal/workenv:$$TAG .; \
	docker tag samarsinghal/workenv:$$TAG samarsinghal/workenv:latest

clean:
	docker stop workenv
	docker rm workenv

rebuild: clean build

#ADD this back in with project examples are ready -v $$PWD/deploy:/deploy 
run:
	docker run --name workenv -v $$PWD/config/kube.conf:/root/.kube/config -v $$PWD/ytt:/ytt -td samarsinghal/workenv:latest
	docker exec -it workenv bash -l

join:
	docker exec -it workenv bash -l
start:
	docker start workenv
stop:
	docker stop workenv

default: build
