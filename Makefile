## run: starts http services or run them manually
.PHONY: run-containers
run-containers:
	docker run --rm -d -p 8080:80 --name server1 myAppImage1
	docker run --rm -d -p 8081:80 --name server2 myAppImage2
	docker run --rm -d -p 8082:80 --name server3 myAppImage3

## stop: stops all demo services
.PHONY: stop
stop:
	docker stop server1
	docker stop server2
	docker stop server3

## run: starts demo http services
.PHONY: run-proxy-server
run-proxy-server:
	go run cmd/main.go