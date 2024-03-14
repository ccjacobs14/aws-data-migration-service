resource "aws_iam_role" "dms-vpc-role" {
  name        = "dms-vpc-role"
  description = "Allows DMS to manage VPC"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "dms.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example" {
  role       = aws_iam_role.dms-vpc-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
}

resource "aws_dms_replication_subnet_group" "example" {
  replication_subnet_group_description = "Example"
  replication_subnet_group_id          = "example-id"

  subnet_ids = [
    "subnet-092fca85a65d918b4", "subnet-049d30fed605f203a", "subnet-012d59cf9fc4ba809",
    "subnet-0267bf834b30dc483", "subnet-0d58bb9cc2b7c619d", "subnet-01fee161a29bcfbf0"
  ]

  tags = {
    Name = "example-id"
  }

  # explicit depends_on is needed since this resource doesn't reference the role or policy attachment
  depends_on = [aws_iam_role_policy_attachment.example]
}
