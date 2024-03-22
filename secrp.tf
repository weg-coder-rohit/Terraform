resource "aws_key_pair" "Main_terra_key" {
  key_name   = "main-key"
  public_key = file("./main-key.pub")
}