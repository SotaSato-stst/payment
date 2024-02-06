gen_proto:
	protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative settlement.proto
docker_build:
	docker build -t merpay-ms-dev/bff:0.1 ./application/bff;\
	docker build -t merpay-ms-dev/settlement:0.1 ./application/settlement;\
	docker build -t merpay-ms-dev/settlement-db:0.1 ./application/settlement-db;\
	docker build -t merpay-ms-dev/balance:0.1 ./application/balance;\
	docker build -t merpay-ms-dev/balance-db:0.1 ./application/balance-db

kind_load_image:
	kind load docker-image  merpay-ms-dev/bff:0.1;\
	kind load docker-image  merpay-ms-dev/settlement:0.1;\
	kind load docker-image  merpay-ms-dev/settlement-db:0.1;\
	kind load docker-image  merpay-ms-dev/balance:0.1;\
	kind load docker-image  merpay-ms-dev/balance-db:0.1
kube_deploy:
	kubectl apply -f ./application/infra/bff/k8s/bff.yaml;\
	kubectl apply -f ./application/infra/settlement/k8s/settlement.yaml;\
	kubectl apply -f ./application/infra/settlement/k8s/settlement-db.yaml;\
	kubectl apply -f ./application/infra/balance/k8s/balance.yaml;\
	kubectl apply -f ./application/infra/balance/k8s/balance-db.yaml;\
	kubectl apply -f ./application/infra/rabbitmq/k8s/rabbitmq.yaml

istio_deploy:
	kubectl apply -f ./application/infra/bff/istio/virtualservice.yaml;\
	kubectl apply -f ./application/infra/common/istio/ingress-gateway.yaml

delete_istio_security:
	kubectl delete -f ./application/infra/common/istio/request-authentication-keycloak.yaml;\
	kubectl delete -f ./application/infra/common/istio/authorization-policy-keycloak.yaml

deploy_istio_security:
	kubectl apply -f ./application/infra/common/istio/request-authentication-keycloak.yaml;\
	kubectl apply -f ./application/infra/common/istio/authorization-policy-keycloak.yaml

delete_all:
	kubectl delete -f ./application/infra/bff/k8s/bff.yaml;\
	kubectl delete -f ./application/infra/settlement/k8s/settlement.yaml;\
	kubectl delete -f ./application/infra/settlement/k8s/settlement-db.yaml;\
	kubectl delete -f ./application/infra/balance/k8s/balance.yaml;\
	kubectl delete -f ./application/infra/balance/k8s/balance-db.yaml;\
	kubectl delete -f ./application/infra/rabbitmq/k8s/rabbitmq.yaml
# TODO: deploy script ref:https://gitlab.com/gihyo-ms-dev-book/handson/sec3/3.4-auth/bookshop-demo/-/tree/main/scripts?ref_type=heads
deploy:
	make docker_build;\
	make kind_load_image;\
	make kube_deploy