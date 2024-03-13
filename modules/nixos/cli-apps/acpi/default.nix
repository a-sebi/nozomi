{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.cli-apps.acpi;
in {
  options.nozomi.cli-apps.acpi = with types; {
    enable =
      mkBoolOpt false "Whether to enable acpi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [acpi];
  };
}
