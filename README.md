# N5-challenge
* challenge to create a mini kubernetes cluster using Minikube provider integrating Helm and Terraform
### Requirements

* Terraform
* Helm
* Helmfile
* Helm secrets
* Helm Diff
* MiniKube
* Kubectl

* The secret variable is `GLOBAL_SECRET`, within the cluster it can be viewed with an `echo $GLOBAL_SECRET` and the environment variable is `env_name`, both should show the environment that was deployed 

#### Usage

* Clone the repository and run the following commands to run the infrastructure:

```minikube start``` to start the provider
```Terraform init``` Terraform command to start the providers configuration in terraform and configure the workspace
```terraform plan``` Command to start the code compilation and show an output of what you want to apply
```terraform apply``` Command to apply the infrastructure and create the minicluster


Ejemplo de main.tf

```hcl
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}


provider "kubernetes" {
  config_context_cluster   = "minikube"
  config_path = "~/.kube/config"
}


resource "helm_release" "example" {
  name  = "helm-${var.releaseName}-challenge"
  chart = "challenge/"

  values = [
    file("challenge/env/${var.releaseName}/values.yaml"),
  ]
}
```

* to change the environment you just have to change the releaseName variable from "dev" or "prod" in the file ``` variables.tf```

* Once the infrastructure is created, we can test it using the IP that minikube gives us plus the assigned port


