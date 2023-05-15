{ config, lib, pkgs, ... }:

with lib;

let
  # the values of the options set for the service by the user of the service
  cfg = config.services.ngrok;
in

{
  ##### interface. here we define the options that users of our service can specify
  options = {
    # the options for our service will be located under services.ngrok
    services.ngrok = { 
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable ngrok.
        '';
      };

      configFile = mkOption {
        type = types.str;
        default = "";
        example = "/home/user/config./ngrok/ngrok.yml";
        description = ''
          Path to ngrok.yml.
        '';
      };

      args = mkOption {
        default = [];
        type = types.listOf types.str;
        example = literalExpression ''
          [ "tcp" "22" ]
        '';
        description = lib.mdDoc ''
          Command line arguments for ngrok.
        '';
      };

      user = mkOption {
        type = types.str;
        default = "ngrok";
        example = "user";
      };

      group = mkOption {
        type = types.str;
        default = "ngrok";
        example = "users";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.ngrok;
        defaultText = literalExpression "pkgs.ngrok";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.ngrok = {
      description = "ngrok client";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        ExecStart = [
          #"" # this hides/overrides what's in the original entry
          # TODO escape args for shell
          "${cfg.package}/bin/ngrok --config ${cfg.configFile} ${lib.concatStringsSep " " cfg.args}"
        ];
      };

    };

    users.users = optionalAttrs (cfg.user == "ngrok") {
      ngrok = {
        group = cfg.group;
        #home = cfg.settings.data-dir;
        isSystemUser = true;
        description = "Daemon user for ngrok";
      };
    };

    users.groups = optionalAttrs (cfg.group == "ngrok") {
      ngrok = {};
    };

  };

}
