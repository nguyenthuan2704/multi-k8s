docker build -t nguyenthuan2704/multi-client:latest -t nguyenthuan2704/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nguyenthuan2704/multi-server:latest -t nguyenthuan2704/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nguyenthuan2704/multi-worker:latest -t nguyenthuan2704/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nguyenthuan2704/multi-client:latest
docker push nguyenthuan2704/multi-server:latest
docker push nguyenthuan2704/multi-worker:latest

docker push nguyenthuan2704/multi-client:$SHA
docker push nguyenthuan2704/multi-server:$SHA
docker push nguyenthuan2704/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nguyenthuan2704/multi-server:$SHA
kubectl set image deployments/client-deployment client=nguyenthuan2704/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nguyenthuan2704/multi-worker:$SHA