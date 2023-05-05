{ config, pkgs, ... }:
let
  hugo-build = pkgs.writeShellApplication {
    name = "hugo-build";
    runtimeInputs = with pkgs; [ git hugo ];
    text = ''
      git pull --recurse-submodules
      hugo
    '';
  };
in
{
  services.webhook = {
    enable = true;
    hooksTemplated = {
      hugo-webhook = ''
        {
          "id": "hugo-webhook",
          "command-working-directory": "/srv/web/raroh73.xyz",
          "execute-command": "${hugo-build}/bin/hugo-build",
          "trigger-rule": {
            "and": [
              {
                "match": {
                  "type": "payload-hmac-sha1",
                  "secret": "",
                  "parameter": {
                    "source": "header",
                    "name": "X-Hub-Signature"
                  }
                }
              },
              {
                "match": {
                  "type": "value",
                  "value": "refs/heads/main",
                  "parameter": {
                    "source": "payload",
                    "name": "ref"
                  }
                }
              }
            ]
          }
        }
      '';
    };
  };
}
