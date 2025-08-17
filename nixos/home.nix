{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "kapi";
  home.homeDirectory = "/home/kapi";

  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  home.packages = with pkgs; [gh go starship];
  programs.git.enable = true;

  programs.neovim = {
    enable = true;
  };

  programs.zen-browser.enable = true;
  programs.zen-browser.policies = {
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

  home.stateVersion = "25.05"; # set once for new setups
}
