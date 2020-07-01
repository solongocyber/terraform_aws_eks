# aws_eks_cluster

The module provisions the following resources:

EKS cluster of master nodes that can be used together with the terraform-aws-eks-workers, terraform-aws-eks-node-group and terraform-aws-eks-fargate-profile modules to create a full-blown cluster
IAM Role to allow the cluster to access other AWS services
Security Group which is used by EKS workers to connect to the cluster and kubelets and pods to receive communication from the cluster control plane
The module creates and automatically applies an authentication ConfigMap to allow the wrokers nodes to join the cluster and to add additional users/roles/accounts
NOTE: The module works with Terraform Cloud.

NOTE: In auth.tf, we added ignore_changes = [data["mapRoles"]] to the kubernetes_config_map for the following reason:

We provision the EKS cluster and then the Kubernetes Auth ConfigMap to map additional roles/users/accounts to Kubernetes groups
Then we wait for the cluster to become available and for the ConfigMap to get provisioned (see data "null_data_source" "wait_for_cluster_and_kubernetes_configmap" in examples/complete/main.tf)
Then we provision a managed Node Group
Then EKS updates the Auth ConfigMap and adds worker roles to it (for the worker nodes to join the cluster)
Since the ConfigMap is modified outside of Terraform state, Terraform wants to update it (remove the roles that EKS added) on each plan/apply
If you want to modify the Node Group (e.g. add more Node Groups to the cluster) or need to map other IAM roles to Kubernetes groups, set the variable kubernetes_config_map_ignore_role_changes to false and re-provision the module. Then set kubernetes_config_map_ignore_role_changes back to true.

Usage
IMPORTANT: The master branch is used in source just as an example. In your code, do not pin to master because there may be breaking changes between releases. Instead pin to the release tag (e.g. ?ref=tags/x.y.z) of one of our latest releases.

For a complete example, see examples/complete.

For automated tests of the complete example using bats and Terratest (which tests and deploys the example on AWS), see test.

