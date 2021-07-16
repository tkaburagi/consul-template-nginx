#!/usr/bin/env bash

### Docker
sudo apt-get -y update
sudo apt-get -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get -y install docker-ce docker-ce-cli containerd.io

### Consul-template
sudo apt-get -y install unzip
curl "${ct_url}" --output ~/ct.zip
sudo unzip ~/ct.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/consul-template
rm ~/ct.zip


sudo tee /etc/nginx/nginx.conf.ctvmpl <<EOF
http {
	upstream backend {
	{{ range service "nginx" }}
	  server {{ .Address }}:{{ .Port }};
	{{ end }}
	}

    server {
        listen       80;
        server_name  localhost;

	   location / {
	      proxy_pass http://backend;
	   }
	}
}
events{
}
EOF

tee ~/consul-template-config.hcl <<EOF
consul {
  address = "${consul_url}"
  retry {
  enabled = true
  attempts = 12
  backoff = "250ms"
  }}

template {
  source      = "/etc/nginx/nginx.conf.ctvmpl"
  destination = "/etc/nginx/nginx.conf"
  perms = 0600
  command = "sudo nginx -s reload"
}
EOF