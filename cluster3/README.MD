
export my_zone=us-central1-a
export my_cluster=standard-cluster-1
source <(kubectl completion bash)
gcloud container clusters get-credentials $my_cluster --zone $my_zone

# Create a html inside the pod and write the content of the file
kubectl exec -it pvc-demo-pod -- sh
echo Test webpage in a persistent volume!>/var/www/html/index.html
chmod +x /var/www/html/index.html
cat /var/www/html/index.html

# Delete Pod
kubectl delete pod pvc-demo-pod 

# Create StatefulSets with PVCs
kubectl delete pod pvc-demo-pod
kubectl get pods
kubectl apply -f statefulset-demo.yaml 
kubectl describe statefulset statefulset-demo
kubectl describe pvc hello-web-disk-statefulset-demo-0
