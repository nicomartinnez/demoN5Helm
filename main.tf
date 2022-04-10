provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}


provider "kubernetes" {
  config_context_cluster   = "minikube"
  config_path = "~/.kube/config"
}

data "external" "helm-secrets" {
  program = ["helm", "secrets", "terraform", "demon5/secrets-${var.env}-enc.yaml"]
}


resource "helm_release" "demon5" {
  name  = "helm-${var.env}-challenge"
  chart = "demon5/"

  values = [
    file("demon5/values-${var.env}.yaml"),
    base64decode(data.external.helm-secrets.result.content_base64),
  ]
}

