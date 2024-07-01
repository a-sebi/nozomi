{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.virtualisation.kvm;
  user = config.${namespace}.user;
in {
  options.${namespace}.virtualisation.kvm = with types; {
    enable = mkBoolOpt false "Whether or not to enable KVM virtualisation.";
    platform =
      mkOpt (enum ["amd" "intel"]) "amd"
      "Which CPU platform the machine is using.";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelModules = [
        "kvm-${cfg.platform}"
      ];
    };

    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        extraConfig = ''
          user="${user.name}"
        '';

        onBoot = "ignore";
        onShutdown = "shutdown";
      };
    };

    nozomi = {
      user = {extraGroups = ["libvirtd" "disk"];};
    };
  };
}
