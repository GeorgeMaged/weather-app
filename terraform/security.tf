resource "aws_security_group" "eks_cluster_sg" {
  name = "eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "eks-cluster-sg"
  }
}

resource "aws_security_group" "eks_node_group_sg" {
  name = "eks-node-group-sg"
  description = "Security group for EKS node group"
  vpc_id = aws_vpc.main.id
}
resource "aws_security_group_rule" "eks_node_group_ingress" {
  security_group_id = aws_security_group.eks_node_group_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks_node_group_egress" {
  security_group_id = aws_security_group.eks_node_group_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}        