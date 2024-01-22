data "aws_key_pair" "key1" {
  key_name           = "my-keys"
  include_public_key = false
}