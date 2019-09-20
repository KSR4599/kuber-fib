#Build the Images
docker build -t ksreddy4599/fibonacci-client:latest -t ksreddy4599/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t ksreddy4599/fibonacci-server:latest -t ksreddy4599/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t ksreddy4599/fibonacci-worker:latest -t ksreddy4599/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

#Push the images to Docker Hub
docker push ksreddy4599/fibonacci-client:latest
docker push ksreddy4599/fibonacci-server:latest
docker push ksreddy4599/fibonacci-worker:latest

docker push ksreddy4599/fibonacci-client:$SHA
docker push ksreddy4599/fibonacci-server:$SHA
docker push ksreddy4599/fibonacci-worker:$SHA

#Apply the kubectl to all the images in the k8's directory
kubectl apply -f k8s
#Execute the imperative set image command
kubectl set image deployments/server-deployment server=ksreddy4599/fibonacci-server:$SHA
kubectl set image deployments/client-deployment client=ksreddy4599/fibonacci-client:$SHA
kubectl set image deployments/worker-deployment worker=ksreddy4599/fibonacci-worker:$SHA

