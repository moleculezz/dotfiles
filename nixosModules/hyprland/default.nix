{ pkgs, lib, config, inputs, userSettings, ... }:
{
  options.my = {
    hyprland.enable = 
      lib.mkEnableOption "Enable My Hyprland";
  };

  config = lib.mkIf config.my.hyprland.enable {
    
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = with pkgs; [
      inputs.sddm-sugar-catppuccin.packages.${pkgs.system}.default
    ];

    services.displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      theme = "sugar-catppuccin";  
    };
    
    home-manager.users.${userSettings.username} = {
      home.file.".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland.conf;
      
      home.packages = with pkgs; [
        rofi-wayland
        cliphist
        swaynotificationcenter
      ];
    };
  };

}
