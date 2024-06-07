# ssm validation urls

# cdn dns name 


output "private_key" {
  value     = tls_private_key.rsa.private_key_pem
  sensitive = true
}
