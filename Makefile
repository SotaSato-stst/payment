gen_proto:
	protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative settlement.proto
docker_build:
	docker build -t merpay-ms-dev/bff:0.1 ./application/bff;\
	docker build -t merpay-ms-dev/settlement:0.1 ./application/settlement
kind_load_image:
	kind load docker-image  merpay-ms-dev/bff:0.1;\
	kind load docker-image  merpay-ms-dev/settlement:0.1
kube_deploy:
	kubectl apply -f ./application/infra/settlement/k8s/settlement.yaml;\
	kubectl apply -f ./application/infra/bff/k8s/bff.yaml

deploy:
	make docker_build;\
	make kind_load_image;\
	make kube_deploy