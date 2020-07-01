provider "aws" { 

  region = var.region
} 

 

data "aws_eks_cluster" "cluster" { 

  name = module.my-cluster.cluster_id 

} 

 

data "aws_eks_cluster_auth" "cluster" { 

  name = module.my-cluster.cluster_id 

} 

 

provider "kubernetes" { 

  host = data.aws_eks_cluster.cluster.endpoint 

  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data) 

  token = data.aws_eks_cluster_auth.cluster.token 

  load_config_file = false 

  version = "~> 1.9" 

} 

 

module "my-cluster" { 

  source = "terraform-aws-modules/eks/aws" 

   version = "12.0.0" 

  cluster_name = "my-cluster" 

  cluster_version = "1.14" 

  subnets = var.subnets                       #["subnet-0df79354ea7cf7e0c", "subnet-0117e75641ab3f5ab", "subnet-022f5252eab5a1578"] 

  vpc_id = var.vpc_id                        #"vpc-05178695db88f9a49" 

  tags = var.tags
  
  worker_groups = [{ 

    instance_type = var.instance_type                 #"m4.large" 

    asg_max_size = var.asg_max_size                # 5

    } 

  ] 

} 