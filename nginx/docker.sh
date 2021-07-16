#!/bin/sh

docker build -t tkaburagi/nginx-1 first-container
docker tag tkaburagi/nginx-1 gcr.io/se-kabu/nginx-1
docker push gcr.io/se-kabu/nginx-1

docker build -t tkaburagi/nginx-2 second-container
docker tag tkaburagi/nginx-2 gcr.io/se-kabu/nginx-2
docker push gcr.io/se-kabu/nginx-2

docker build -t tkaburagi/nginx-3 third-container
docker tag tkaburagi/nginx-3 gcr.io/se-kabu/nginx-3
docker push gcr.io/se-kabu/nginx-3