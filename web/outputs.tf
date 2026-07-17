output "ssh_private_key_file" {
  value = "${path.module}/id_rsa_web.pem"
}

output "key_name" {
  value = aws_key_pair.ssh_key.key_name
}

output "instance_public_ip" {
  value = aws_instance.server.public_ip
}
