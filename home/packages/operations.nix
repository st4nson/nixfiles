{ config, pkgs, ... }:

{
  # DevOps, Cloud, Containers & VM tools
  home.packages = with pkgs; [
    # Cloud providers
    awscli2

    # Container tools
    colima
    dive
    docker-client
    docker-compose
    docker-credential-helpers
    docker-ls

    # Kubernetes tools
    k2tf
    k9s
    kind
    krew
    kubectl
    kubectx
    kubernetes-helm
    kustomize_3
    skaffold

    # Rego
    regal

    # Infrastructure as Code
    # The following are disabled by default. Uncomment when needed:
    # ansible        # Configuration management
    # ansible-lint   # Ansible best practices checker
    # terraform      # Infrastructure provisioning
    terraform-docs   # Terraform documentation generator
    terraform-ls     # Terraform language server
    tflint           # Terraform linter

    # Virtualization
    # qemu           # Hardware emulator (disabled - large dependency)
  ];
}
