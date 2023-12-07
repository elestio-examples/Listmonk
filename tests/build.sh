cd /listmonk
export GO111MODULE=on
GOBIN=$(pwd)/bin
export GOBIN
go build -o bin/listmonk ./cmd/listmonk
cd /../
cd listmonk && make dist #binary will be generated
docker buildx build . --output type=docker,name=elestio4test/listmonk:latest | docker load