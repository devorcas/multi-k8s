docker build -t pavlovelykyi/multi-client:latest -t pavlovelykyi/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t pavlovelykyi/multi-server:latest -t pavlovelykyi/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t pavlovelykyi/multi-worker:latest -t pavlovelykyi/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push pavlovelykyi/multi-client:latest
docker push pavlovelykyi/multi-server:latest
docker push pavlovelykyi/multi-worker:latest

docker push pavlovelykyi/multi-client:$GIT_SHA
docker push pavlovelykyi/multi-server:$GIT_SHA
docker push pavlovelykyi/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pavlovelykyi/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=pavlovelykyi/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=pavlovelykyi/multi-worker:$GIT_SHA