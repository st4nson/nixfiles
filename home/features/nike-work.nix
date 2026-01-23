{ config, ... }:

# Nike work-host features.
#
# Imported only by hosts where the user works for Nike (currently:
# hosts/work.nix). Anything Nike-specific (AWS profile, paths under
# ~/nikedev, rebuild aliases targeting the work flake output) belongs
# here so the shared home/ tree stays portable across hosts.

let
  nixfilesPath = "${config.home.homeDirectory}/git/nixfiles";
in
{
  programs.zsh.shellAliases = {
    nix-build-work  = "pushd ${nixfilesPath}; darwin-rebuild build --flake '.#work'; popd";
    nix-switch-work = "pushd ${nixfilesPath}; sudo darwin-rebuild switch --flake '.#work'; popd";
  };

  programs.zsh.sessionVariables = {
    AWS_PROFILE  = "nmk-test";
    AWS_REGION   = "us-west-2";
    KUBECACHEDIR = "${config.home.homeDirectory}/nikedev/kubectl-cache";
  };
}
