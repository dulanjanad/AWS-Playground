resource "aws_instance" "worker_nodes" {

  count = var.worker_nodes_count

  ami                    = var.ubuntu_ami
  instance_type          = var.worker_node_instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_traffice.id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    "Name"        = "worker-node-${count.index}.example.com"
    "Environment" = "Dev"
  }

}

resource "aws_instance" "control_node" {

  ami                    = var.ubuntu_ami
  instance_type          = var.control_node_instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_traffice.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    "Name"        = "control-node.example.com"
    "Environment" = "Dev"
  }

}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIYLxLtWVp/gFXVCsswSG9Ez9QXIgxNnOWaJGlJTyUysabQZEgO7mjWVPcHIGoA+H0CbE/kRsitsNrlTWnPrCXQbQ/2MwSx4EgcOfMdn4Urgw94bzGqrNsDqoAiI+X2ofg1mkn7Q2wKY8gaG8f3/GDZnCSqEsjAHepNqd2CZn0nkg53mwqcsXjUSUPAIMQlKIOfILvIXP2rEZVDWeW4mxY/KnWP2J2UAK9EkYawPZAJPqbN8fDgFTpkKmNhGmA73qMeW4hn/7DN8227OA0aKQshAwJfuaOgTkxDeiE0HDUeLPhfyDP8yw+6jnbg94gEW7tT71AyvCmU9BW1MwJ+prWpibONqf0/NUHuajtZHNLqN+toFcVvtH5cWqTPy3qiziC9GsR7JJ44evXaCZ2/80k5oUGvcR2ZwtkWeueqECIsjk00yOjzDYBXylj8Z6Z6hypkdI2FTN2+0LAfFG7KOXUpus3GVALUkd5fNohV9vLvcoYsnG9YV4SbUDGldJ3cOs="
}