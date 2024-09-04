# main.tf

resource "aws_instance" "demo_server" {

  ami           = "ami-066784287e358dad1"
  instance_type = "t3.nano"

  key_name = "awslabs"

  tags = {
    Name    = "demo_server_httpd"
    purpose = "terraform_checks_demo"
    author  = "amod.kadam"
  }

  user_data = file("user-data.sh")

}

# main.tf - added the check block
# check apache status
check "check_apache_status" {
  data "http" "apache" {
    url = "http://${aws_instance.demo_server.public_ip}"
  }

  assert {
    condition     = data.http.apache.status_code == 200
    error_message = "Appache  response is ${data.http.apache.status_code}"
  }
}