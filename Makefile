
IMAGE?=carloferrigno/osa-python:$(shell git describe --always)
IMAGE_LATEST?=carloferrigno/osa-python:latest
DUSER := $(shell id -u)

push: build
	docker push $(IMAGE) 
	docker push $(IMAGE_LATEST) 

build: Dockerfile
	docker build . -t $(IMAGE) 
	docker build . -t $(IMAGE_LATEST) 

pull:
	docker pull $(IMAGE) 
	docker pull $(IMAGE_LATEST) 

test: build
	docker run -e HOME_OVERRRIDE=/tmp-home -v $(PWD):/tmp-home -it carloferrigno/osa-python:latest bash -c 'source /init.sh; bash $$HOME/self-test.sh'
 
notebook:  build
	docker run -v $(PWD):/home/jovyan -it --entrypoint='' -p 8889:8889 --user $(DUSER)  $(IMAGE) bash -c "source /init.sh;jupyter notebook --ip 0.0.0.0 --no-browser --port=8889"

run: 
	docker run -v $(PWD):/home/jovyan --entrypoint='' -p 8899:8889 --user $(DUSER)  $(IMAGE) bash -c "\
				source /init.sh; \
				papermill --log-output GX5m1.ipynb GX5m1-output.ipynb 2>&1 | awk '{printf "\""notebook log >>> "\""} 1' \
				"

run-one: # in docker:dind
	docker run --entrypoint='' $(IMAGE) bash -c "\
				source /init.sh; \
				papermill --log-output GX5m1.ipynb GX5m1-output.ipynb 2>&1; \
				exit $$? \
				"
