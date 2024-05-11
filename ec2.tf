# EC2 public server
resource "aws_instance" "ecomm-web-server" {
  ami           = "ami-0e001c9271cf7f3b9" # Ubuntu AMI & Amazon AMI ami-04ff98ccbfa41c9ad
  instance_type = "t2.micro"
  subnet_id = aws_subnet.ecomm-web-sn.id
  key_name = "7am"
  vpc_security_group_ids = [aws_security_group.ecomm-web-sg.id]
  user_data = file("ecomm.sh")

  tags = {
    Name = "ecomm-web-server"
  }
}
