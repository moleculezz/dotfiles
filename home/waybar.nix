{ pkgs, config, lib, ... }:

{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";
      height = 24;

      modules-left = [ "hyprland/window" ];
      modules-center = [ "network" "pulseaudio" "cpu" "memory" "disk" "clock" ];
      modules-right = [ "idle_inhibitor" "custom/notification" "battery" "tray" ];
      "hyprland/workspaces" = {
      	format = "{icon}";
      	format-icons = {
          default = " ";
          active = " ";
          urgent = " ";
      	};
      	on-scroll-up = "hyprctl dispatch workspace e+1";
      	on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "clock" = {
        format = "{:  %I:%M %p}";
      	tooltip = false;
      };
      "hyprland/window" = {
      	max-length = 25;
      	separate-outputs = false;
      };
      "memory" = {
      	interval = 5;
      	format = "  {}%";
        tooltip = true;
      };
      "cpu" = {
      	interval = 5;
      	format = "  {usage:2}%";
        tooltip = true;
      };
      "disk" = {
        format = "  {free}";
        tooltip = true;
      };
      "network" = {
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-ethernet = " {bandwidthDownOctets}";
        format-wifi = "{icon}  {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
      };
      "tray" = {
        spacing = 12;
      };
      "pulseaudio" = {
        format = "{icon}  {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "  {volume}%";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
            activated = " ";
            deactivated = " ";
        };
        tooltip = "true";
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} {}";
        format-icons = {
          notification = " <span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = " <span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = " <span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = " <span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
       	};
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t";
        escape = true;
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        on-click = "";
        tooltip = false;
      };
    }];
  };
}
