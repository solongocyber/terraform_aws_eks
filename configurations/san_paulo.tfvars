region  = "sa-east-1"

subnets = [
    "subnet-c8d06eae", 
    "subnet-0ff04c46",
    "subnet-6f60e534"
    ] 

vpc_id = "vpc-b70805d0" 

instance_type = "m4.large" 

asg_max_size = 5 




# Below code is used to set backend only
environment                     =   "solongo"
s3_bucket                       =   "april-solongo-bucket"
s3_folder_project               =   "terraform"
s3_folder_region                =   "us-east-1"
s3_folder_type                  =   "tools"
s3_tfstate_file                 =   "eks.tfstate"

tags = {
    Env                 = "Development"    # key and 2 values same together called "mapping"
    Billing             = "SMA"
    Application         = "Terraform"
    Region              = "sa-east-1"
    Created_by           = "Solongo"
    Team                = "DevOps"
    Class               = "April"
    tag                 = "2nd"
    Name                = "terraform"
}




# # key and 2 values same together bval  called "mapping"  exp:tags  2 values with = bval mapping
# Key and value bval called "String"               # / s3_bucket = "bucket-name"
#true and false bval called "boolean"             # associated_public_ip  = true false
#list name,name bval called "list"                # security_group [web1,web2]