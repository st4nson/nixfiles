{ config, pkgs, lib, ... }:

{
  # DevOps, Cloud, Containers & VM tools
  home.packages = with pkgs; [
    # Cloud providers
    awscli2
    (azure-cli.withExtensions [ azure-cli.extensions.azure-devops ])

    # Container tools
    dive
    docker-buildx
    docker-client
    docker-compose
    docker-credential-helpers
    docker-ls

    # Kubernetes tools
    k2tf
    k9s
    kind
    krew
    kube-linter
    kubectl
    kubectx
    kubelogin
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
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # macOS-only: Docker daemon via Lima VM. Pointless on Linux which
    # has native Docker.
    colima
  ];
}
