# Define AWS provider configurations for different regions
provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

# Additional provider configurations with aliases for different regions
provider "aws" {
  region     = "us-east-2"
  alias      = "us-east-2"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

provider "aws" {
  region     = "us-west-1"
  alias      = "us-west-1"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

provider "aws" {
  region     = "us-west-2"
  alias      = "us-west-2"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

provider "aws" {
  region     = "ap-south-1"
  alias      = "ap-south-1"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

# Define a variable for the number of nodes
variable "node_count"{
  type=number
  default="1"
}

# Define resources for AWS instances in different regions
resource "aws_instance" "node_us_east_1" {
  provider      = aws
  count = var.node_count
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"

  tags = {
    Name = "node"
  }
}

resource "aws_instance" "node_us_east_2" {
  provider      = aws.us-east-2
  ami           = "ami-05fb0b8c1424f266b"
  count = var.node_count
  instance_type = "t2.micro"

  tags = {
    Name = "node"
  }
}

resource "aws_instance" "node_us_west_1" {
  provider      = aws.us-west-1
  ami           = "ami-0ce2cb35386fc22e9"
  count = var.node_count
  instance_type = "t2.micro"

  tags = {
    Name = "node"
  }
}

resource "aws_instance" "node_us_west_2" {
  provider      = aws.us-west-2
  ami           = "ami-008fe2fc65df48dac"
  count = var.node_count
  instance_type = "t2.micro"

  tags = {
    Name = "node"
  }
}

resource "aws_instance" "node_ap_south_1" {
  provider      = aws.ap-south-1
  ami           = "ami-03f4878755434977f"
  count       = var.node_count
  instance_type = "t2.micro"

  tags = {
    Name = "node"
  }
}

# Define a local file resource to store node details
resource "local_file" "nodes_details" {
  filename = "${path.module}/nodes_details.txt"
  content  = <<-EOF
    Node 1 - Name: ${aws_instance.node_us_east_1[0].tags["Name"]}, Node ID: ${aws_instance.node_us_east_1[0].id}, Region: ${aws_instance.node_us_east_1[0].availability_zone}, Zone: ${aws_instance.node_us_east_1[0].availability_zone}, Cloud: AWS
    Node 2 - Name: ${aws_instance.node_us_east_2[0].tags["Name"]}, Node ID: ${aws_instance.node_us_east_2[0].id}, Region: ${aws_instance.node_us_east_2[0].availability_zone}, Zone: ${aws_instance.node_us_east_2[0].availability_zone}, Cloud: AWS
    Node 3 - Name: ${aws_instance.node_us_west_1[0].tags["Name"]}, Node ID: ${aws_instance.node_us_west_1[0].id}, Region: ${aws_instance.node_us_west_1[0].availability_zone}, Zone: ${aws_instance.node_us_west_1[0].availability_zone}, Cloud: AWS
    Node 4 - Name: ${aws_instance.node_us_west_2[0].tags["Name"]}, Node ID: ${aws_instance.node_us_west_2[0].id}, Region: ${aws_instance.node_us_west_2[0].availability_zone}, Zone: ${aws_instance.node_us_west_2[0].availability_zone}, Cloud: AWS
    Node 5 - Name: ${aws_instance.node_ap_south_1[0].tags["Name"]}, Node ID: ${aws_instance.node_ap_south_1[0].id}, Region: ${aws_instance.node_ap_south_1[0].availability_zone}, Zone: ${aws_instance.node_ap_south_1[0].availability_zone}, Cloud: AWS
  EOF
}
