make dist #binary will be generated
docker buildx build . --output type=docker,name=elestio4test/listmonk:latest | docker load