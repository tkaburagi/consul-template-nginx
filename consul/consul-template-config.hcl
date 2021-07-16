consul {
  address = "127.0.0.1"
  retry {
  enabled = true
  attempts = 12
  backoff = "250ms"
  }}

template {
  source      = "/usr/local/etc/nginx/nginx.conf.ctvmpl"
  destination = "/usr/local/etc/nginx/nginx.conf"
  perms = 0600
  command = "sudo nginx -s reload"
}