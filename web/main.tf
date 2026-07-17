#ec2

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/id_rsa_web.pem"
  file_permission = "0600"
}

resource "aws_instance" "server" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t3.micro"
  subnet_id              = var.sn
  vpc_security_group_ids = [var.sg]
  key_name               = aws_key_pair.ssh_key.key_name

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "test"
  }
}