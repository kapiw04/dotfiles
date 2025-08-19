{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.username = "kapi";
  home.homeDirectory = "/home/kapi";
  home.stateVersion = "25.05";

  imports = [inputs.zen-browser.homeModules.twilight];

  home.packages = with pkgs; [gh go starship tree];

  programs = {
    git.enable = true;
    neovim.enable = true;
    waybar.enable = true;

    zen-browser = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisableAppUpdate = true;
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4552124/bitwarden_password_manager-2025.7.1.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
  };
}
