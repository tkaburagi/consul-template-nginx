```shell script
gcloud container clusters create lab-cluster \
 --num-nodes=3 \
 --zone us-central1-c

gcloud container clusters resize lab-cluster \
    --node-pool default-pool \
    --num-nodes 0 \
    --zone us-central1-c
```

```shell script
helm install -f consul.yaml consul-template-demo hashicorp/consul --wait
```

* Retrive consul-ui's public ip 
* Replace `variables.tf`

```shell script
terraform apply
```

```shell script
./deploy.sh
```

```shell script
kubectl get svc
```

Replace IPs
* `nginx/first-container/first.yaml`
* `nginx/second-container/second.yaml`

SSH to GCE
```
sudo consul-template -config=consul-template-config.hcl -log-level=debug
```

```shell script
curl -X PUT --data-binary @/Users/kabu/hashicorp/consul/consul-template-demo/nginx/first-container/regist.json http://34.132.129.62/v1/agent/service/register

curl -X PUT --data-binary @/Users/kabu/hashicorp/consul/consul-template-demo/nginx/second-container/regist.json http://34.132.129.62/v1/agent/service/register
```

Browse Nginx: `http://35.200.15.197`

Confirm: 

```
Hello Consul From First Container
```

```
Hello Consul From Second Container
```

See GCE Log

## Scale out

```shell script
kubectl apply -f nginx/third-container/third.yaml
```

Replace IP
* `nginx/third-container/third.yaml`

```shell script
curl -X PUT --data-binary @/Users/kabu/hashicorp/consul/consul-template-demo/nginx/third-container/regist.json http://34.132.129.62/v1/agent/service/register
```

Browse Nginx: `http://35.200.15.197`

Confirm: 

```
Hello Consul From First Container
```

```
Hello Consul From Second Container
```

```
Hello Consul From Third Container
```

See GCE Log