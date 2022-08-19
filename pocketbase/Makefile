IMAGE=ssmiller25/pocketbase
IMAGEVERSION=0.0.1

.PHONY: build
build:
	docker build -t $(IMAGE):$(IMAGEVERSION) .

.PHONY: run
run:
	docker run -it --rm -p 8090:8090 $(IMAGE):$(IMAGEVERSION)

.PHONY: push
push:
	docker tag $(IMAGE):$(IMAGEVERSION) $(IMAGE):latest
	docker push $(IMAGE):$(IMAGEVERSION)
	docker push $(IMAGE):latest